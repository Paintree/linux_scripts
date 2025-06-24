#!/bin/bash

# Set system power profile to performance
if command -v powerprofilesctl >/dev/null 2>&1; then
    echo "Setting power profile to performance..."
    powerprofilesctl set performance
else
    echo "Error: powerprofilesctl not found!"
    exit 1
fi
