# Python 3.10 base (Debian Bullseye) with devcontainers goodies
FROM mcr.microsoft.com/devcontainers/python:1-3.10-bullseye

# Optional: a few basics you might appreciate
RUN apt-get update && apt-get install -y \
    curl git build-essential pkg-config \
 && rm -rf /var/lib/apt/lists/*
