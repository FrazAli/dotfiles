# ~/.zshenv  (runs for every zsh)
typeset -U path PATH
path=(/usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin)

# Homebrew (AS + Intel)
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# User bins
[[ -d "$HOME/.local/bin" ]] && path+=("$HOME/.local/bin")
[[ -d "$HOME/bin" ]]        && path+=("$HOME/bin")
export PATH

