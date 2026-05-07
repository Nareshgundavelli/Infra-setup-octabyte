
FROM node:20-alpine

WORKDIR /opt/app

# Upgrade OS packages and npm to fix security vulnerabilities
RUN apk update && apk upgrade --no-cache && \
    npm install -g npm@latest pm2@latest

COPY package*.json ./

RUN npm install --omit=dev

COPY . .

EXPOSE 5000

CMD ["pm2-runtime", "server.js", "--name", "backend-app"]
