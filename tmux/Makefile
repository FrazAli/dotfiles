TMUX_PLUGINS_DIR := $(HOME)/.tmux/plugins
REQUIRED_PLUGIN_FILES := \
	plugins/tmux-resurrect/resurrect.tmux \
	plugins/tmux-continuum/continuum.tmux

.PHONY: all
all: tmux-plugins
	@true

.PHONY: tmux-config
tmux-config:
	cp .tmux.conf $(HOME)/

.PHONY: tmux-plugins
tmux-plugins: check-plugin-submodules
	rm -rf ${TMUX_PLUGINS_DIR}
	mkdir -p ${TMUX_PLUGINS_DIR}
	cp -r ./plugins/* ${TMUX_PLUGINS_DIR}/

.PHONY: check-plugin-submodules
check-plugin-submodules:
	@missing=0; \
	for file in $(REQUIRED_PLUGIN_FILES); do \
		if [ ! -f "$$file" ]; then \
			echo "error: missing tmux plugin file: $$file" >&2; \
			missing=1; \
		fi; \
	done; \
	if [ "$$missing" -ne 0 ]; then \
		echo "Initialize the plugin submodules with:" >&2; \
		echo "  git submodule update --init --recursive" >&2; \
		exit 1; \
	fi
