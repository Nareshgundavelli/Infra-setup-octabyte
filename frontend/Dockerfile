
FROM node:20 AS build

WORKDIR /opt/app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

FROM nginx:alpine

# Upgrade packages to fix security vulnerabilities (e.g., CVE-2026-27135)
RUN apk update && apk upgrade --no-cache

COPY --from=build /opt/app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

