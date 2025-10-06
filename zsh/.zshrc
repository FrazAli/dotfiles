### Added by Codeium. These lines cannot be automatically removed if modified
if command -v termium > /dev/null 2>&1; then
  eval "$(termium shell-hook show pre)"
fi
### End of Codeium integration
# Set default editor
export EDITOR=nvim

# Resolve this file's real path (handles symlinks) and its directory
# ${(%):-%N} = current sourced filename; :A = absolute, resolve symlinks; :h = dirname
_zshrc_path=${${(%):-%N}:A}
_zshrc_dir=${_zshrc_path:h}

if [[ -f "$_zshrc_dir/load_api_keys.zsh" ]]; then
  source "$_zshrc_dir/load_api_keys.zsh"
fi

# Enable vi mode while keeping keys for searching command history
bindkey -v
bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward

# Enable starship prompt
eval "$(starship init zsh)"

# fzf Options
export FZF_DEFAULT_OPTS='--height=40% --cycle --layout=reverse --border --info=inline'

# Aliases
alias k="kubectl"
alias ll="eza -lTa -L 2 --icons --git"
alias cat="bat --style=plain --theme=Nord"

# fzf - enables fzf keybindings
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# History configuration for persistent history across all panes and windows
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=100000
export SAVEHIST=100000

# History options
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history


### Added by Codeium. These lines cannot be automatically removed if modified
if command -v termium > /dev/null 2>&1; then
  eval "$(termium shell-hook show post)"
fi
### End of Codeium integration
