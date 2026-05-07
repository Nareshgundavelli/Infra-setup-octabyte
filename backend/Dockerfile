
FROM node:18-alpine

WORKDIR /opt/app

# Upgrade packages to fix security vulnerabilities
RUN apk update && apk upgrade --no-cache

COPY package*.json ./

RUN npm install

RUN npm install -g pm2

COPY . .

EXPOSE 5000

CMD ["pm2-runtime", "server.js", "--name", "backend-app"]
