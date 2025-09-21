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
    
    # okay, i tried - so vscode requires electron37 but it fails
    # to compile on freebsd13.5
    # so i won't uncomment this.
    # sorry.
    
    #cd /usr/ports/devel/electron37
    #make install clean

    #cd /usr/ports/editors/vscode
    #make install clean
elif [[ "$ver" == 14* ]]; then
    echo "FreeBSD 14.x specific ..."
    pkg install -y chromium     # browser
    pkg install -y vscode       # programming editor
else
    echo "Unsupported FreeBSD version: $ver"
fi

pkg install -y firefox          # browser

pkg install -y regexxer         # graphical file content regex finder
pkg install -y ghex             # hex editor
pkg install -y meld             # graphical diff
pkg install -y vlc              # media player
pkg install -y gimp             # image manipulation program
pkg install -y libreoffice      # office package
pkg install -y gnome-clocks     # useful clocks
pkg install -y geany            # programming editor
pkg install -y geany-plugins
pkg install -y thunderbird      # mail client
# install betterbird mail client or thunderbird ?

echo ""
echo "Done."
