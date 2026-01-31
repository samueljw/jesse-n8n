# Use official n8n image
FROM n8nio/n8n:latest

# Expose the port n8n uses
EXPOSE 5678

# Set environment for Fly.io - listen on all interfaces
ENV N8N_PORT=5678
ENV N8N_HOST=0.0.0.0

# Health check (exec form - distroless image has no /bin/sh)
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD ["node", "-e", "require('http').get('http://localhost:5678/api/v1/health', r => process.exit(r.statusCode === 200 ? 0 : 1)).on('error', () => process.exit(1));"]

# Run n8n directly (no shell - distroless image has no /bin/sh)
CMD ["n8n", "start"]