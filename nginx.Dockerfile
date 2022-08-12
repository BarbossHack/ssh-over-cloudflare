FROM alpine

RUN apk update && \
    apk add --no-cache nginx

ENTRYPOINT ["nginx", "-g", "daemon off;"]
