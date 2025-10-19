# ~/.zshenv  (runs for every zsh)
typeset -U path PATH
path=(
  /usr/local/sbin
  /usr/local/bin
  /usr/sbin
  /usr/bin
  /sbin
  /bin
  "${path[@]}"
)

# Initialize Homebrew when available
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# User bins
[[ -d "$HOME/.local/bin" ]] && path+=("$HOME/.local/bin")
[[ -d "$HOME/bin" ]]        && path+=("$HOME/bin")
export PATH
. "$HOME/.cargo/env"
