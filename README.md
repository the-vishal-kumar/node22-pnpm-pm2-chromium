# 🐳 Node 22 + pnpm + pm2 + Chromium (Alpine) Docker Base Image

[![Docker Pulls](https://img.shields.io/docker/pulls/thevishalkumar/node22-pnpm-pm2-chromium.svg)](https://hub.docker.com/r/thevishalkumar/node22-pnpm-pm2-chromium)
[![Image Size](https://img.shields.io/docker/image-size/thevishalkumar/node22-pnpm-pm2-chromium/latest)](https://hub.docker.com/r/thevishalkumar/node22-pnpm-pm2-chromium)

> Minimal and production-ready Docker base image built on top of `node:22-alpine`, with `pnpm` (via Corepack), `pm2`, and headless `Chromium` preinstalled. Ideal for full-stack Node.js apps and Puppeteer automation.

---

## 🔧 What's Included?

- ✅ Node.js `v22` (Alpine)
- ✅ `bash`, `curl`, `ttf-freefont`, and other Chromium dependencies
- ✅ `corepack` enabled with latest `pnpm`
- ✅ Global `pm2`
- ✅ Chromium (for Puppeteer)
- ✅ Small, efficient base for full-stack and headless browser apps

---

## 🚀 Use Case

Perfect for apps that:
- Use `pnpm` for dependency management
- Use `pm2` for clustering or daemonized processes
- Need `puppeteer` with Chromium for PDF generation, scraping, or automation
- Run full-stack builds or server-side rendering pipelines (e.g., Next.js with headless Chrome)

---

## 📦 Example Usage

```Dockerfile
FROM thevishalkumar/node22-pnpm-pm2-chromium:latest

WORKDIR /app

COPY package.json pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile

COPY . .
RUN pnpm run build

CMD ["pnpm", "start:pm2"]
```

---

## 🛠️ Build Details

```Dockerfile
FROM node:22-alpine

RUN apk update &&     apk add --no-cache \
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
```

---

## 🏷️ Available Tags

- `latest` – most recent image with Node 22 + Chromium + pm2 + pnpm
- `22` – explicitly points to Node.js 22 series
- `22-chromium` – pinned support for headless Chromium with Puppeteer

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

Feel free to open issues or PRs if you'd like to suggest improvements or add new versions!
