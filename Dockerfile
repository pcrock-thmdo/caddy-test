FROM docker.io/library/debian:bookworm-slim

WORKDIR /app

COPY setup.sh /tmp/
RUN /tmp/setup.sh

COPY Caddyfile ./

# never use this in production:
ENV CADDY_ADMIN="0.0.0.0:2019"

CMD [ "/usr/local/bin/caddy", "run" ]
