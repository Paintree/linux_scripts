#!/bin/bash

MONITOR="DP-1"
TV="HDMI-A-2"

MONITOR_AUDIO_SINK="alsa_output.usb-Topping_DX3_Pro_-00.HiFi__Headphones__sink"

pactl set-default-sink $MONITOR_AUDIO_SINK
kscreen-doctor output.$TV.disable output.$MONITOR.enable
