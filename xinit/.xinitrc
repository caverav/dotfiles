#!/bin/bash

# invoke global X session script
if [ -d /etc/X11/xinit/xinitrc.d ]; then
	for f in /etc/X11/xinit/xinitrc.d/*; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi
# bash /home/camilo/xinputenable.sh
source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK
# /usr/bin/bash /home/camilo/dwm-camilo/dwmbar &
# /bin/mkdir /tmp/scrot

feh --bg-fill .wallpapers/old.png &
# /usr/bin/picom &
export _JAVA_AWT_WM_NONREPARENTING=1 # para no reparentar las ventanas de Java (tiene problemas con dwm)
/usr/bin/sct 4500
nm-applet &
flameshot &

# exec bspwm
# exec wrappedhl
# exec dwm
