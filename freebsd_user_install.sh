#!/usr/local/bin/bash
set -exuo pipefail

echo ""
echo "Run this script as YOUR USER on a fresh FreeBSD installation."
echo "USAGE: ./freebsd_user_install.sh |& tee -a install_user_output.txt"
echo ""

# the ssh keys would go there - this is up to you
mkdir -p ~/.ssh

# ok, you might not want this, but i want it
echo "==================================== CHANGE MOTD ..."
echo ""
mkdir -p ~/Documents
sudo cp /etc/motd ~/Documents/motd
sudo chown $USER:$USER ~/Documents/motd  # backup
sudo cp ~/freebsd_install_base/motd /etc/motd
sudo chown root:wheel /etc/motd

echo ""
echo "==================================== CREATE PERL LOCAL LIB ..."
echo ""
export PERL_MM_USE_DEFAULT=1
perl -MCPAN -e 'CPAN::HandleConfig->load; CPAN::HandleConfig->defaults; CPAN::HandleConfig->commit'
perl -MCPAN -e 'CPAN::Shell->install("CPAN"); CPAN::Shell->reload("cpan")'
perl -MCPAN -e 'CPAN::Shell->install("Term::ReadLine::Perl")'
perl -MCPAN -e 'CPAN::Shell->install("Perl::Critic")'
perl -MCPAN -e 'CPAN::Shell->install("Test2::V0")'

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
echo "==================================== LXQT FINAL MODIFICATIONS ..."
echo ""
echo "right click application menu > configure > widgets"
echo 'remove "fancy app menu", add "app menu"'

echo ""
echo "FINALLY: INSTALL BULGARIAN TRADITIONAL PHONETIC LAYOUT"
echo ""
echo "Done."
