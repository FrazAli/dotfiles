# Load API keys from keychain
#
# To add new keys to key keychain use the command example below:
# security add-generic-password \
#   -a "$USER" \
#   -s ANTHROPIC_API_KEY \
#   -l "Anthropic API Key" \
#   -U \
#   -T /usr/bin/security \
#   -w "<API key value here OR Skip the value to add it securely on the command line >"

# Resolve dir of this script (works when sourced via a symlinked ~/.zshrc)
local _this="${${(%):-%N}:A}"
local _dir="${_this:h}"
source "${_dir}/keychain_utils.zsh"

# Keys to load
typeset -a api_keys=(
  ANTHROPIC_API_KEY
  DEEPSEEK_API_KEY
  GOOGLE_API_KEY
  GROQ_API_KEY
  OPENAI_API_KEY
)

load_api_keys() {
  emulate -L zsh
  setopt no_unset

  local k val ec
  for k in "${api_keys[@]}"; do
    # Skip if the variable already exists in the environment/shell
    if (( ${+parameters[$k]} )); then
      continue
    fi

    # Silence Apple's stderr here; we print our own warning.
    val=$(get_keychain_secret "$k" "$USER" 2>/dev/null); ec=$?

    if (( ec == 0 )); then
      # Safe export even if value has spaces/newlines
      typeset -gx "${k}=${val}"
    else
      print -u2 -- "Warning: failed to load key '$k' for account '$USER' (exit $ec)."
    fi
  done

  return 0
}

load_api_keys
