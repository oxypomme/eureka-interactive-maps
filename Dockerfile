# --- BUILD
FROM node:gallium-alpine AS build

WORKDIR /usr/build

COPY package*.json .
RUN npm ci
COPY . .

RUN npm run build

# --- PROD
FROM nginx:stable-alpine-slim

WORKDIR /usr/share/nginx/html

COPY ./config/ngnix.types /etc/nginx/mime.types
COPY --from=build /usr/build/dist ./

EXPOSE 80
