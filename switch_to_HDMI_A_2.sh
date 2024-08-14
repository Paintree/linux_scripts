#!/bin/bash

# Define your monitor and TV names
MONITOR="DP-1"
TV="HDMI-A-2"

TV_AUDIO_SINK=$(pactl list short sinks | grep 'alsa_output.pci-0000_01_00.1.hdmi' | awk '{print $2}')

pactl set-default-sink "$TV_AUDIO_SINK"
kscreen-doctor output.$TV.enable output.$MONITOR.disable

