#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

sxhkd &
initxkbmap dvp
xrandr --dpi 160
xset b off
xsetroot -solid "#333333"
st -n panel -g 214x2 -e panel &
exec swm
