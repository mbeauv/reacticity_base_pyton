FROM python:3.13-alpine

# Add metadata
LABEL maintainer="mbeauv"
LABEL description="Python 3.13 base image with essential tools"
LABEL version="1.0.0"

# Install system dependencies
RUN apk add --no-cache \
    libffi \
    openssl \
    curl \
    git \
    build-base \
    ca-certificates \
    musl-dev \
    zlib-dev

# Install uv package manager and move to standard location
RUN curl -LsSf https://astral.sh/uv/install.sh | sh && \
    mv /root/.local/bin/uv /usr/local/bin/uv && \
    rm -rf /root/.local && \
    apk del curl

# Verify uv installation
RUN uv --version


