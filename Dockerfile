FROM docker.io/library/alpine:latest AS build
RUN apk add git pnpm 
RUN cd /tmp/ && git clone https://github.com/morethanwords/tweb --depth 1  && cd /tmp/tweb && pnpm install
RUN cd /tmp/tweb && node build
FROM docker.io/library/nginx:mainline-alpine-slim
COPY --from=build /tmp/tweb/public/ /usr/share/nginx/html/
