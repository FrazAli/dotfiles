#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd -- "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

batt_percent="?"
batt_status=""
case "$(uname -s)" in
  Darwin) helper="${script_dir}/battery-macos.sh" ;;
  Linux)  helper="${script_dir}/battery-linux.sh" ;;
  *)      helper="" ;;
esac

if [[ -n "${helper:-}" && -x "$helper" ]]; then
  if out=$("$helper" 2>/dev/null); then
    read -r batt_percent batt_status <<<"$out"
  fi
fi

batt_percent=${batt_percent:-?}
case $batt_percent in
  ''|'?')
    batt_value=-1
    ;;
  *)
    batt_value=$batt_percent
    ;;
esac

is_discharging=false
# Bash 3.2 on macOS lacks ${var,,}; use tr for lowercase comparison
status_lower=$(printf '%s' "${batt_status:-}" | tr '[:upper:]' '[:lower:]')
if [[ "$status_lower" == discharging* ]]; then
  is_discharging=true
fi

batt_icon=""
if (( batt_value >= 0 )); then
  if $is_discharging; then
    if (( batt_value == 100 )); then
      batt_icon="󰁹"
    elif (( batt_value >= 70 )); then
      batt_icon="󱊣"
    elif (( batt_value >= 30 )); then
      batt_icon="󱊢"
    elif (( batt_value >= 6 )); then
      batt_icon="󱊡"
    else # 0-5
      batt_icon="󰂎"
    fi
  else # charging or fully charged
    if (( batt_value == 100 )); then
      batt_icon="󰂄"
    elif (( batt_value >= 70 )); then
      batt_icon="󱊦"
    elif (( batt_value >= 30 )); then
      batt_icon="󱊥"
    elif (( batt_value >= 6 )); then
      batt_icon="󱊤"
    else # 0-5
      batt_icon="󰢟"
    fi
  fi
fi

warning=""
color_prefix=""
if $is_discharging; then
  (( batt_value >= 0 && batt_value <= 5 )) && { warning="🔴⚠️"; color_prefix="#[fg=#ff0000]"; }
  (( batt_value > 5 && batt_value <= 10 )) && { warning="⚠️"; color_prefix="#[fg=orange]"; }
fi

if (( batt_value >= 0 )); then
  batt_display="${batt_icon} ${batt_percent}%"
else
  batt_display="󰂃 ?%"
fi

color_reset=${color_prefix:+#[fg=default]}
echo "${color_prefix}${warning}${batt_display}${color_reset}"
