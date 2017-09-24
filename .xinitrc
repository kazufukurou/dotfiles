#!/bin/sh

m1=$(xrandr | grep " connected" | head -1 | cut -d ' ' -f 1)
m2=$(xrandr | grep " connected" | tail -1 | cut -d ' ' -f 1)
xrandr --output $m1 --auto --output $m2 --auto --right-of $m1
xrandr --dpi 160
xset b off
xsetroot -cursor_name left_ptr
setxkbmap -model pc104 -layout us,ru, -option grp:alt_space_toggle
sxhkd &
dunst &
udiskie &
compton -cCGfG -r6 -l-8 -t-6 -o.5 -D5 &
# compton -cCGfG -r6 -l-8 -t-6 -o.5 -D5 --inactive-dim .3 &
# exec dbus-launch ck-launch-session jwm
conky -d
exec dbus-launch jwm
# exec ~/repos/tawm/tawm 4 h t m w
