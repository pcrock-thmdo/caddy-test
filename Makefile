RESPONSE_DELAY_SECONDS?=0

all: lint pull build run
.PHONY: all

pull:
	docker pull docker.io/library/debian:bookworm-slim
.PHONY: pull

build:
	docker build --tag localhost/caddy-test .
.PHONY: build

run: build
	docker run --rm --interactive --tty \
		--publish "127.0.0.1:2019:2019" \
		--publish "127.0.0.1:2015:2015" \
		--env "RESPONSE_DELAY_SECONDS=$(RESPONSE_DELAY_SECONDS)" \
		localhost/caddy-test
.PHONY: run

bash:
	docker run --rm --interactive --tty \
		localhost/caddy-test /usr/bin/bash
.PHONY: bash

kill-caddy:
	docker exec "$$(docker container ls --latest --quiet)" \
		/usr/bin/bash -c 'kill -SIGTERM $$(pgrep caddy)'
.PHONY: kill-caddy

lint:
	shellcheck *.sh
	hadolint Dockerfile
.PHONY: lint

request:
	http "http://localhost:2015"
.PHONY: request

format: build
	docker run --rm \
		--entrypoint /usr/bin/bash \
		localhost/caddy-test \
		-c "/usr/local/bin/caddy fmt" > ./Caddyfile
.PHONY: format
