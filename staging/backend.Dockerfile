# syntax=docker/dockerfile:1.4
FROM oven/bun:latest AS build

LABEL org.opencontainers.image.source="https://github.com/EVE-KILL/Frontend"

# Set workdir
WORKDIR /app

# Copy the code
COPY . /app

# Install dependencies and build application
RUN \
    bun install --production && \
    bun run build

# Expose the port
EXPOSE 3000

CMD [ "bun", "--bun", "index.js" ]
