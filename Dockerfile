# Use official Nginx image as base
FROM nginx:latest

# Set working directory
WORKDIR /usr/share/nginx/html

# Remove default Nginx content
RUN rm -rf ./*

# Copy all web files to Nginx directory
COPY index.html .
COPY styles.css .
COPY script.js .

# Copy custom Nginx config for better performance
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80 for HTTP traffic
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost/ || exit 1

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]