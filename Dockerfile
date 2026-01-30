FROM caddy:builder-alpine AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/azure

FROM caddy

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
