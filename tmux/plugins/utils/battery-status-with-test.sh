#!/bin/bash

# Get the BATTERY_TEST environment variable from tmux, if it exists
if command -v tmux &> /dev/null && tmux info &> /dev/null; then
    BATTERY_TEST=$(tmux show-environment -g | grep '^BATTERY_TEST=' | cut -d'=' -f2-)
fi

# If BATTERY_TEST is set, use it; otherwise, get the actual battery level
if [ -n "$BATTERY_TEST" ]; then
    BATT=$BATTERY_TEST
else
    BATT=$(pmset -g batt | grep -Eo "[0-9]*%" | head -n 1 | sed 's/%;//')
fi

if [ -z "$BATT" ]; then
    BATT="?"
fi

if [ "$BATT" -le 20 ] 2>/dev/null; then
    BATTERY_STATUS="🪫${BATT}"
else
    BATTERY_STATUS="🔋${BATT}"
fi

echo "${BATTERY_STATUS}"
