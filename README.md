## Caddy Test

My attempt at learning how to use [Caddy](https://caddyserver.com/), verify and test certain
behavior, and see if it will be a good replacement for NGINX.

Assumes you have Docker and HTTPie installed.

### experiments

Here's what I've tested so far:

#### graceful shutdown

```bash
# in your first terminal:
make run # start the server with caddy as a reverse proxy

# in another terminal:
make request # this request will take a while to complete

# in a third terminal:
make kill-caddy # this sends SIGTERM to caddy
```

observed behavior: the slow request is allowed to finish before caddy (and the container) terminates

### Links

* https://caddyserver.com/docs/
