#!/usr/bin/env sh

if [ -d "$HOME/pictures/wallpapers/" ]; then
   wfile=$(find ~/pictures/wallpapers/*.jpg -type f | shuf -n 1)
   ext="${wfile##*.}"
   if [ "$ext" == jpg ]; then
      feh --bg-fill $wfile &
   fi
fi
