
.DEFAULT_GOAL := help
SHELL=/bin/bash

.PHONY: help
help: ## help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

.PHONY: lint
lint: ## lint
	actionlint

.PHONY: act_token
act_token:
	act -s PRIVATE_KEY="$$(< private-key.pem)" -W .github/workflows/ci.yml -j token workflow_dispatch

.PHONY: act_semver
act_semver:
	act -W .github/workflows/ci.yml -j semver workflow_dispatch

.PHONY: act_actionlint
act_actionlint: ## act act_actionlint
	act -s PRIVATE_KEY="$$(< private-key.pem)" -W .github/workflows/ci.yml -j actionlint workflow_dispatch

.PHONY: act_notify
act_notify: ## act act_notify
	act -s PRIVATE_KEY="$$(< private-key.pem)" -W .github/workflows/notify.yml -j notify --input status=failure workflow_dispatch

.PHONY: act_google_chat
act_google_chat: ## act act_google_chat
	act -s PRIVATE_KEY="$$(< private-key.pem)" -W .github/workflows/google-chat.yml -j google-chat \
		--input status=success \
		--input title='"タイトル"' \
		--input subtitle='"サブタイトル"' \
		--input message='revert: Revert "fix: リバート"' \
		--input url='https://aiakos.co.jp/' \
		workflow_dispatch
