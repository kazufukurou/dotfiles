#!/bin/sh

2scr
xrandr --dpi 160
xset b off
xset s 200
xsetroot -cursor_name left_ptr
sxhkd &
dunst &
udiskie -t &
cbatticon &
volumeicon &
compton -cCGfG -r6 -l-8 -t-6 -o.5 -D5 &
nm-applet &
if [ -x "$(command -v startxfce4)" ]; then
    exec startxfce4 --with-ck-launch
else
    exec dbus-launch --exit-with-session ck-launch-session jwm
fi
