# Use official Node.js 20 runtime as base
FROM node:20

# Set working directory
WORKDIR /usr/src/app

# Copy package files first to leverage Docker cache
COPY package*.json ./

# Install dependencies
RUN npm install --production

# Copy the rest of the app source
COPY . .

# Expose the port your app runs on
ENV PORT=8080
EXPOSE $PORT

# Run the application as non-root user for security
USER node

# Start the app
CMD ["node", "index.js"]
