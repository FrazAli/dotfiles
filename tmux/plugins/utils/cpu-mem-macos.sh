#!/usr/bin/env bash
set -euo pipefail

cpu_macos() {
  local ncpu
  ncpu=$(sysctl -n hw.logicalcpu 2>/dev/null || sysctl -n hw.ncpu)
  ps -A -o %cpu | awk -v n="$ncpu" 'NR>1 {s+=$1} END { if (n>0) printf "%.0f\n", s/n; else print 0 }'
}

mem_macos() {
  local used
  used=$(
    LC_ALL=C memory_pressure -l 2>/dev/null \
      | awk -F': *' '/System-wide.*percentage/ { sub("%","",$2); printf "%.0f\n", 100-$2; exit }'
  )
  [[ -n "$used" ]] && { echo "$used"; return; }

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

cpu_temp_macos() {
  local temp

  if command -v macmon >/dev/null 2>&1; then
    temp=$(
      macmon pipe -s 1 -i 250 2>/dev/null \
        | sed -n 's/.*"cpu_temp_avg":[[:space:]]*\([0-9.][0-9.]*\).*/\1/p' \
        | awk '{ printf "%.0f\n", $1; exit }'
    ) || true
    [[ -n "$temp" ]] && { echo "$temp"; return 0; }
  fi

  if command -v osx-cpu-temp >/dev/null 2>&1; then
    temp=$(osx-cpu-temp -C -T 2>/dev/null | awk '{ printf "%.0f\n", $1; exit }') || true
    [[ -n "$temp" ]] && { echo "$temp"; return 0; }
  fi

  return 1
}

cpu=$(cpu_macos)
mem=$(mem_macos)
cpu_temp=$(cpu_temp_macos || true)

printf '%s %s %s\n' "$cpu" "$mem" "${cpu_temp:-}"
