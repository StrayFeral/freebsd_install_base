#!/usr/local/bin/bash
set -exuo pipefail

echo ""
echo "Run this script as root on a fresh FreeBSD installation."
echo "USAGE: ./freebsd_install001.sh YOURUSER |& tee -a install001_output.txt"
echo ""

if [ -z "$1" ]; then
    echo "USAGE: freebsd_install001.sh YOURNEWUSER"
    echo "Error: missing argument" >&2
    exit 1
fi

echo "==================================== INSTALLING BASIC TOOLS ..."
echo ""
pkg install -y plocate
pkg install -y sudo
# pkg install -y octopkg  # i disliked it
pkg install -y python
pkg install -y py311-pip  # ne e istina
pkg install -y bind-tools  # dig, nslookup, bind...
pkg install -y xscreensaver  # flurry

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
pkg install -y xorg
pkg install -y dbus
# pkg install -y hal
sysrc dbus_enable="YES"
# sysrc hald_enable="YES"
service dbus start
# service hald start

pkg install -y lxqt slim
sysrc slim_enable="YES"
echo "exec startlxqt" > ~/.xinitrc
# pkg install -y oxygen-icons  # fixes missing icons
pkg install -y papirus-icon-theme
pkg install -y breeze-qt5
pkg install -y breeze-qt6

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
