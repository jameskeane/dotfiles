#!/usr/bin/env bash

# Load dconf settings from text configuration
if [ -n "$XDG_CONFIG_HOME" ]; then
  CONFIG_HOME="$XDG_CONFIG_HOME"
else
  CONFIG_HOME="$HOME/.config"
fi
run-parts --list $CONFIG_HOME/dconf/user.d | xargs cat | dconf load /
unset CONFIG_HOME

# Load the key map
XKBDIR="$HOME/.xkb"
XKBMAPFILE="$XKBDIR/keymap/$(hostname --fqdn)"
if [ -f "$XKBMAPFILE" ]; then
  echo "Loading keymap from $XKBMAPFILE"
  xkbcomp -I"$XKBDIR" "$XKBMAPFILE" "${DISPLAY%%.*}"
else
  echo "No keybindings found for host: $(hostname --fqdn)"
fi
unset XKBDIR
unset XKBMAPFILE

# Start up the gnome serives
gnome-flashback --initialize &
gnome-flashback &
gnome-panel &
unity-settings-daemon &
/sbin/initctl emit indicator-services-start

# Start wm and apps
xmonad &
GTK_IM_MODULE='' synapse &  # synapse is broken with xim

# Hand off to gnome
exec gnome-session --session=""
