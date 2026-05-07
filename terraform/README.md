# Octabyte Infrastructure Setup

## Project Overview
Frontend: React (on EC2, via ALB)
Backend: Node.js (on EC2, via ALB)
Database: PostgreSQL (RDS)
CI/CD: GitHub Actions
Containerization: Docker
Infrastructure: Terraform

## Features
- Automated GitHub Actions Pipeline
- Docker Build & Push to ECR
- Deploy to EC2 via SSH
- ALB Routing (/api/* to backend)
- RDS PostgreSQL Integration

## Access
- **Frontend:** http://octa-alb-170037906.ap-south-1.elb.amazonaws.com
- **Backend Health:** http://octa-alb-170037906.ap-south-1.elb.amazonaws.com/api/health
- **EC2 Public IP:** 13.233.97.156
- **RDS Endpoint:** my-postgres-db.cnkkua2ykiim.ap-south-1.rds.amazonaws.com
