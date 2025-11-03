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

# Copy the built assets and the rest of the source from the builder stage
COPY package*.json ./
RUN npm install --only=production
COPY --from=builder /app .

# Expose the port the app runs on
EXPOSE 5000

# Run the production start command
# Use a more explicit form for the CMD if possible
CMD ["npm", "start"]