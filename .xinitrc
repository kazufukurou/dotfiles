#!/bin/sh

[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources
m1=$(xrandr | grep " connected" | head -1 | cut -d ' ' -f 1)
m2=$(xrandr | grep " connected" | tail -1 | cut -d ' ' -f 1)
xrandr --output $m1 --auto --output $m2 --auto --right-of $m1
xrandr --dpi 160
xset b off
xsetroot -cursor_name left_ptr
sxhkd &
compton &
if [ "$(hostname)" = "lenovo-arch" ]; then
    lxpanel &
    exec echinus
else
    exec ~/repos/0wm/0wm
fi
