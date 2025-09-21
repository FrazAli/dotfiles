# get_keychain_secret SERVICE [ACCOUNT]
# stdout: secret (on success)
# exit:   real exit code from `security` (0 on success, non-zero on error)
get_keychain_secret() {
  emulate -L zsh
  setopt err_return no_unset

  local service="${1:?service name required}"
  local account="${2:-$USER}"

  local out ec
  out=$(security find-generic-password -a "$account" -s "$service" -w)
  ec=$?
  (( ec == 0 )) && print -r -- "$out"
  return $ec
}
