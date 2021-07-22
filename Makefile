.PHONY: build
build:
	docker-compose up -d


.PHONY: getsubstrate
getsubstrate:
	curl https://getsubstrate.io -sSf | bash -s -- --fast
	. ~/.cargo/env