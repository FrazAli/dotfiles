#!/usr/bin/env bash
set -euo pipefail

cpu_linux() {
  local prev=/tmp/.tmux_cpu_prev
  read -r _ a b c d e f1 g h i _ < /proc/stat || return
  local idle=$((d + e))
  local nonidle=$((a + b + c + f1 + g + h + i))
  local total=$((idle + nonidle))

  if [[ -f "$prev" ]]; then
    read -r p_total p_idle < "$prev" || true
    local dt=$((total - p_total))
    local di=$((idle - p_idle))
    if (( dt > 0 )); then
      echo $(( (100 * (dt - di)) / dt ))
      echo "$total $idle" > "$prev"
      return
    fi
  fi

  echo "$total $idle" > "$prev"
  echo 0
}

mem_linux() {
  awk '
    /^MemTotal:/ {t=$2}
    /^MemAvailable:/ {a=$2}
    END { if (t>0) printf "%.0f\n", (100*(t-a))/t; else print 0 }
  ' /proc/meminfo
}

cpu_temp_linux() {
  local hwmon name input label zone type raw

  for hwmon in /sys/class/hwmon/hwmon*; do
    [[ -d "$hwmon" ]] || continue
    IFS= read -r name < "$hwmon/name" 2>/dev/null || continue
    case "$name" in
      coretemp|k10temp|zenpower)
        for input in "$hwmon"/temp*_input; do
          [[ -f "$input" ]] || continue
          label=""
          IFS= read -r label < "${input%_input}_label" 2>/dev/null || true
          case "$label" in
            Package\ id\ *|Tctl|CPU)
              IFS= read -r raw < "$input" 2>/dev/null || continue
              [[ "$raw" =~ ^[0-9]+$ ]] || continue
              printf '%d\n' "$(( (raw + 500) / 1000 ))"
              return 0
              ;;
          esac
        done
        ;;
    esac
  done

  for zone in /sys/class/thermal/thermal_zone*; do
    [[ -d "$zone" ]] || continue
    IFS= read -r type < "$zone/type" 2>/dev/null || continue
    case "$type" in
      x86_pkg_temp|cpu-thermal|cpu_thermal|soc_thermal)
        IFS= read -r raw < "$zone/temp" 2>/dev/null || continue
        [[ "$raw" =~ ^[0-9]+$ ]] || continue
        printf '%d\n' "$(( (raw + 500) / 1000 ))"
        return 0
        ;;
    esac
  done

  return 1
}

cpu=$(cpu_linux)
mem=$(mem_linux)
cpu_temp=$(cpu_temp_linux || true)

printf '%s %s %s\n' "$cpu" "$mem" "${cpu_temp:-}"
