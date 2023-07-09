#!/usr/bin/env bash

_ps=(picom polkit-gnome-authentication-agent-1 slstatus)
for _prs in "${_ps[@]}"; do
	if [[ `pidof ${_prs}` ]]; then
		killall -9 ${_prs}
	fi
done

# Fix cursor
xsetroot -cursor_name left_ptr

# Polkit agent
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# Restore wallpaper
nitrogen --restore

# Notification daemon
dunst &

# Lauch compositor
picom -b --experimental-backends

# Load status bar
slstatus &
