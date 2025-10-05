# Containerization of a MERN app. 🚀

This project is a full-stack MERN (MongoDB, Express.js, React.js, Node.js) application that has been containerized using Docker.
The application allows users to view, create, update, and delete products.

This project was built following a crash course video tutorial on YouTube.

### Tech Stack

-   **Frontend:** React.js, Vite, Chakra UI, Zustand for state management
-   **Backend:** Node.js, Express.js
-   **Database:** MongoDB with Mongoose

### Prerequisites

You need to have Docker and Docker Compose installed on your machine to run this application.

### Setup and Running with Docker

This application uses Docker to containerize the entire MERN stack, including the frontend, backend, and MongoDB database.

1.  **Clone the repository and navigate to the project directory.**
    ```bash
    git clone https://github.com/panche20/MERN-FULL-STACK-APP---DOCKER-PROJECT.git
    cd MERN-FULL-STACK-APP---DOCKER-PROJECT
    ```

2.  **Create a `.env` file.**
    Create a file named `.env` in the root directory of the project with the following content:
    ```
    MONGO_URI=mongodb://mongodb:27017/mern-app
    PORT=5000
    ```
    This configuration tells the backend container where to find the MongoDB container on the Docker network.

3.  **Build and run the Docker containers.**
    From the root directory, execute the following command:
    ```bash
    docker-compose up --build
    ```
    This command will:
    -   Build the Docker image for the backend, which also includes the frontend as it serves the static files.
    -   Pull the latest `mongo` image.
    -   Create and start the `backend` and `mongodb` containers, connecting them on a shared network.

4.  **Access the application.**
    Once the containers are running, the application will be accessible at:
    -   Frontend: `http://localhost:5000`
    -   Backend API: `http://localhost:5000/api/products`

### API Endpoints

The following API endpoints are available:
-   `GET /api/products`: Fetches all products.
-   `POST /api/products`: Creates a new product.
-   `PUT /api/products/:id`: Updates a product by its ID.
-   `DELETE /api/products/:id`: Deletes a product by its ID.

### Docker Files

#### `Dockerfile`
This file is used to build the main Docker image for the application.

```dockerfile
# Stage 1: Build the frontend
FROM node:18-alpine AS frontend-builder
WORKDIR /app/frontend
COPY frontend/package*.json ./
RUN npm install
COPY frontend .
RUN npm run build

# Stage 2: Build the backend and serve the application
FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY backend ./backend
COPY --from=frontend-builder /app/frontend/dist ./frontend/dist
ENV NODE_ENV=production
EXPOSE 5000
CMD ["node", "backend/server.js"]
