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
# --- STAGE 1: Build Stage ---
FROM node:20-slim AS builder

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json first to cache node_modules layer
COPY package*.json ./

# Install dependencies (including devDependencies for building)
RUN npm install

# Copy the rest of the application source
COPY . .

# Build the frontend for production
# Assuming 'npm run build' generates production assets
RUN npm run build

# --- STAGE 2: Production Stage (Smaller runtime image) ---
FROM node:20-slim AS final

# Set the working directory
WORKDIR /app

# Copy only production dependencies (no devDependencies needed for runtime)
COPY package*.json ./
RUN npm install --only=production

# Alternative approach for dependencies (might be cleaner if you can reinstall prod-only):
COPY package*.json ./
RUN npm install --only=production
COPY --from=builder /app .

# Expose the port the app runs on
EXPOSE 5000

# Run the production start command
CMD ["npm", "start"]
```