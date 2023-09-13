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
		localhost/caddy-test
.PHONY: run

bash:
	docker run --rm --interactive --tty \
		localhost/caddy-test /usr/bin/bash
.PHONY: bash

lint:
	shellcheck *.sh
	hadolint Dockerfile
.PHONY: lint
