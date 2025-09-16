#!/usr/local/bin/bash
set -exuo pipefail

echo ""
echo "Run this script as root on a fresh FreeBSD installation."
echo "USAGE: ./freebsd_install002.sh |& tee -a install002_output.txt"
echo ""

echo ""
echo "NOTE: My actual LXQT settings:"
echo "qtstyle: breeze"
echo "gtk themes: Arc-Dark"
echo "icons theme: ePapirus"
echo "colors: Arc"
echo ""

echo "==================================== INSTALLING OTHER APPS ..."
echo ""

pkg install -y firefox
pkg install -y chromium
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
# install betterbird mail client or thunderbird
pkg install -y geany
pkg install -y geany-plugins
pkg install -y thunderbird

# freebsd-update fetch install
# 14.3-RELEASE-p2

echo ""
echo "==================================== INSTALLING VIM PLUGINS ..."
echo ""
mkdir -p ~/.vim/autoload
mkdir -p ~/.vim/plugged
fetch -o ~/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo "call plug#begin('~/.vim/plugged')" >> ~/.vimrc
echo "Plug 'dense-analysis/ale'" >> ~/.vimrc
echo "call plug#end()" >> ~/.vimrc

echo "Run in vim:"
echo ":PlugInstall"
echo "Test installation:"
echo ":echo ale#engine#IsChecking()"

echo ""
echo "Done."
