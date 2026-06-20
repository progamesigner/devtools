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
        python3 \
        python3-pip \
        sudo \
 && rm -rf /var/lib/apt/lists/*

COPY --chmod=0755 --chown=ubuntu:ubuntu entrypoint.sh /usr/local/bin/entrypoint.sh

RUN mkdir -p /home/ubuntu/.claude \
 && chown -R ubuntu:ubuntu /home/ubuntu/.claude

ENV PATH=/home/ubuntu/.local/bin:${PATH}

USER ubuntu

WORKDIR /workspace

VOLUME ["/workspace", "/home/ubuntu/.claude"]

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["claude", "--remote-control"]
