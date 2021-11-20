
.PHONY: neovim-config
neovim-config:
	@sudo apt-get update
	@sudo apt-get install --yes ripgrep fd-find
	cp init.lua $(HOME)/.config/nvim/
	rsync -auv --force --delete ./lua/* $(HOME)/.config/nvim/lua
	rsync -auv --force ./plugins/* $(HOME)/.local/share/nvim/site/pack/plugins

