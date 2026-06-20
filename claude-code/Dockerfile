# syntax=docker/dockerfile:1

FROM ubuntu:26.04

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
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /usr/local/bin/
COPY --from=oven/bun:latest /usr/local/bin/bun /usr/local/bin/

RUN mkdir -p /home/ubuntu/.claude \
 && chown -R ubuntu:ubuntu /home/ubuntu/.claude

ENV PATH=/home/ubuntu/.local/bin:${PATH}

USER ubuntu

WORKDIR /workspace

VOLUME ["/workspace", "/home/ubuntu/.claude"]

ENTRYPOINT ["/usr/bin/tini", "-g", "--", "/usr/local/bin/docker-entrypoint.sh"]

CMD ["claude", "--remote-control"]
