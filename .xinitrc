#!/usr/bin/env bash

# Load dconf settings from text configuration
export XDG_CONFIG_HOME="$HOME/.config"
run-parts --list $XDG_CONFIG_HOME/dconf/user.d | xargs cat | dconf load /

export PATH=$HOME/.local/bin:$PATH

# Last minute switch it to dwm, so the systemd unit loads the correct session
export DESKTOP_SESSION=dwm
systemctl --user set-environment DESKTOP_SESSION=dwm
systemctl --user set-environment XDG_CONFIG_HOME="$HOME/.config"
exec /usr/lib/gnome-session/run-systemd-session gnome-session-flashback.target
