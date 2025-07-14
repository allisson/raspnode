.PHONY: create-app-data
create-app-data:
	@mkdir -p app-data/vaultwarden-ts
	@mkdir -p app-data/vaultwarden
	@mkdir -p app-data/portainer-ts
	@mkdir -p app-data/portainer
	@mkdir -p app-data/beszel-ts
	@mkdir -p app-data/beszel/data
	@mkdir -p app-data/beszel/socket
	@mkdir -p app-data/tor-proxy
	@mkdir -p app-data/bitcoin-core

.PHONY: remove-app-data
remove-app-data:
	@rm -rf app-data
