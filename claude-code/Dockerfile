# syntax=docker/dockerfile:1

ARG ALPINE_VERSION=3.24.0
ARG BUN_VERSION=latest
ARG GH_VERSION=latest
ARG UBUNTU_VERSION=latest
ARG UV_VERSION=latest

FROM ghcr.io/astral-sh/uv:${UV_VERSION} AS uv
FROM oven/bun:${BUN_VERSION} AS bun

FROM alpine:${ALPINE_VERSION} AS gh

RUN apk add --no-cache curl tar \
 && arch=$(uname -m) \
 && if [ "$arch" = "x86_64" ]; then ARCH="amd64"; \
    elif [ "$arch" = "aarch64" ]; then ARCH="arm64"; \
    else ARCH="$arch"; fi \
 && curl -fsSL https://github.com/cli/cli/releases/download/v${GH_VERSION}/gh_${GH_VERSION}_linux_${ARCH}.tar.gz -o gh.tar.gz \
 && tar xzf gh.tar.gz \
 && mv gh_${GH_VERSION}_linux_${ARCH}/bin/gh /gh

FROM ubuntu:${UBUNTU_VERSION} AS app

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
 && apt-get install --yes --no-install-recommends \
        build-essential \
        ca-certificates \
        curl \
        git \
        jq \
        pipx \
        python3 \
        python3-pip \
        sudo \
        tini \
 && rm -rf /var/lib/apt/lists/*

COPY --chmod=0755 --chown=ubuntu:ubuntu docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
COPY --from=uv /uv /uvx /usr/local/bin/
COPY --from=bun /usr/local/bin/bun /usr/local/bin/
COPY --from=gh /gh /usr/local/bin/gh

RUN mkdir -p /home/ubuntu/.claude \
 && chown -R ubuntu:ubuntu /home/ubuntu/.claude

ENV PATH=/home/ubuntu/.local/bin:${PATH}

USER ubuntu

WORKDIR /workspace

VOLUME ["/workspace", "/home/ubuntu/.claude"]

ENTRYPOINT ["/usr/bin/tini", "-g", "--", "/usr/local/bin/docker-entrypoint.sh"]

CMD ["claude", "--remote-control"]
