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
xsetroot -cursor_name left_ptr
st -n panel -e panel &
exec swm
