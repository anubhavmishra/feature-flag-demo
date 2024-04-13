BUILD_ID := $(shell git rev-parse --short HEAD 2>/dev/null || echo no-commit-id)
IMAGE := anubhavmishra/feature-flag-demo

.DEFAULT_GOAL := help
help: ## List targets & descriptions
	@cat Makefile* | grep -E '^[a-zA-Z_-]+:.*?## .*$$' | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

build-docker-image: ## Build a docker container
	docker build -t $(IMAGE):$(BUILD_ID) .
	docker tag $(IMAGE):$(BUILD_ID) $(IMAGE):latest

push: ## push docker image
	docker push $(IMAGE):latest
