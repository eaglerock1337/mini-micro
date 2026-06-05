.PHONY: default help run package
default: help

# generate help info from comments: thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help: ## help information about make commands
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

NIXOS := $(shell test -e /etc/NIXOS && echo 1)
RUN_PREFIX := $(if $(NIXOS),steam-run )

run: ## run the Mini Micro
	$(RUN_PREFIX)./mm -usr "./disk" -usr2 "./tmsim"

run-full: ## run the Mini Micro in fullscreen mode
	$(RUN_PREFIX)./mm -screen-fullscreen 1 -usr "./disk" -usr2 "./tmsim"

package: ## package tmsim as a distributable .minidisk
	cd tmsim && zip -r ../tmsim.minidisk . -x '*.gitkeep' -x '*.git*'
