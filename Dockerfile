# Use official n8n image
FROM n8nio/n8n:latest

# Expose the port n8n uses
EXPOSE 5678

# Set environment for Fly.io - listen on all interfaces
ENV N8N_PORT=5678
ENV N8N_HOST=0.0.0.0

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD node -e "require('http').get('http://localhost:5678/api/v1/health', (r) => {if (r.statusCode !== 200) throw new Error(r.statusCode)})" || exit 1

# Use the entrypoint from the n8n image and start n8n
CMD ["/bin/sh", "-c", "n8n start"]