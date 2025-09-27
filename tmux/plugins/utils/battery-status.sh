#!/bin/bash

batt_info=$(pmset -g batt 2>/dev/null)

batt_percent=$(echo "$batt_info" | grep -Eo "[0-9]+%" | head -n 1 | tr -d '%')
batt_percent=${batt_percent:-?}
case $batt_percent in
    ''|'?')
        batt_value=-1
        ;;
    *)
        batt_value=$batt_percent
        ;;
esac

plugged="⚡️"
warning=""
color_prefix=""
if echo "$batt_info" | grep -qi "discharging"; then
    plugged=""
    (( batt_value >= 0 && batt_value <= 5 )) && { warning="🔴⚠️"; color_prefix="#[fg=#ff0000]"; }
    (( batt_value >= 5 && batt_value <= 10 )) && { warning="⚠️"; color_prefix="#[fg=orange]"; }
fi
color_reset=${color_prefix:+#[fg=default]}

batt_status="🔋${batt_percent}%"
(( batt_value >= 0 && batt_value <= 20 )) && batt_status="🪫${batt_percent}%"

echo "${color_prefix}${warning}${plugged}${batt_status}${color_reset}"
