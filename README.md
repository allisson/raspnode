# Raspnode

The configuration I use on my Raspberry Pi 4 (8GB), which is my HomeLab.

# About

I don't plan to significantly change this project. The goal is to keep it simple as a starting point, so people can set up their HomeLab using a Raspberry Pi (model 4 or 5) with basic services and secure access through Tailscale.

Therefore, I will keep this repository read-only. Please do not open issues or submit pull requests, but feel free to fork or clone it. It is licensed under the MIT license.

# Requirements

- Raspberry Pi OS Lite 64-bit.
- Docker https://docs.docker.com/engine/install/debian/ (don't forget to add the user to the docker group https://docs.docker.com/engine/install/linux-postinstall/).
- Tailscale authkey with the reuse option enabled https://login.tailscale.com/admin/settings/keys.
- Tailscale with the "HTTPS Certificates" enabled https://login.tailscale.com/admin/dns.

# Services

- Vaultwarden: https://github.com/dani-garcia/vaultwarden.
- Portainer: https://github.com/portainer/portainer.
- Beszel: https://github.com/henrygd/beszel.
- Blocky: https://github.com/0xERR0R/blocky.
- Bitcoin Core: https://github.com/dobtc/bitcoin.
- N8N: https://github.com/n8n-io/n8n.

# How to use

## Create the app-data directory

```bash
make create-app-data
```

## Copy the env.sample to .env and edit the values

```bash
cp env.sample .env
# vim .env or nano .env
```

The BESZEL_AGENT_KEY variable must be changed after the Beszel service is started. 

This is necessary because we need to get the public key that is generated at the first start.

## Start the containers

```bash
docker compose up -d
```

## Open the Beszel service to get the value for the BESZEL_AGENT_KEY variable

If you have not changed the value of the BESZEL_HOSTNAME variable, the address should be https://beszel.your-tailnet-name.ts.net.

Create the administrator account, and after logging in, click on "Add New System" and copy the value of the "Public Key" field in the BESZEL_AGENT_KEY variable in the .env file.

Now, stop and restart the services to load the new values from the .env file.

```bash
docker compose stop
docker compose up -d
```

Now go back to the Beszel website and click "Add New System" again, filling in the "Name" as "raspnode" and the "Host / IP" as "/beszel_socket/beszel.sock".

## Fix Beszel memory stats in Docker

Follow these instructions https://akashrajpurohit.com/blog/resolving-missing-memory-stats-in-docker-stats-on-raspberry-pi/.

## Change the default password of bitcoin core rpc

The default user and password to access the Bitcoin Core RPC are "bitcoin." 

If you want to change these credentials, generate a new credential and change the value of rpcauth in the file ./app-config/bitcoin-core/bitcoin.conf.

```bash
python ./app-config/bitcoin-core/rpcaut.py username password
String to be appended to bitcoin.conf:
rpcauth=username:e87b62cd0e9c2066238f876f4e2c6a6a$72a7c7ef9aa3d39aada4b7a8f8f00f4775c5147deec27d62ff17d88ac2b8c043
Your password:
password
```

Now, stop and restart the services to load the new values from the .env file.

```bash
docker compose stop
docker compose up -d
```

## Enjoy your HomeLab

- Vaultwarden: https://vaultwarden.your-tailnet-name.ts.net
- Portainer: https://portainer.your-tailnet-name.ts.net
- Beszel: https://beszel.your-tailnet-name.ts.net.
- Blocky: The port 53 UDP/TCP is open to serve DNS requests on your local network, the config is located on ./app-config/blocky/config.yml.
- Bitcoin Core: The ports 8332/8333/28332/28333 are open on bitcoin.your-tailnet-name.ts.net.
- N8N: https://n8n.your-tailnet-name.ts.net.
