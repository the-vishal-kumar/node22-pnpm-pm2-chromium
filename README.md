# 🐳 Node 22 + pnpm + pm2 + Chromium (Alpine) – Multi-Arch, Slim Docker Base Image

[![Docker Pulls](https://img.shields.io/docker/pulls/thevishalkumar/node22-pnpm-pm2-chromium.svg)](https://hub.docker.com/r/thevishalkumar/node22-pnpm-pm2-chromium)
[![Image Size](https://img.shields.io/docker/image-size/thevishalkumar/node22-pnpm-pm2-chromium/latest)](https://hub.docker.com/r/thevishalkumar/node22-pnpm-pm2-chromium)
[![Publish](https://github.com/the-vishal-kumar/node22-pnpm-pm2-chromium/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/the-vishal-kumar/node22-pnpm-pm2-chromium/actions/workflows/docker-publish.yml)
[![Trivy: no fixable CRITICAL](https://img.shields.io/badge/Trivy-no%20fixable%20CRITICAL-brightgreen?logo=aquasecurity)](#-supply-chain-hygiene)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](./LICENSE)
[![GitHub Repo](https://img.shields.io/badge/GitHub-View%20Source-black?logo=github)](https://github.com/the-vishal-kumar/node22-pnpm-pm2-chromium)

> Minimal, multi-platform (amd64 + arm64) and production-ready Docker base image built on top of `node:22-alpine`, with `pnpm` (via Corepack), `pm2`, and headless `Chromium` preinstalled.  
> Ideal for full-stack Node.js apps, Puppeteer automation, PDF generation, SSR pipelines, and background workers.

---

## 🔧 What's Included?

- ✅ Node.js `v22` (Alpine)
- ✅ `bash`, `curl`, and Chromium dependencies
- ✅ `corepack` enabled with a **pinned** `pnpm` (default `12.6.0`, override with `--build-arg PNPM_VERSION=…`), pre-fetched at build time so the first `pnpm` call needs no network
- ✅ Global `pm2`
- ✅ Headless `Chromium` pre-installed (for Puppeteer, scraping, PDF, etc.)
- ✅ Cleaned and slimmed image layers
- ✅ Multi-arch: `linux/amd64` & `linux/arm64` (Mac M1, EC2 Graviton ready)
- ✅ Rebuilt weekly; the amd64 build is smoke-tested and scanned with Trivy in CI before the multi-arch push (see [Supply-chain hygiene](#-supply-chain-hygiene))

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

See the [`Dockerfile`](./Dockerfile). In short: `node:22-alpine`, then `apk add` of `bash`, `curl`, Chromium and its font/NSS dependencies, `corepack enable` with a pinned pnpm, and a global `pm2`. `PUPPETEER_EXECUTABLE_PATH` and `CHROME_BIN` point at `/usr/bin/chromium`.

---

## 🏷️ Available Tags

| Tag | Moves? | Description |
| --- | --- | --- |
| `latest`, `22`, `22-chromium` | Yes, every build | Newest build of Node 22 + pnpm + pm2 + Chromium |
| `<node>-pnpm<pnpm>` e.g. `22.23.4-pnpm12.6.0` | Only on rebuilds of the same versions | Pin the exact Node and pnpm versions |
| `<node>-pnpm<pnpm>-<YYYYMMDD>` e.g. `22.23.4-pnpm12.6.0-20261110` | No | Immutable snapshot of one build; use this for reproducible deploys |
| `v*` (git tag name) | No | Published when a `v*` git tag is pushed |

Every tag is a multi-arch manifest: Docker picks `amd64` or `arm64` for you.

> **Runs as root by default.** Like the official `node` images, this base image doesn't switch user, so your Dockerfile should: add `USER node` after copying your app (and run Chromium without `--no-sandbox` once you do).

> **Note on older `arm64` pulls.** Before the weekly-rebuild change, the `Dockerfile` started with `FROM --platform=$BUILDPLATFORM`, so the `linux/arm64` variant was built from the amd64 base and contained x86-64 binaries. Builds from this version on use the correct base for each platform. If you run on arm64 (Apple Silicon, Graviton), pull a fresh tag.


---

## 🔒 Supply-chain hygiene

The [publish workflow](./.github/workflows/docker-publish.yml) runs on every push to `main`, on `v*` tags, on pull requests (build, test and scan only, no push), and **weekly on a schedule**:

1. **Weekly rebuild** (Mondays, 03:17 UTC) with no layer cache, so patched `node:22-alpine` and Alpine packages land even when this repo doesn't change. GitHub pauses scheduled workflows after 60 days without repository activity; re-enable it from the Actions tab if that happens.
2. **Smoke test.** The amd64 image runs as the non-root `node` user with networking disabled. It checks `node`, `pnpm` and `pm2`, and renders a page with headless Chromium.
3. **Trivy scan.** The amd64 image is scanned before the multi-arch build is pushed; the arm64 variant and the final rebuild aren't scanned separately yet. The build fails on any `CRITICAL` vulnerability that has a fix available. Unfixed upstream CVEs are reported but don't block. The Trivy action is pinned to a commit SHA, not a movable tag.
4. **Versioned tags** derived from the versions actually inside the image (see [Available Tags](#-available-tags)), plus OCI labels for source, revision, license and version.
5. **Least-privilege token.** The workflow token is read-only (`permissions: contents: read`). Docker Hub credentials come from the `DOCKERHUB_USERNAME` and `DOCKERHUB_TOKEN` repository secrets and are never used on pull requests.

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

[MIT](./LICENSE) © 2025-2026 Vishal Kumar. Use it freely in your own projects.

---

## 🤝 Contributions

### 📁 GitHub Repository 🔗 https://github.com/the-vishal-kumar/node22-pnpm-pm2-chromium

Feel free to open issues or PRs if you'd like to suggest improvements or add new versions!
