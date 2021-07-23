.PHONY: do
do:
	echo "do"


.PHONY: build
build:
	docker-compose up -d

.PHONY: build_log
build_log:
	docker-compose -f docker-compose.logs.lpg.yml up -d --remove-orphans


.PHONY: getsubstrate
getsubstrate:
	curl https://getsubstrate.io -sSf | bash -s -- --fast
	. ~/.cargo/env

.PHONY: substrate_server
substrate_server:
	nohup substrate --dev --ws-external >> /var/log/chain.log 2>&1 &