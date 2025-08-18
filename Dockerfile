# Use the official Node.js image as the base image
FROM node:20

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies for both the backend and frontend
RUN npm install

# Copy the entire project to the working directory
COPY . .

# Build the frontend for production
RUN npm run build

# Expose the port the app runs on
EXPOSE 5000

# Run the production start command
CMD ["npm","start"]

