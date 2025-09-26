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
  local idle=$((d+e)) nonidle=$((a+b+c+f1+g+h+i)) total=$((idle+nonidle))
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

case "$OS" in
  Darwin) cpu=$(cpu_macos); mem=$(mem_macos) ;;
  Linux)  cpu=$(cpu_linux); mem=$(mem_linux) ;;
  *)      cpu="?"; mem="?" ;;
esac

printf " [C:%s%% M:%s%%]" "${cpu:-0}" "${mem:-0}"
