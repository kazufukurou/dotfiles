#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

consolekit=""

2scr
xrandr --dpi 160
xset b off
xset s 200
xsetroot -cursor_name left_ptr
dunst &
udiskie -t &
cbatticon &
volumeicon &
compton -cCGfG -r6 -l-8 -t-6 -o.5 -D5 --inactive-dim .3 &
nm-applet &
tint2 &
exec ck-launch-session dbus-launch --sh-syntax --exit-with-session sxhkd & exec cwm
