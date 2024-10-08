# syntax=docker/dockerfile:1.4
FROM oven/bun:latest AS build

# Set workdir
WORKDIR /app

# Copy the code
COPY . /app

# Install dependencies and build application
RUN \
    bun install && \
    bun run build

# syntax=docker/dockerfile:1.4
FROM oven/bun:latest

LABEL org.opencontainers.image.source="https://github.com/EVE-KILL/Frontend"

# Set workdir
WORKDIR /app

# Copy the build folder from the first stage
COPY --from=build /app/.npmrc /app
COPY --from=build /app/copyESFDataToStatic.sh /app
COPY --from=build /app/static /app
COPY --from=build /app/build /app
COPY --from=build /app/package.json /app
COPY --from=build /app/bun.lockb /app

RUN bun install --production && \
    rm -f .npmrc

# Expose the port
EXPOSE 3000

# Set the default BASE_URL
ENV VITE_BASE_URL=https://eve-kill.com

CMD [ "bun", "--bun", "index.js" ]
