#!/bin/bash
TIMEOUT=10
APPLIST_TO_TERMINATE=(
	# edit this list
    telegram-desktop
    chrome
    zeal
    chrome
    crow
    qstardict
    zeal
    steam
    parcellite
    nm-applet
    nclutter
    dunst
    udiskie
    blueman-applet
    parcellite
    mpDris2
    bittorrent-nox
    tapper
    syncthing
    ss-local
    blackd
    keebie
    clipit
    polybar
    udiskie
)

close_windows () {
	wmctrl -l | awk '{print $1}' | while read -r wId
	do
		wmctrl -i -c $wId
	done
}

window_timeout_countdown () {
	for i in $(seq 1 $TIMEOUT);
	do
		if [[ -z $(wmctrl -l) ]]; then
			return 0
		fi
		sleep 1
	done
	exit 1
}

terminate_processes () {
	pidof ${APPLIST_TO_TERMINATE[@]} | tr ' ' '\n' | while read -r pid
	do
        if [[ -n $pid ]];then
            echo $pid
            kill -15 $pid
            tail --pid=$pid -f /dev/null # wait until terminate it
        fi
	done
}

close_windows
window_timeout_countdown
terminate_processes
