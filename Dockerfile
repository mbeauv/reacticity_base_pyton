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
ENV PATH="/root/.cargo/bin:$PATH"

# Set working directory
WORKDIR /app

# Create a non-root user for security
RUN addgroup -g 1001 -S appgroup && \
    adduser -u 1001 -S appuser -G appgroup

# Copy uv to user's home directory and update PATH
RUN cp -r /root/.cargo /home/appuser/ && \
    chown -R appuser:appgroup /home/appuser/.cargo

# Switch to non-root user
USER appuser
ENV PATH="/home/appuser/.cargo/bin:$PATH"
