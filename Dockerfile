FROM nginx:1.19.1-alpine

COPY nginx.conf /etc/nginx/nginx.conf

ADD . /src
