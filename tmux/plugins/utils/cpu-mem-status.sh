#!/usr/bin/env bash
set -euo pipefail

OS=$(uname -s)

cpu_macos() {
  # Sum per-process %CPU and normalize by core count (no fragile top parsing)
  local ncpu
  ncpu=$(sysctl -n hw.logicalcpu 2>/dev/null || sysctl -n hw.ncpu)
  # ps returns % per core; sum and divide
  ps -A -o %cpu | awk -v n="$ncpu" 'NR>1 {s+=$1} END { if (n>0) printf "%.0f\n", s/n; else print 0 }'
}

mem_macos() {
  # Prefer memory_pressure (already locale-safe in your script). If it fails, fallback to vm_stat:
  local used
  used=$(
    LC_ALL=C memory_pressure -l 2>/dev/null \
      | awk -F': *' '/System-wide.*percentage/ { sub("%","",$2); printf "%.0f\n", 100-$2; exit }'
  )
  [[ -n "$used" ]] && { echo "$used"; return; }

  # Fallback: vm_stat with "available = free + speculative + inactive + purgeable"
  LC_ALL=C vm_stat | awk '
    /Pages free/                          { free = $NF+0 }
    /Pages speculative/                   { spec = $NF+0 }
    /Pages inactive/                      { inact = $NF+0 }
    /(Pages wired|Pages wired down)/      { wired = $NF+0 }
    /Pages active/                        { act = $NF+0 }
    /Pages occupied by compressor/        { comp = $NF+0 }
    /Pages purgeable/                     { purg = $NF+0 }
    END {
      total = free + spec + act + inact + wired + comp
      avail = free + spec + inact + purg
      if (total > 0) printf "%.0f\n", 100*(total - avail)/total; else print 0
    }'
}

cpu_linux() {
  # Simple one-shot from /proc/stat (no sleep), needs previous sample; else 0
  local prev=/tmp/.tmux_cpu_prev
  read -r _ a b c d e f1 g h i _ < /proc/stat || return
  local idle=$((d + e))
  local nonidle=$((a + b + c + f1 + g + h + i))
  local total=$((idle + nonidle))
  if [[ -f "$prev" ]]; then
    read -r p_total p_idle < "$prev" || true
    local dt=$((total - p_total)) di=$((idle - p_idle))
    if (( dt > 0 )); then
      echo $(( (100*(dt-di))/dt )); echo "$total $idle" > "$prev"; return
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

  # Prefer CPU-specific hwmon drivers and their package/control temperature.
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

  # Some kernels expose the CPU package only through the thermal subsystem.
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

case "$OS" in
  Darwin) cpu=$(cpu_macos); mem=$(mem_macos) ;;
  Linux)  cpu=$(cpu_linux); mem=$(mem_linux); cpu_temp=$(cpu_temp_linux || true) ;;
  *)      cpu="?"; mem="?" ;;
esac

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
