#!/usr/local/bin/bash
set -exuo pipefail

ver=$(freebsd-version | cut -d- -f1)  # get base version, e.g. "13.5" or "14.1"

echo ""
echo "Run this script as root on a fresh FreeBSD installation."
echo "USAGE: ./freebsd_install002.sh |& tee -a install002_output.txt"
echo ""

echo "==================================== INSTALLING OTHER APPS ..."
echo ""

if [[ "$ver" == 13* ]]; then
    echo "FreeBSD 13.x specific ..."
    # This actually failed :(
    # pkg install -y linux-chrome
elif [[ "$ver" == 14* ]]; then
    echo "FreeBSD 14.x specific ..."
    pkg install -y chromium
else
    echo "Unsupported FreeBSD version: $ver"
fi

pkg install -y firefox
pkg install -y vscode
pkg install -y regexxer
pkg install -y ghex
pkg install -y meld
# download advanced rest client: arc-linux
# pkg install -y terminator  # problem - space after each char !
pkg install -y vlc
pkg install -y gimp
pkg install -y libreoffice
pkg install -y gnome-clocks
# pkg install -y kcalc
pkg install -y arc
pkg install -y geany
pkg install -y geany-plugins
pkg install -y thunderbird
# install betterbird mail client or thunderbird ?

echo ""
echo "Done."
