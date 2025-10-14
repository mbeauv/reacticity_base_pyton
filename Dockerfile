FROM python:3.11-alpine

# Install system dependencies
RUN apk add --no-cache \
    libffi \
    openssl \
    curl \
    git \
    build-base \
    ca-certificates

# Install uv package manager
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

# Set working directory
WORKDIR /app

# Create a non-root user for security
RUN addgroup -g 1001 -S appgroup && \
    adduser -u 1001 -S appuser -G appgroup

# Find where uv was installed and copy it to user's home
RUN UV_INSTALL_DIR=$(find /root -name "uv" -type f 2>/dev/null | head -1 | xargs dirname) && \
    if [ -n "$UV_INSTALL_DIR" ]; then \
        mkdir -p /home/appuser/.local/bin && \
        cp "$UV_INSTALL_DIR/uv" /home/appuser/.local/bin/ && \
        chown -R appuser:appgroup /home/appuser/.local; \
    fi

# Switch to non-root user
USER appuser
ENV PATH="/home/appuser/.local/bin:$PATH"
