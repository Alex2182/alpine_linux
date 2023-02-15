#!/bin/sh
user=alex21
#enable community repository in /etc/apk/repositories
cat /etc/apk/repositories | grep v | grep commu | cut -d '#' -f 2 >> /etc/apk/repositories
#
apk update && apk upgrade
#
adduser $user
apk add neovim htop mc fish
#change shell in /etc/passwd for root and regular user
# Install i3wm official guide
# install drivers
apk search xf86-input*
apk add xf86-input-intel
apk search xf86-video*
apk add xf86-video-fbdev xf86-video-vesa xf86-video-intel
# install font
apk add terminus-font
# install dbus
apk add dbus
dbus-uuidgen > /var/lib/dbus/machine-id
rc-update add dbus
# install xorg
setup-xorg-base
# install i3 & terminal
apk add i3wm i3status xfce4-terminal
# add user to groups input,video,audio
addgroup $user input
addgroup $user video
addgroup $user audio
#create file for startx
echo exec /usr/bin/i3 > .xinitrc
#install login manager
apk add slim
rc-update add slim default
# Install audio official guide
#install packages for sound
apk add alsa-utils alsa-utils-doc alsa-lib alsaconf alsa-ucm-conf
#setup sound settings
alsamixer
#add alsa to default boot
rc-service alsa start
rc-update add alsa
#
# Install russian keyboard layouts in console and x separately
# install packeges for keyboard settings and font
apk add terminus-font kbd-bkeymaps kbd
# activate x settings for us,ru keyboard
echo "setxkbmap -model pc105 -layout us,ru -option grp:alt_shift_toggle &" > /home/$user/.xinitrc
echo "exec i3" >> /home/$user/.xinitrc
#
