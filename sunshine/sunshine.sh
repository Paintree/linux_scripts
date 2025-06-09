#!/bin/bash
set -e

export DISPLAY=:0

# Check if X server is running
if ! pgrep -x Xwayland >/dev/null; then
  echo "Starting X server"
  startx &>/dev/null 2>&1 &
  sleep 2
  if pgrep -x Xwayland >/dev/null; then
    echo "X server started successfully"
  else
    echo "X server failed to start"
  fi
else
  echo "X server already running"
fi


# Check if sunshine is already running
if ! pgrep -x sunshine >/dev/null; then
  sudo ~/Projects/linux_scripts/sunshine/sunshine-setup.sh
  echo "Starting Sunshine!"
  if sunshine > /dev/null 2>&1 & then
    echo "Sunshine started successfully"
  else
    echo "Sunshine failed to start"
  fi
else
  echo "Sunshine is already running"
fi

# Add any other Programs that you want to startup automatically
# e.g.
# steam &> /dev/null &
# firefox &> /dev/null &
# kdeconnect-app &> /dev/null &
