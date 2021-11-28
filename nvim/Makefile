OS := $(shell uname)

CONF_DIR ?= $(HOME)/.config/nvim
PLUGINS_DIR ?= $(HOME)/.local/share/nvim/site/pack/plugins

.PHONY: all
all: nvim-prereqs nvim-config nvim-plugin-fzf
	@true

.PHONY: nvim-dirs
nvim-dirs:
	@mkdir -p ${CONF_DIR}
	@mkdir -p ${PLUGINS_DIR}

.PHONY: prereqs
nvim-prereqs:
ifeq (${OS}, Linux)
	@sudo apt-get update
	@sudo apt-get install --yes ripgrep fd-find rsync
else ifeq (${OS}, Darwin)
	@brew update
	@brew install ripgrep fd rsync
else
	@echo "OS: ${OS} not supported"
	@exit 1
endif

.PHONY: nvim-config
nvim-config: nvim-dirs
	@cp init.lua ${CONF_DIR}
	@rsync -auv --force --delete ./lua/* ${CONF_DIR}/lua
	@rsync -auv --force ./plugins/* ${PLUGINS_DIR}

.PHONY: nvim-plugin-fzf
nvim-plugin-fzf: nvim-config
	@$(MAKE) -C ${PLUGINS_DIR}/start/telescope-fzf-native.nvim/
