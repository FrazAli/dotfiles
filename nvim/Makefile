OS := $(shell uname)
LINUX_DISTRO := $(shell if [ -r /etc/os-release ]; then \
	. /etc/os-release; \
	if printf '%s\n' "$$ID $$ID_LIKE" | grep -qw arch; then \
		echo arch; \
	elif printf '%s\n' "$$ID $$ID_LIKE" | grep -qw debian; then \
		echo debian; \
	fi; \
fi)

CONF_DIR ?= $(HOME)/.config/nvim

.PHONY: all
all: nvim-prereqs nvim-config
	@true

.PHONY: nvim-prereqs
nvim-prereqs:
ifeq (${OS}, Linux)
	@case "${LINUX_DISTRO}" in \
		arch) \
			sudo pacman -S --needed ripgrep fd rsync tree-sitter-cli imagemagick ghostscript ;; \
		debian) \
			sudo apt-get update; \
			sudo apt-get install --yes ripgrep fd-find rsync ;; \
		*) \
			echo "Linux distribution not supported"; \
			exit 1 ;; \
	esac
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
