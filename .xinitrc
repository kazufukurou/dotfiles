#!/bin/sh

m1=$(xrandr | grep " connected" | head -1 | cut -d ' ' -f 1)
m2=$(xrandr | grep " connected" | tail -1 | cut -d ' ' -f 1)
xrandr --output $m1 --auto --output $m2 --auto --right-of $m1
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
