# syntax=docker/dockerfile:1

ARG BUN_VERSION=latest
ARG UBUNTU_VERSION=latest
ARG UV_VERSION=latest

FROM ghcr.io/astral-sh/uv:${UV_VERSION} AS uv
FROM oven/bun:${BUN_VERSION} AS bun

FROM ubuntu:${UBUNTU_VERSION} AS base

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

RUN mkdir -p /home/ubuntu/.claude \
 && chown -R ubuntu:ubuntu /home/ubuntu/.claude

ENV PATH=/home/ubuntu/.local/bin:${PATH}

USER ubuntu

WORKDIR /workspace

VOLUME ["/workspace", "/home/ubuntu/.claude"]

ENTRYPOINT ["/usr/bin/tini", "-g", "--", "/usr/local/bin/docker-entrypoint.sh"]

CMD ["claude", "--remote-control"]
