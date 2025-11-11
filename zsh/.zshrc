
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
if [[ -o interactive && -t 0 ]]; then
  stty -ixon 2>/dev/null  # ensure ^S doesn't trigger terminal flow control
fi

# Enable starship prompt
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

# Initialize nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Add Docker to PATH
if [[ -d /Applications/Docker.app/Contents/Resources/bin ]]; then
  path+=("/Applications/Docker.app/Contents/Resources/bin")
fi

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
setopt append_history          # append instead of clobbering HISTFILE
setopt extended_history        # record timestamp and duration metadata
setopt hist_expire_dups_first  # drop older duplicates before unique entries
setopt hist_ignore_dups        # skip consecutive duplicate commands
setopt hist_ignore_space       # keep space-prefixed commands out of history
setopt hist_verify             # confirm history substitution before running
setopt inc_append_history      # write each command to HISTFILE immediately
unsetopt share_history         # keep per-pane history in memory while still sharing the file

# Zoxide setup
eval "$(zoxide init zsh --cmd cd)"
