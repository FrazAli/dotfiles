#!/usr/bin/env bash
set -euo pipefail

read_sysfs_battery() {
  local bat_path cap status
  bat_path=$(ls -d /sys/class/power_supply/BAT* 2>/dev/null | head -n 1 || true)
  [[ -z "$bat_path" ]] && return 1
  cap=$(cat "$bat_path/capacity" 2>/dev/null || true)
  status=$(cat "$bat_path/status" 2>/dev/null || true)
  [[ -z "$cap" ]] && return 1
  printf '%s %s\n' "$cap" "${status:-unknown}"
}

read_sysfs_battery
