#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd -- "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cpu="?"
mem="?"
cpu_temp=""
case "$(uname -s)" in
  Darwin) helper="${script_dir}/cpu-mem-macos.sh" ;;
  Linux)  helper="${script_dir}/cpu-mem-linux.sh" ;;
  *)      helper="" ;;
esac

if [[ -n "${helper:-}" && -x "$helper" ]]; then
  if out=$("$helper" 2>/dev/null); then
    read -r cpu mem cpu_temp <<<"$out"
  fi
fi

base_color=$(tmux show-option -gqv @thm_overlay_0 2>/dev/null || true)
base_color=${base_color:-default}
reset_color="#[fg=${base_color}]"
elevated_color='#[fg=#EBCB8B]'
high_color='#[fg=#D08770]'
critical_color='#[fg=#BF616A]'

format_metric() {
  local icon="$1" value="$2" suffix="$3"
  local elevated="$4" high="$5" critical="$6"
  local color=""

  if [[ -z "$value" ]]; then
    value="?"
  fi

  if [[ $value =~ ^[0-9]+$ ]]; then
    if (( value >= critical )); then
      color="$critical_color"
    elif (( value >= high )); then
      color="$high_color"
    elif (( value >= elevated )); then
      color="$elevated_color"
    fi
  fi

  if [[ -n "$color" ]]; then
    printf '%s%s %s%s%s' "$color" "$icon" "$value" "$suffix" "$reset_color"
  else
    printf '%s %s%s' "$icon" "$value" "$suffix"
  fi
}

cpu_display=$(format_metric '' "${cpu:-?}" '%' 60 80 90)
mem_display=$(format_metric '' "${mem:-?}" '%' 65 80 90)

if [[ -n "${cpu_temp:-}" ]]; then
  temp_display=$(format_metric '' "$cpu_temp" '°C' 70 80 85)
  printf '%s ' "$temp_display"
fi
printf '%s %s' "$cpu_display" "$mem_display"
