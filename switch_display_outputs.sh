#!/bin/bash

# Discovering displays
ENABLED_DISPLAYS=($(kscreen-doctor -j | jq -r '.outputs[] | select(.enabled == true) | .name'))
DISABLED_DISPLAYS=($(kscreen-doctor -j | jq -r '.outputs[] | select(.enabled == false) | .name'))

# Listing displays
echo "Available display outputs: "
if [ ${#ENABLED_DISPLAYS[@]} -gt 0 ]; then
    echo "Enabled: ${ENABLED_DISPLAYS[@]}"
else
    echo "No enabled displays available"
fi
if [ ${#DISABLED_DISPLAYS[@]} -gt 0 ]; then
    echo "Disabled: ${DISABLED_DISPLAYS[@]}"
else
    echo "No disabled displays available. Exiting"
    exit 1
fi

# Switching displays

if [ ${#DISABLED_DISPLAYS[@]} -gt 0 ]; then
    for DOUT in ${DISABLED_DISPLAYS[@]}; do
        kscreen-doctor output."$DOUT".enable
        if [ $? -eq 0 ]; then
            echo "Successfully enabled display: $DOUT"
        else
            echo "Failed to enable display: $DOUT"
        fi
    done
fi
if [ ${#ENABLED_DISPLAYS[@]} -gt 0 ]; then
    for EOUT in ${ENABLED_DISPLAYS[@]}; do
        kscreen-doctor output."$EOUT".disable
        if [ $? -eq 0 ]; then
            echo "Successfully disabled display: $EOUT"
        else
            echo "Failed to disable display: $EOUT"
        fi
    done
fi

echo "Display switching process completed."

# Discovering sinks
AUDIO_SINKS=($(pactl list short sinks | awk '{print $2}'))
CURRENT_SINK=$(pactl info | grep "Default Sink" | awk '{print $3}')

# Listing audio sinks
if [ ${#ENABLED_DISPLAYS[@]} -gt 0 ]; then
    echo "Available audio sinks ${AUDIO_SINKS[@]}"
else
    echo "No audio sinks available"
fi

if [ ${#AUDIO_SINKS[@]} -ne 2 ]; then
    echo "Exactly two sinks are required to switch. Exiting"
    exit 1
fi

if [ "$CURRENT_SINK" == "${AUDIO_SINKS[0]}" ]; then
    NEW_SINK=${AUDIO_SINKS[1]}
else
    NEW_SINK=${AUDIO_SINKS[0]}
fi

# Set the new sink as the default
pactl set-default-sink "$NEW_SINK"
if [ $? -eq 0 ]; then
    echo "Successfully switched sinks"
else
    echo "Failed to switch sinks."
    exit 1
fi




