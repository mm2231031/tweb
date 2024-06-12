FROM docker.io/library/alpine:latest AS build
RUN apk add git npm 
RUN cd /tmp/ && git clone https://github.com/morethanwords/tweb --depth 1  && cd /tmp/tweb && npm i -g pnpm && pnpm install
RUN cd /tmp/tweb && pnpm run build
FROM docker.io/library/nginx:mainline-alpine-slim
COPY --from=build /tmp/tweb/public/ /usr/share/nginx/html/
