# No --platform=$BUILDPLATFORM here: this is the final (and only) stage, so it
# must use the *target* platform's base image. Pinning it to the build
# platform made the published linux/arm64 variant contain x86-64 binaries.
FROM node:22-alpine

LABEL maintainer="Vishal Kumar <vishal194kumar@gmail.com>"
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

# Keep Corepack's cache outside /root/.cache. The cleanup step below wipes
# /root/.cache, and with the default location it also deleted the activated
# pnpm, so every container silently downloaded the newest pnpm on first use.
# This path survives cleanup and is readable by non-root users (e.g. `node`).
# Running `pnpm --version` once at build time also fetches pnpm's native
# binary into the same place, so the first real `pnpm` call needs no network.
ENV COREPACK_HOME=/usr/local/share/corepack

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
    pnpm --version && \
    chmod -R a+rX "$COREPACK_HOME" && \
    npm install -g pm2 && \
    rm -rf /root/.npm /root/.cache /var/cache/apk/* /usr/share/man /tmp/*

# Set chromium path for puppeteer compatibility
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium \
    CHROME_BIN=/usr/bin/chromium
