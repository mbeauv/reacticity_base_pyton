# Reacticity Base Python Docker Image

This repository contains a Docker image based on `python:3.11-alpine` with essential system dependencies for Python applications.

## Features

- **Base Image**: `python:3.11-alpine` (lightweight Alpine Linux with Python 3.11)
- **System Dependencies**:
  - `libffi`: Foreign Function Interface library
  - `openssl`: OpenSSL cryptographic library
  - `git`: Version control system
  - `build-base`: Compiler toolchain (gcc, g++, make, etc.)
  - `ca-certificates`: SSL/TLS certificates for HTTPS connections
- **Package Manager**: `uv` - Fast Python package manager
- **Security**: Runs as non-root user (`appuser`)
- **Working Directory**: `/app`

## Usage

### Building the Image

```bash
docker build -t reacticity-base-python .
```

### Using as Base Image

```dockerfile
FROM reacticity-base-python:latest

# Your application code here
COPY . /app
RUN uv pip install -r requirements.txt

CMD ["python", "main.py"]
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
```

## Image Details

- **Size**: Optimized for minimal footprint using Alpine Linux
- **User**: Runs as `appuser` (UID: 1001, GID: 1001)
- **Working Directory**: `/app`
- **Base Image**: No default command (intended for inheritance)
- **Package Manager**: `uv` (latest version)

## Version

- Python: 3.11
- Alpine Linux: Latest stable
- libffi: Latest available in Alpine
- OpenSSL: Latest available in Alpine
- git: Latest available in Alpine
- build-base: Latest available in Alpine (includes gcc, g++, make)
- ca-certificates: Latest available in Alpine
- uv: Latest version from official installer
