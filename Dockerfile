FROM alpine:latest as builder

ARG DOCKER_CLI_VERSION="18.06.3-ce"
ENV DOCKER_DOWNLOAD_URL="https://download.docker.com/linux/static/stable/x86_64/docker-$DOCKER_CLI_VERSION.tgz"

# install docker client
RUN apk --update add curl \
    && mkdir -p /tmp/download \
    && curl -L $DOCKER_DOWNLOAD_URL | tar -xz -C /tmp/download \
    && mv /tmp/download/docker/docker /usr/local/bin/ \
    && chmod +x /usr/local/bin/docker

ARG DOCKER_COMPOSE_VERSION="1.24.1"
ENV COMPOSE_DOWNLOAD_URL="https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-Linux-x86_64"

# install docker-compose
RUN curl -L $COMPOSE_DOWNLOAD_URL > /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose

FROM frolvlad/alpine-glibc:latest

COPY --from=builder /usr/local/bin/docker /usr/local/bin/
COPY --from=builder /usr/local/bin/docker-compose /usr/local/bin/
