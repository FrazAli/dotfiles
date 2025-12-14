#!/usr/bin/env bash
set -euo pipefail

batt_info=$(pmset -g batt 2>/dev/null || true)

batt_percent=$(echo "$batt_info" | grep -Eo "[0-9]+%" | head -n 1 | tr -d '%')
status=$(echo "$batt_info" | grep -ioE 'discharging|charging|finishing charge|charged|full' | head -n 1 || true)

[[ -z "$batt_percent" ]] && exit 1

echo "$batt_percent" "${status:-unknown}"
