#!/bin/sh

m1=$(xrandr | grep " connected" | head -1 | cut -d ' ' -f 1)
m2=$(xrandr | grep " connected" | tail -1 | cut -d ' ' -f 1)
xrandr --output $m1 --auto --output $m2 --auto --right-of $m1
sxhkd &
xrandr --dpi 160
xset b off
xsetroot -cursor_name left_ptr
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources

if [ "$(hostname)" = "lenovo-arch" ]; then
    compton &
    lxpanel &
    exec echinus
else
    xcompmgr -cCfF -r6 -l-8 -t-6 -o.5 -D5 &
    exec python ~/bin/wm
    # exec swm
fi
