require('dotenv').config();
const express = require("express");
const cors = require("cors");
const { Pool } = require("pg");

const app = express();
const PORT = 5000;

app.use(cors());
app.use(express.json());

// Request Logger
app.use((req, res, next) => {
  console.log(`[${new Date().toISOString()}] ${req.method} ${req.url}`);
  next();
});

/* =========================
   Health Check (FIRST)
========================= */
app.get("/api/health", (req, res) => {
  console.log("ALB Health Check received");
  res.status(200).send("OK");
});

const fs = require("fs");

/* =========================
   PostgreSQL Connection
========================= */
const poolConfig = {
  user: process.env.DB_USER || "octaadmin",
  host: process.env.DB_HOST || "my-postgres-db.cnkkua2ykiim.ap-south-1.rds.amazonaws.com",
  database: process.env.DB_NAME || "octabytedb",
  password: process.env.DB_PASSWORD || "Octabyte123",
  port: 5432,
};

if (process.env.PGSSLROOTCERT) {
  poolConfig.ssl = {
    rejectUnauthorized: true,
    ca: fs.readFileSync(process.env.PGSSLROOTCERT).toString(),
  };
}

const pool = new Pool(poolConfig);

pool.connect()
  .then(() => console.log("✅ PostgreSQL connected"))
  .catch(err => {
    console.error("❌ PostgreSQL error:", err.message);
    // ❗ DO NOT EXIT
  });

/* =========================
   Create table
========================= */
pool.query(`
  CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    password VARCHAR(100)
  )
`)
  .then(() => console.log("✅ Users table ready"))
  .catch(err => console.error("Table creation error:", err.message));

/* =========================
   APIs
========================= */
app.post("/api/signup", async (req, res) => {
  const { username, email, password } = req.body;
  console.log(`[SIGNUP] Attempt for email: ${email}`);

  try {
    const result = await pool.query(
      "INSERT INTO users (username, email, password) VALUES ($1, $2, $3) RETURNING id",
      [username, email, password]
    );
    console.log(`[SIGNUP] Success! New user ID: ${result.rows[0].id}`);
    res.json({ message: "Signup successful" });
  } catch (err) {
    console.error(`[SIGNUP] Error: ${err.message}`);
    res.status(409).json({ message: "User already exists" });
  }
});

app.post("/api/login", async (req, res) => {
  const { email, password } = req.body;
  console.log(`[LOGIN] Attempt for email: ${email}`);

  try {
    const result = await pool.query(
      "SELECT * FROM users WHERE email=$1 AND password=$2",
      [email, password]
    );

    if (result.rows.length === 0) {
      console.log(`[LOGIN] Failed: Invalid credentials for ${email}`);
      return res.status(401).json({ message: "Invalid credentials" });
    }

    console.log(`[LOGIN] Success! User: ${result.rows[0].username}`);
    res.json({ message: "Login successful" });
  } catch (err) {
    console.error(`[LOGIN] Error: ${err.message}`);
    res.status(500).json({ message: "Internal server error" });
  }
});

/* =========================
   Start Server (LAST)
========================= */
app.listen(PORT, "0.0.0.0", () => {
  console.log(`🚀 Backend running on port ${PORT}`);
});
