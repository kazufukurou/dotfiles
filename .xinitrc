#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

xrdb -merge ~/.Xresources
~/bin/setxkblayout

#export XMODIFIERS=@im=SCIM
#export GTK_IM_MODULE="scim"
#export QT_IM_MODULE="scim"
#scim -d

sxhkd &
xsetroot -cursor_name left_ptr
xset b off
exec bspwm
