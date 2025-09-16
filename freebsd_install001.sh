#!/usr/local/bin/bash
set -exuo pipefail

# RUN THIS AS:
# ./freebsd_install001.sh YOURUSER |& tee -a install001_output.txt
echo ""
echo "Run this script as root on a fresh FreeBSD installation."
echo ""

echo "==================================== INSTALLING BASIC TOOLS ..."
echo ""
pkg install plocate
pkg install sudo
# pkg install octopkg  # i disliked it
pkg install python
pkg install py311-pip  # ne e istina
pkg install bind-tools  # dig, nslookup, bind...
pkg install xscreensaver  # flurry

echo ""
echo "==================================== ENABLE JAILS ..."
echo ""
# enable jails
mkdir /usr/jails
echo 'jail_enable="YES"' >> /etc/rc.conf

echo ""
echo "==================================== CLONING PORTS TREE ..."
echo ""
git clone https://git.freebsd.org/ports.git /usr/ports

echo ""
echo "==================================== INSTALLING LXQT ..."
echo ""
pkg install xorg
pkg install dbus
# pkg install hal
sysrc dbus_enable="YES"
# sysrc hald_enable="YES"
service dbus start
# service hald start

pkg install lxqt slim
sysrc slim_enable="YES"
echo "exec startlxqt" > ~/.xinitrc
# pkg install oxygen-icons  # fixes missing icons
pkg install papirus-icon-theme
pkg install breeze-qt5
pkg install breeze-qt6

echo ""
echo "==================================== ADDING TO BASHRC ..."
echo ""
echo "export PATH=$PATH:~/.local/bin" >> ~/.bashrc
echo "export QT_QPA_PLATFORMTHEME=qt6ct" >> ~/.bashrc
echo "alias vi='vim'" >> ~/.bashrc

echo ""
echo "==================================== ENABLE USERS IN LXQT ..."
echo ""
# add users to group "video" so they could login in lxqt !!!
echo "exec startlxqt" > /home/$1/.xinitrc
chown $1:$1 /home/yourusername/.xinitrc
## chmod +x ~/.xinitrc  # really ?? - no need

echo ""
echo "==================================== DONE. REBOOT ..."
echo ""

reboot
