#!/bin/bash

# Set system power profile to balanced
if command -v powerprofilesctl >/dev/null 2>&1; then
    echo "Setting power profile to balanced..."
    powerprofilesctl set balanced
else
    echo "Error: powerprofilesctl not found!"
    exit 1
fi
