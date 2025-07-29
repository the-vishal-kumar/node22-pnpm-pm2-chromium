# 🔄 Updating the Docker Image Repository

This repository contains the Docker configuration for the `thevishalkumar/node22-pnpm-pm2-chromium` image.

If you make changes to the `Dockerfile`, update dependencies, or modify supporting files, follow the steps below to ensure the new image is built, tagged, and pushed properly.

---

## 🛠 What You Can Modify

- Update Node.js version (e.g., `node:22-alpine`)
- Change or upgrade base dependencies (e.g., Chromium, pnpm, pm2)
- Modify environment variables or install flags
- Add support scripts (e.g., test, healthcheck)
- Improve or extend `README.md`

---

## 🔧 Steps to Update & Push Manually

1. **Make your changes**
    ```bash
    git pull origin main
    # edit Dockerfile or other files
    ```

2. **Build the updated image**
    ```bash
    docker build -t node22-pnpm-pm2-chromium .
    ```

3. **Tag the image**
    ```bash
    docker tag node22-pnpm-pm2-chromium thevishalkumar/node22-pnpm-pm2-chromium:latest
    docker tag node22-pnpm-pm2-chromium thevishalkumar/node22-pnpm-pm2-chromium:22
    docker tag node22-pnpm-pm2-chromium thevishalkumar/node22-pnpm-pm2-chromium:22-chromium
    ```

4. **Push the tags**
    ```bash
    docker push thevishalkumar/node22-pnpm-pm2-chromium:latest
    docker push thevishalkumar/node22-pnpm-pm2-chromium:22
    docker push thevishalkumar/node22-pnpm-pm2-chromium:22-chromium
    ```

---

## ⚙️ CI/CD Auto Publish (GitHub Actions)

If you've set up GitHub Actions:

- Make sure your changes are committed to the `main` branch.
- GitHub Actions will:
  - Build the updated image
  - Tag it (based on your config)
  - Push to Docker Hub

📝 You can check build status under the [Actions](../../actions) tab.

---

## 💡 Tagging Conventions

| Tag | Meaning |
|-----|---------|
| `latest` | Always points to the most stable build |
| `22` | Node.js 22 series |
| `22-chromium` | Node.js 22 + Chromium-enabled |
| `vX.Y.Z` | (Optional) Semantic versioned release tags |

---

## ✅ Best Practices

- Test the image locally with `docker run` before pushing
- Keep `README.md` and `Dockerfile` in sync
- Use multi-stage builds if size becomes a concern
- Use `.dockerignore` to skip unnecessary files during build
- Use semantic commits or PRs for traceability

---

## 🙋 Need Help?

Reach out to **Vishal Kumar**  
📧 [vishal194kumar@gmail.com](mailto:vishal194kumar@gmail.com)  
Or open an issue in the repo.
