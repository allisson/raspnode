# raspnode

Configuration I use on my raspberrypi4 8GB which is my homelab.

Requirements:

- Raspberry Pi OS Lite 64 bits.
- Docker https://docs.docker.com/engine/install/debian/.
- Tailscale authkey with the reuse option enabled.

# how to use

1) Create the app-data directory.

```bash
make create-app-data
```

2) Copy the env.sample to .env and edit the values.

```bash
cp env.sample .env
# vim .env or nano .env
```

3) Start the containers.

```bash
docker compose up -d
```
