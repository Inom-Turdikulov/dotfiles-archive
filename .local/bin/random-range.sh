#!/bin/sh
read -r random_min
read -r random_max
notify-send -t 10000 "[$(random-dot-org integers --min $random_min --max $random_max --number 1)] - range $random_min...$random_max" >/dev/null 2>&1
