# FROM oven/bun:1 as builder

# WORKDIR /app

# ARG VITE_CONVEX_URL
# ARG VITE_CONVEX_DASHBOARD_URL
# ENV VITE_CONVEX_URL=$VITE_CONVEX_URL
# ENV VITE_CONVEX_DASHBOARD_URL=$VITE_CONVEX_DASHBOARD_URL

# COPY package.json bun.lock ./

# # Install dependencies
# RUN bun install

# # Copy application files
# COPY . .
# RUN bun run build

# FROM nginx:stable-alpine

# COPY --from=builder /app/dist /usr/share/nginx/html

# # Expose necessary ports
# EXPOSE 80

# CMD ["nginx", "-g", "daemon off;"]

FROM oven/bun:1 as builder

WORKDIR /app

ARG VITE_CONVEX_URL
ARG VITE_CONVEX_DASHBOARD_URL
ENV VITE_CONVEX_URL=$VITE_CONVEX_URL
ENV VITE_CONVEX_DASHBOARD_URL=$VITE_CONVEX_DASHBOARD_URL

COPY package.json bun.lock ./

# Install dependencies
RUN bun install

# Copy application files
COPY . .

# Build and debug what's created
RUN bun run build
RUN echo "=== Listing /app contents ===" && ls -la /app/
RUN echo "=== Listing /app/dist contents ===" && ls -la /app/dist/ || echo "dist directory not found"
RUN echo "=== Listing /app/docs contents ===" && ls -la /app/docs/ || echo "docs directory not found"

FROM nginx:stable-alpine

# Copy the correct build output
COPY --from=builder /app/dist /usr/share/nginx/html

# Debug what's in nginx html directory
RUN echo "=== Listing nginx html directory ===" && ls -la /usr/share/nginx/html/

# Expose necessary ports
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

