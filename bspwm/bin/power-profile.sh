#!/bin/bash

# This script is used to switch between power profiles with powerprofilesctl in polybar

# get current profile
current_profile=$(powerprofilesctl get)

profiles=(balanced performance power-saver)

# get index of current profile
current_index=$(printf '%s\n' "${profiles[@]}" | grep -n "$current_profile" | cut -d: -f1)

# get next profile
next_index=$((current_index % ${#profiles[@]} + 1))
next_profile=${profiles[$next_index - 1]}
powerprofilesctl set $next_profile

# notify user
notify-send "Power profile" "$next_profile"
