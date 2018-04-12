#!/usr/bin/env bash

# gnome-panel has OnlyShowIn=GNOME-Flashback, which for some dumb reason
#    prevents a gnome-session from starting it.
# export XDG_CURRENT_DESKTOP="GNOME-Flashback"

# Load dconf settings from text configuration
export XDG_CONFIG_HOME="$HOME/.config"
run-parts --list $XDG_CONFIG_HOME/dconf/user.d | xargs cat | dconf load /

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

export PATH=$HOME/.local/bin:$PATH

#prlcc &
#ptiagent --info &
#synapse &
#gnome-panel &
exec gnome-session --session=dwm
#/sbin/initctl emit indicator-services-start



