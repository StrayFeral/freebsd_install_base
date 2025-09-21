#!/usr/local/bin/bash
set -exuo pipefail

ver=$(freebsd-version | cut -d- -f1)  # get base version, e.g. "13.5" or "14.1"

echo ""
echo "Run this script as root on a fresh FreeBSD installation."
echo "USAGE: ./freebsd_install001.sh YOURUSER |& tee -a install001_output.txt"
echo ""

if [ -z "$1" ]; then
    echo "USAGE: freebsd_install001.sh YOURNEWUSER"
    echo "Error: missing argument" >&2
    exit 1
fi

# Basic configs for the new user comfort
cp .bashrc /home/$1/
cp .vimrc /home/$1/

echo "==================================== INSTALLING BASIC TOOLS ..."
echo ""
pkg install -y plocate          # files finder
pkg install -y python           # python3
pkg install -y py311-pip        # python3 package manager
pkg install -y bind-tools       # dig, nslookup, bind...
pkg install -y xscreensaver     # flurry; you might NOT want this on a VM

echo ""
echo "==================================== ENABLE JAILS ..."
echo ""
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
echo "exec startlxqt" >> ~/.xinitrc
# pkg install -y oxygen-icons  # fixes missing icons
pkg install -y papirus-icon-theme

if [[ "$ver" == 13* ]]; then
    echo "FreeBSD 13.x specific ..."
    pkg install -y kf6-breeze-icons
    pkg install -y plasma6-breeze-gtk
elif [[ "$ver" == 14* ]]; then
    echo "FreeBSD 14.x specific ..."
    pkg install -y breeze-qt5
    pkg install -y breeze-qt6
else
    echo "Unsupported FreeBSD version: $ver"
fi

echo ""
echo "==================================== ENABLE USERS IN LXQT ..."
echo ""
# add users to group "video" so they could login in lxqt ? - no need
echo "exec startlxqt" >> /home/$1/.xinitrc
chown $1:$1 /home/$1/.xinitrc
## chmod +x ~/.xinitrc  # really ?? - no need

echo ""
echo "NOTE: My actual LXQT settings:"
echo "qtstyle: breeze"
echo "gtk themes: Arc-Dark"
echo "icons theme: ePapirus"
echo "colors: Arc"
echo ""

echo ""
echo "==================================== DONE. REBOOT ..."
echo ""

reboot
