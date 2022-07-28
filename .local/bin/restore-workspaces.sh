#!/bin/sh
# load display configuration
autorandr --change || true

# Set random wallpaper from ~/pictures/wallpapers
sleep 3
random-wallpaper.sh &

for workspace in `cat ~/.i3/workspaces`
do
   echo "Restore: $workspace"
   i3-resurrect restore -w "$workspace"
   sleep 2
done

kdeconnect-indicator &
