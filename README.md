## Caddy Test

My attempt at learning how to use [Caddy](https://caddyserver.com/), verify and test certain
behavior, and see if it will be a good replacement for NGINX.

Assumes you have Docker and HTTPie installed.

### todo

* [x] allowlist CDN IP address ranges (esp Fastly)
    * don't just "trust" fastly IPs; forbid all non-fastly IPs
* [ ] configure via environment variable (esp `PORT`)
* [ ] timeout settings

### experiments

Here's what I've tested so far:

#### graceful shutdown

ensure caddy shuts down gracefully with SIGINT

```bash
# in your first terminal:
# start the server with caddy as a reverse proxy
RESPONSE_DELAY_SECONDS=30 make run

# in another terminal:
# this request will take a while to complete
make request

# in a third terminal:
# this sends SIGTERM to caddy
make kill-caddy
```

**observed behavior:** the slow request is allowed to finish before caddy (and the container)
terminates

#### ip filtering

ensure we can programmatically generate IP whitelists

```bash
# in your first terminal:
# choose which IP address ranges you want to allow:
ALLOWED_IPS="all|fastly|private" make run

# in another terminal:
make request
```

**observed behavior:** requests for `all` and `private` succeed (because my host's IP address is in
a private LAN subnet) but `fastly` fails (because my host is not a Fastly IP address)

#### request filtering

prevent requests that are too large from getting to the application

```bash
# in your first terminal:
make run

# in another terminal:
dd if=/dev/zero bs=65MiB count=1 | make request
```

**observed behavior:** rejected with 413 Payload Too Large; request isn't seen by the upstream
application

### Links

* https://caddyserver.com/docs/
