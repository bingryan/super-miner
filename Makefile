.PHONY: build
build:
	docker-compose up -d


.PHONY: getsubstrate
getsubstrate:
	curl https://getsubstrate.io -sSf | bash -s -- --fast
	. ~/.cargo/env

.PHONY: substrate_server
substrate_server:
	nohup substrate --dev --ws-external >> /logs/chain.log 2>&1 &
