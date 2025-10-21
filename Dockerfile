# Use nginx alpine for a lightweight static file server
FROM nginx:alpine

# Copy the HTML file to nginx html directory
COPY ./index.html /usr/share/nginx/html/index.html

# Copy README to make it accessible
COPY ./README.md /usr/share/nginx/html/README.md

# Expose port 80
EXPOSE 80

# nginx runs automatically in the base image
CMD ["nginx", "-g", "daemon off;"]
