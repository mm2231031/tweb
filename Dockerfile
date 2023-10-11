FROM docker.io/library/alpine:latest AS build
RUN apk add git npm 
RUN cd /tmp/ && git clone https://github.com/morethanwords/tweb && cd /tmp/tweb && npm i -g pnpm && npm install --force
RUN cd /tmp/tweb && npm run build
FROM docker.io/library/nginx:mainline-alpine-slim
COPY --from=build /tmp/tweb/public/ /usr/share/nginx/html/
