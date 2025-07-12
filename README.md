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

If you have not changed the value of the BESZEL_HOSTNAME variable, the address should be https://homelab-monitoring.your-tailnet-name.ts.net.

Create the administrator account, and after logging in, click on "Add New System" and copy the value of the "Public Key" field in the BESZEL_AGENT_KEY variable in the .env file.

Now, stop and restart the services to load the new values from the .env file.

```bash
docker compose stop
docker compose up -d
```

Now go back to the Beszel website and click "Add New System" again, filling in the "Name" as "raspnode" and the "Host / IP" as "/beszel_socket/beszel.sock".

## Enjoy your HomeLab

- Vaultwarden: https://homelab-password.your-tailnet-name.ts.net
- Portainer: https://homelab-docker.your-tailnet-name.ts.net
- Beszel: https://homelab-monitoring.your-tailnet-name.ts.net.
- Blocky: The port 53 UDP/TCP is open to serve DNS requests, the config is located on ./app-config/blocky/config.yml.
