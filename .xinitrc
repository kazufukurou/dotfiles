#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/*; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

m1=$(xrandr | grep " connected" | head -1 | cut -d ' ' -f 1)
m2=$(xrandr | grep " connected" | tail -1 | cut -d ' ' -f 1)
xrandr --output $m1 --auto --output $m2 --auto --right-of $m1
sxhkd &
xkb dvp
xrandr --dpi 160
xset b off
xsetroot -solid "#333333"
xsetroot -cursor_name left_ptr
wew | wmc loop
