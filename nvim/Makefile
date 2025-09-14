OS := $(shell uname)

CONF_DIR ?= $(HOME)/.config/nvim
PLUGINS_DIR ?= $(HOME)/.local/share/nvim/site/pack/plugins

.PHONY: all
all: nvim-prereqs nvim-config
	@true

.PHONY: prereqs
nvim-prereqs:
ifeq (${OS}, Linux)
	@echo 'deb [trusted=yes] https://apt.fury.io/ascii-image-converter/ /' | sudo tee /etc/apt/sources.list.d/ascii-image-converter.list
	@sudo apt-get update
	@sudo apt-get install --yes ripgrep fd-find rsync
	@echo "Installing ascii-image-converter ..."
	@sudo apt-get install --yes ascii-image-converter
	@sudo rm /etc/apt/sources.list.d/ascii-image-converter.list
else ifeq (${OS}, Darwin)
	@brew update
	@brew install ripgrep fd rsync
	@brew install tree-sitter-cli
	@brew install pngpaste imagemagick ghostscript mermaid-cli  # for snacks.nvim
else
	@echo "OS: ${OS} not supported"
	@exit 1
endif

.PHONY: nvim-config
nvim-config:
	@mkdir -p "$(CONF_DIR)/lua"
	@rsync -avh --delete ./lua/ "$(CONF_DIR)/lua/"
	@install -m 0644 init.lua "$(CONF_DIR)/init.lua"
