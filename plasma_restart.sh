#!/bin/bash

echo "Restarting Plasma 6 via systemd..."

if systemctl --user status plasma-plasmashell.service &>/dev/null; then
  systemctl --user restart plasma-plasmashell.service
  echo "Plasma restarted."
else
  echo "plasma-plasmashell.service not found. Are you running Plasma 6 with systemd user services?"
fi
