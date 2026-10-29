FROM debian:trixie-slim

RUN    apt-get update \
    && apt-get install -y --no-install-recommends \
       vim less tree ack \
       git curl ca-certificates \
    && rm -rf /var/lib/apt/lists/*

USER root
WORKDIR /root/dev

RUN curl -fsSL https://opencode.ai/v2/install | bash
ENV PATH=/root/.opencode/bin:$PATH

RUN mkdir -p /root/.config/opencode
COPY opencode.json /root/.config/opencode/opencode.json

RUN mkdir /root/.config/opencode/plugins
COPY qwen-block-proxy-artifacts/plugin/block-proxy-artifacts.ts /root/.config/opencode/plugins/

EXPOSE 49374

COPY entrypoint.sh /root/
CMD ["bash", "/root/entrypoint.sh"]
