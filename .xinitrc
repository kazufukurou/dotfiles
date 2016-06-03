#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

xrdb -merge ~/.Xresources
sxhkd &
~/bin/initxkbmap dvp

xrandr --dpi 160
xset b off
urxvt -name panel -geometry 212x2 -bw 0 -b 0 -bg "#000000" -e ~/bin/panel &
exec swm
#exec bspwm
