FROM docker.io/library/debian:bookworm-slim

WORKDIR /app

COPY setup.sh /tmp/
RUN /tmp/setup.sh

COPY Caddyfile server.sh payload.sh entrypoint.sh ./

# never use this in production:
ENV CADDY_ADMIN="0.0.0.0:2019"

ENTRYPOINT [ "/app/entrypoint.sh" ]
CMD [ "/app/server.sh" ]
