FROM nginx:alpine

# Replace default NGINX config with one that listens on port 8080
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy app files
COPY . /usr/share/nginx/html