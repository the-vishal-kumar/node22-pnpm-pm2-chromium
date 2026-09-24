FROM --platform=$BUILDPLATFORM node:22-alpine

LABEL maintainer="Vishal Kumar <vishal194kumar@gmail.com"
LABEL base.image="node:22-alpine"

# Pinned, not "latest": a consuming project's package.json usually pins its
# own packageManager version (e.g. pnpm@12.6.0). If this image activates a
# different version, Corepack detects the mismatch and re-downloads the
# pinned version from the npm registry on every single build with no cache
# layer for it -- one registry hiccup fails the whole build. Baking in the
# same version here means Corepack never needs the network at consumption
# time. Override with --build-arg PNPM_VERSION=x.y.z for a project pinning
# a different version.
ARG PNPM_VERSION=12.6.0

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
    corepack prepare pnpm@${PNPM_VERSION} --activate && \
    npm install -g pm2 && \
    rm -rf /root/.npm /root/.cache /var/cache/apk/* /usr/share/man /tmp/*

# Set chromium path for puppeteer compatibility
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium \
    CHROME_BIN=/usr/bin/chromium
