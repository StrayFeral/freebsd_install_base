#!/usr/local/bin/bash
set -exuo pipefail

# RUN THIS AS:
# ./freebsd_install002.sh |& tee -a install002_output.txt
echo ""
echo "Run this script as root on a fresh FreeBSD installation."
echo ""

echo ""
echo "MY ACTUAL LXQT SETTINGS:"
echo "qtstyle: breeze"
echo "gtk themes: Arc-Dark"
echo "icons theme: ePapirus"
echo "colors: Arc"
echo ""

echo "==================================== INSTALLING OTHER APPS ..."
echo ""

pkg install firefox
pkg install chromium
pkg install vscode
pkg install regexxer
pkg install ghex
pkg install meld
# download advanced rest client: arc-linux
# pkg install terminator  # problem - space after each char !
pkg install vlc
pkg install gimp
pkg install libreoffice
pkg install gnome-clocks
# pkg install kcalc
pkg install arc
# install betterbird mail client or thunderbird
pkg install geany
pkg install geany-plugins
pkg install thunderbird

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
