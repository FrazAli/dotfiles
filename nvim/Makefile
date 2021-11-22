OS := $(shell uname)

CONF_DIR ?= $(HOME)/.config/nvim
PLUGINS_DIR ?= $(HOME)/.local/share/nvim/site/pack/plugins

nvim-dirs:
	@mkdir -p ${CONF_DIR}
	@mkdir -p ${PLUGINS_DIR}

.PHONY: neovim-config
neovim-config: nvim-dirs
ifeq ($(OS), Linux)
	@sudo apt-get update
	@sudo apt-get install --yes ripgrep fd-find
	cp init.lua ${CONF_DIR}
	rsync -auv --force --delete ./lua/* ${CONF_DIR}/lua
	rsync -auv --force ./plugins/* ${PLUGINS_DIR}
else ifeq ($(OS), Darwin)
	@brew update
	@brew install ripgrep fd rsync
	cp init.lua ${CONF_DIR}
	rsync -auv --force --delete ./lua/* ${CONF_DIR}/lua
	rsync -auv --force ./plugins/* ${PLUGINS_DIR}
else
	echo "OS: $(OS) not supported"
endif

