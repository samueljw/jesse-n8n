# Use official n8n image
FROM n8nio/n8n:latest

# Set working directory
WORKDIR /home/node/.n8n

# Expose the port
EXPOSE 5678

# Load env variables from .env file
ENV N8N_PORT=5678

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
    CMD node -e "require('http').get('http://localhost:5678/api/v1/health', (r) => {if (r.statusCode !== 200) throw new Error(r.statusCode)})"

# Start n8n
CMD ["n8n", "start"]