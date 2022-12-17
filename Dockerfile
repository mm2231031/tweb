FROM docker.io/library/alpine:latest AS build
RUN apk add git npm 
RUN cd /mnt/ && git clone https://github.com/morethanwords/tweb && cd /mnt/tweb && npm install --force
RUN cd /mnt/tweb && npm run build
FROM docker.io/library/nginx:mainline-alpine-slim
COPY --from=build /mnt/tweb/public/ /usr/share/nginx/html/
