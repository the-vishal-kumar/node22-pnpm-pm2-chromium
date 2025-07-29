FROM node:22-alpine

LABEL maintainer="Vishal Kumar <vishal194kumar@gmail.com>"
LABEL base.image="node:22-alpine"

RUN apk update && \
    apk add --no-cache \
      bash \
      curl \
      chromium \
      nss \
      freetype \
      harfbuzz \
      ca-certificates \
      ttf-freefont && \
    corepack enable && \
    corepack prepare pnpm@latest --activate && \
    npm install -g pm2

ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium
