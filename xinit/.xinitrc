#!/bin/bash

# invoke global X session script
if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi
bash /home/camilo/xinputenable.sh
bash /home/camilo/dwm-camilo/dwmbar &
/home/camilo/.fehbg &
compton &
dunst &
setxkbmap latam &
exec dwm
