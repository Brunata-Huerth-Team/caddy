# Caddy + Azure DNS Plugin

This repo provides a Caddy webserver build that includes the Azure DNS plugin for DNS-01 ACME challenges. The included `Dockerfile` uses `xcaddy` to compile Caddy with `github.com/caddy-dns/azure`, enabling automatic TLS certificate issuance via Azure DNS.

## What's Included
- `Dockerfile`: Builds a custom Caddy binary with the Azure DNS plugin and copies it into a slim runtime image.
- `examples/Caddyfile_Client_Secret`: Example DNS-01 configuration using an Azure app registration (client secret).
- `examples/Caddyfile_managed_identity`: Example DNS-01 configuration using Azure Managed Identity.

## Usage
Build the image:

```sh
docker build -t caddy-azure-dns .
```

Run it with a Caddyfile (replace the example file as needed):

```sh
docker run --rm -p 80:80 -p 443:443 \
  -v "$PWD/examples/Caddyfile_Client_Secret:/etc/caddy/Caddyfile" \
  -e AZURE_SUBSCRIPTION_ID=... \
  -e AZURE_RESOURCE_GROUP_NAME=... \
  -e AZURE_TENANT_ID=... \
  -e AZURE_CLIENT_ID=... \
  -e AZURE_CLIENT_SECRET=... \
  caddy-azure-dns
```

For Managed Identity, use `examples/Caddyfile_managed_identity` and provide only:
- `AZURE_SUBSCRIPTION_ID`
- `AZURE_RESOURCE_GROUP_NAME`

## Notes
- The Caddyfile examples use ZeroSSL as the ACME CA and Azure DNS as the DNS-01 provider.
- Update `foo.bar.com` and `reverse_proxy` in the examples to match your domain and upstream.
