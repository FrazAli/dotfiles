#!/bin/bash

batt_info=$(pmset -g batt 2>/dev/null)

batt_percent=$(echo "$batt_info" | grep -Eo "[0-9]+%" | head -n 1 | tr -d '%')
if [ -z "$batt_percent" ]; then
    batt_percent="?"
fi

if echo "$batt_info" | grep -qi "discharging"; then
    plugged=""
else
    plugged="⚡️"
fi

if [ "$batt_percent" != "?" ] && [ "$batt_percent" -le 20 ] 2>/dev/null; then
    batt_status="🪫${batt_percent}%"
else
    batt_status="🔋${batt_percent}%"
fi

echo "${plugged}${batt_status}"
