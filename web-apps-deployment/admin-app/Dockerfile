FROM nginx:alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY . /usr/share/nginx/html

HEALTHCHECK CMD curl --fail http://localhost:8080 || exit 1
