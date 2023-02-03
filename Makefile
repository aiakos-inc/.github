
.DEFAULT_GOAL := help
SHELL=/bin/bash

.PHONY: help
help: ## help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

.PHONY: act_token
act_token:
	act -s PRIVATE_KEY="$$(< private-key.pem)" -W .github/workflows/ci.yml -j token workflow_dispatch

.PHONY: act_semver
act_semver:
	act -W .github/workflows/ci.yml -j semver workflow_dispatch
