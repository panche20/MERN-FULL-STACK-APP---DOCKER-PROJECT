---

### Run this app with Docker 🐳

This project includes Dockerfiles for both the backend and frontend, plus a `docker-compose.yml` for easy setup.

**Requirements:**
- Docker & Docker Compose installed
- Node.js version: `22.13.1` (used in containers)

**Environment Variables:**
- Backend requires a `.env` file in `./backend` with:
  ```shell
  MONGO_URI=your_mongo_uri
  PORT=5000
  ```
- Frontend does not require environment variables by default

**How to build and run:**

```shell
docker compose up --build
```

**Services & Ports:**
- **js-backend**: http://localhost:5000
- **js-frontend**: http://localhost:4173
- **mongo**: localhost:27017

**Notes:**
- The backend depends on MongoDB. Make sure your `MONGO_URI` points to the `mongo` service (e.g. `mongodb://mongo:27017/your-db-name`).
- For persistent MongoDB data, uncomment the `volumes` section in `docker-compose.yml`.
- All services run as non-root users for security.

---
