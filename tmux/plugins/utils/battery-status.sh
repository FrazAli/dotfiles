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

is_discharging=false
if echo "$batt_info" | grep -qi "discharging"; then
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
    batt_status="${batt_icon} ${batt_percent}%"
else
    batt_status=""
fi

color_reset=${color_prefix:+#[fg=default]}
echo "${color_prefix}${warning}${batt_status}${color_reset}"
