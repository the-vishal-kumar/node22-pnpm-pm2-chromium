# 🐳 Node 22 + pnpm + pm2 + Chromium (Alpine) – Multi-Arch, Slim Docker Base Image

[![Docker Pulls](https://img.shields.io/docker/pulls/thevishalkumar/node22-pnpm-pm2-chromium.svg)](https://hub.docker.com/r/thevishalkumar/node22-pnpm-pm2-chromium)
[![Image Size](https://img.shields.io/docker/image-size/thevishalkumar/node22-pnpm-pm2-chromium/latest)](https://hub.docker.com/r/thevishalkumar/node22-pnpm-pm2-chromium)
[![GitHub Repo](https://img.shields.io/badge/GitHub-View%20Source-black?logo=github)](https://github.com/the-vishal-kumar/node22-pnpm-pm2-chromium)

> Minimal, multi-platform (amd64 + arm64) and production-ready Docker base image built on top of `node:22-alpine`, with `pnpm` (via Corepack), `pm2`, and headless `Chromium` preinstalled.  
> Ideal for full-stack Node.js apps, Puppeteer automation, PDF generation, SSR pipelines, and background workers.

---

## 🔧 What's Included?

- ✅ Node.js `v22` (Alpine)
- ✅ `bash`, `curl`, and Chromium dependencies
- ✅ `corepack` enabled with latest `pnpm`
- ✅ Global `pm2`
- ✅ Headless `Chromium` pre-installed (for Puppeteer, scraping, PDF, etc.)
- ✅ Cleaned and slimmed image layers
- ✅ Multi-arch: `linux/amd64` & `linux/arm64` (Mac M1, EC2 Graviton ready)

---

## 🚀 Use Cases

Perfect base image if your app:
- Uses `pnpm` for dependency management
- Uses `pm2` for clustering or daemon mode
- Uses `puppeteer` with headless Chromium for:
  - PDF generation
  - Crawling/scraping
  - SSR (e.g., Next.js)
- Needs a lightweight, production-ready Node environment

---

## 📦 Example Usage

```Dockerfile
FROM thevishalkumar/node22-pnpm-pm2-chromium:latest

WORKDIR /app

COPY package.json pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile

COPY . .
RUN pnpm run build

CMD ["pm2-runtime", "start", "ecosystem.config.js"]
```

---

## 🛠️ Build Details

```Dockerfile
FROM --platform=$BUILDPLATFORM node:22-alpine

LABEL maintainer="Vishal Kumar <vishal194kumar@gmail.com>"
LABEL base.image="node:22-alpine"

RUN apk add --no-cache \
      bash \
      curl \
      chromium \
      nss \
      freetype \
      harfbuzz \
      ttf-freefont \
      ca-certificates && \
    corepack enable && \
    corepack prepare pnpm@latest --activate && \
    npm install -g pm2 && \
    rm -rf /root/.npm /root/.cache /var/cache/apk/* /usr/share/man /tmp/*

ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium \
    CHROME_BIN=/usr/bin/chromium
```

---

## 🏷️ Available Tags

| Tag              | Description                                             |
| ---------------- | ------------------------------------------------------- |
| `latest`         | Latest stable build (Node 22 + Chromium + pm2 + pnpm)   |
| `22`             | Node.js 22 with pm2 and pnpm                            |
| `22-chromium`    | Node.js 22 + pm2 + pnpm + Chromium headless             |
| `arm64`, `amd64` | Automatically resolved via Docker’s multi-arch manifest |

---

## 🛠️ Build the Image (Multi-Platform)

To build and publish the image for both `amd64` and `arm64` (Apple M1, Graviton, etc.):

```bash
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  -t thevishalkumar/node22-pnpm-pm2-chromium:latest \
  -t thevishalkumar/node22-pnpm-pm2-chromium:22 \
  -t thevishalkumar/node22-pnpm-pm2-chromium:22-chromium \
  --push .
```

> 💡 Requires Docker Buildx: `docker buildx create --use`

---

## 📩 Maintainer

**Vishal Kumar**  
🥇 [AWS Certified Solutions Architect – Professional](https://www.credly.com/badges/27547b76-b136-459f-ab2f-a34cbe43301e)

📧 [vishal194kumar@gmail.com](mailto:vishal194kumar@gmail.com)  
🐙 GitHub: [@the-vishal-kumar](https://github.com/the-vishal-kumar)  
💼 LinkedIn: [@the-vishal-kumar](https://linkedin.com/in/the-vishal-kumar)  
🐦 X: [@the_vishalkr](https://x.com/the_vishalkr)  
📸 Instagram: [@the_vishal_kumar](https://instagram.com/the_vishal_kumar)

[![GitHub followers](https://img.shields.io/github/followers/the-vishal-kumar?label=Follow&style=social)](https://github.com/the-vishal-kumar)  
[![LinkedIn](https://img.shields.io/static/v1.svg?label=LinkedIn&message=Connect&logo=linkedin&style=flat&color=0A66C2)](https://linkedin.com/in/the-vishal-kumar)  
[![X Follow](https://img.shields.io/twitter/follow/the_vishalkr?style=social)](https://x.com/the_vishalkr)  
[![Instagram](https://img.shields.io/static/v1.svg?label=Instagram&message=Follow&logo=instagram&style=social)](https://instagram.com/the_vishal_kumar)

---

🙏 Always building, always learning. Open to collaborations, contributions, and coffee ☕.

---

## 📝 License

MIT – Use it freely in your own projects.

---

## 🤝 Contributions

### 📁 GitHub Repository 🔗 https://github.com/the-vishal-kumar/node22-pnpm-pm2-chromium

Feel free to open issues or PRs if you'd like to suggest improvements or add new versions!
