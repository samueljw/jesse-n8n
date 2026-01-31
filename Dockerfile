# Use full Debian-based n8n image (tag "1") - has /bin/sh and n8n in PATH.
# "latest" is distroless: no shell and "n8n" not in PATH, causing startup failures on Fly.
FROM n8nio/n8n:1

# Expose the port n8n uses
EXPOSE 5678

# Set environment for Fly.io - listen on all interfaces
ENV N8N_PORT=5678
ENV N8N_HOST=0.0.0.0

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD ["node", "-e", "require('http').get('http://localhost:5678/api/v1/health', r => process.exit(r.statusCode === 200 ? 0 : 1)).on('error', () => process.exit(1));"]

# Entrypoint expects: first arg is command (n8n), rest are args. Use "start" only so entrypoint runs: n8n start
CMD ["start"]