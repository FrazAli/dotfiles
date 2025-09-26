#!/bin/bash

BATT_PERCENT=$(pmset -g batt | grep -Eo "[0-9]*%" | grep -Eo "[0-9]+" | head -n 1)
if [ -z "$BATT_PERCENT" ]; then
    BATT_PERCENT="?"
fi

if [ "$BATT_PERCENT" -le 20 ] 2>/dev/null; then
    BATT_STATUS="🪫${BATT_PERCENT}%"
else
    BATT_STATUS="🔋${BATT_PERCENT}%"
fi

echo "${BATT_STATUS}"
