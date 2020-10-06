.PHONY: help build

.DEFAULT_GOAL := help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

build: ## build the docker inistcnrs/ezmaster-mongo:1.0.4 image locally
	@docker build -t inistcnrs/ezmaster-mongo:1.0.4 --build-arg http_proxy --build-arg https_proxy .

run-debug: ## to debug locally
	@docker run inistcnrs/ezmaster-mongo:1.0.4
