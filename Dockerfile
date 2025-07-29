FROM --platform=$BUILDPLATFORM node:22-alpine

LABEL maintainer="Vishal Kumar <vishal194kumar@gmail.com"
LABEL base.image="node:22-alpine"

# Install essential tools and Chromium (minimal dependencies)
RUN apk add --no-cache \
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
    npm install -g pm2 && \
    rm -rf /root/.npm /root/.cache /var/cache/apk/* /usr/share/man /tmp/*

# Set chromium path for puppeteer compatibility
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium \
    CHROME_BIN=/usr/bin/chromium
