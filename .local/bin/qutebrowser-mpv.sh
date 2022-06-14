#!/usr/bin/env bash
# based on
# https://www.reddit.com/r/qutebrowser/comments/acx6uc/my_picture_in_picture_workaround_for_qutebrowser/
#
# Workaround for picture in picture like chrome
# If you want enable sticky (i3wm only), add this line into i3 config:
# i3 -> for_window [class="mpv" instance="Picture-in-Picture"] floating enable

link="$1"

launch_options=""
launch_options+=" --really-quiet --fs=no --force-window"
launch_options+=" --volume=70"
launch_options+=" --autofit=35% --geometry=-10-50"
launch_options+=" --x11-name=Picture-in-Picture"

launch_cmd=(/usr/bin/mpv $launch_options "$link")

# start mpv in detached mode
"${launch_cmd[@]}" &
