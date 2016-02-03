#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

xrdb -merge ~/.Xresources
setxkbmap -model pc104 -layout us,ru -variant dvp, -option grp:alt_space_toggle,ctrl:nocaps &

export GTK_IM_MODULE='uim'
export QT_IM_MODULE='uim'
export XMODIFIERS='@im=uim'
uim-xim &

sxhkd &
xset b off
exec bspwm
