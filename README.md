# Reacticity Base Python Docker Image

This repository contains a Docker image based on `python:3.13-alpine` with essential system dependencies for Python applications.

## Features

- **Base Image**: `python:3.13-alpine` (lightweight Alpine Linux with Python 3.13)
- **System Dependencies**:
  - `libffi`: Foreign Function Interface library
  - `openssl`: OpenSSL cryptographic library
  - `git`: Version control system
  - `build-base`: Compiler toolchain (gcc, g++, make, etc.)
  - `ca-certificates`: SSL/TLS certificates for HTTPS connections
  - `musl-dev`: Development headers for Alpine's musl libc
  - `zlib-dev`: Compression library development headers
- **Package Manager**: `uv` - Fast Python package manager
- **Flexible Design**: No predefined user or working directory

## Usage

### Building the Image

```bash
docker build -t reacticity-base-python .
```

### Using as Base Image

```dockerfile
FROM mbeauv/reacticity-base-python:latest

# Set working directory for your application
WORKDIR /app

# Create user for security (optional)
RUN addgroup -g 1001 -S appgroup && \
    adduser -u 1001 -S appuser -G appgroup

# Install dependencies
COPY pyproject.toml uv.lock ./
RUN uv sync --frozen --no-dev

# Copy application code
COPY . /app
RUN chown -R appuser:appgroup /app

# Switch to non-root user
USER appuser

# Set environment variables
ENV PYTHONPATH=/app
ENV PATH="/app/.venv/bin:$PATH"

# Run application with uv
CMD ["uv", "run", "python", "main.py"]
```

### Running Interactively

```bash
# Since this is a base image, you need to specify a command
docker run -it reacticity-base-python python
docker run -it reacticity-base-python sh
```

### Using uv Package Manager

```bash
# Install packages with uv
docker run -it reacticity-base-python uv pip install requests

# Create virtual environment
docker run -it reacticity-base-python uv venv

# Install from requirements.txt
docker run -it reacticity-base-python uv pip install -r requirements.txt

# Run applications with uv
docker run -it reacticity-base-python uv run python script.py
```

## Image Details

- **Size**: Optimized for minimal footprint using Alpine Linux
- **User**: No predefined user (let consuming images decide)
- **Working Directory**: No predefined directory (let consuming images decide)
- **Base Image**: No default command (intended for inheritance)
- **Package Manager**: `uv` (latest version)
- **Installation Location**: `/usr/local/bin/uv` (available in PATH)

## Version

- Python: 3.13
- Alpine Linux: Latest stable
- libffi: Latest available in Alpine
- OpenSSL: Latest available in Alpine
- git: Latest available in Alpine
- build-base: Latest available in Alpine (includes gcc, g++, make)
- ca-certificates: Latest available in Alpine
- musl-dev: Latest available in Alpine
- zlib-dev: Latest available in Alpine
- uv: Latest version from official installer

### Pull from Docker Hub

```bash
docker pull mbeauv/reacticity-base-python:latest
```

### Using as Base Image

```dockerfile
FROM mbeauv/reacticity-base-python:latest
# Your application code here
```
```

Once published, your clients can use:
```bash
docker pull mbeauv/reacticity-base-python:latest
```

And reference it in their Dockerfiles as:
```dockerfile
FROM mbeauv/reacticity-base-python:latest