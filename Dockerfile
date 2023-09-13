FROM docker.io/library/debian:bookworm-slim

COPY setup.sh /tmp/
RUN /tmp/setup.sh

# never use this in production:
ENV CADDY_ADMIN="0.0.0.0:2019"

CMD [ "/usr/local/bin/caddy", "run" ]
