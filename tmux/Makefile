TMUX_PLUGINS_DIR := $(HOME)/.tmux/plugins

.PHONY: all
all: tmux-config tmux-plugins
	@true

.PHONY: tmux-config
tmux-config:
	cp .tmux.conf $(HOME)/

.PHONY: tmux-plugins
tmux-plugins:
	rm -rf ${TMUX_PLUGINS_DIR}
	mkdir -p ${TMUX_PLUGINS_DIR}
	cp -r ./plugins/* ${TMUX_PLUGINS_DIR}/

