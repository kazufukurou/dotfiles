#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

xrdb -merge ~/.Xresources
setxkbmap -model pc104 -layout us,ru -variant dvp, -option grp:alt_space_toggle,ctrl:nocaps

#export XMODIFIERS=@im=SCIM
#export GTK_IM_MODULE="scim"
#export QT_IM_MODULE="scim"
#scim -d

#export _JAVA_AWT_WM_NONREPARENTING=1

#autocutsel -fork &
#autocutsel -selection PRIMARY -fork &

#udiskie &
#syndaemon -t -k -i 2 -d &
#dunst &
sxhkd &
xsetroot -cursor_name left_ptr
xset b off
exec bspwm
