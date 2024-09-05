## Base Image
FROM node:20.17.0-alpine AS base
ENV NODE_ENV=production
# Install everything into /app directory
WORKDIR /app
# Only copy files needed for npm install
COPY package*.json* ./
# Install production packages only using package-lock.json
RUN npm ci --omit=dev --ignore-scripts

## Development Image
FROM base AS dev
ENV NODE_ENV=development
RUN npm ci

## Build Image
FROM dev AS build
# Copy the code in
COPY . .
# Compile the code
RUN npm run build

## Production image
FROM base AS prod
ARG OXVIID
# Move the compiled code
COPY --from=build /app/dist/ ./

CMD ["node", "/app/index.js"]
