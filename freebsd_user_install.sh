#!/usr/local/bin/bash
set -exuo pipefail

# RUN THIS AS:
# ./freebsd_user_install.sh |& tee -a install_user_output.txt
echo ""
echo "Run this script as YOUR USER on a fresh FreeBSD installation."
echo ""

echo "==================================== CHANGE MOTD ..."
echo ""
sudo cp /etc/motd /home/$USER/Documents/motd
sudo chown $USER:$USER /home/$USER/Documents/motd
sudo vi etc/motd

echo "==================================== ENABLE SUDO ..."
echo ""
# add any user to group "wheel"
visudo
echo "uncomment this:"
echo "%wheel ALL=(ALL:ALL) ALL"

# change sudo password timeout
sudo visudo
echo "add this line at the bottom:"
echo "Defaults timestamp_timeout=300  # 5 hours"

echo "==================================== LXQT FINAL MODIFICATIONS ..."
echo ""
echo "right click application menu > configure > widgets"
echo 'remove "fancy app menu", add "app menu"'

echo "==================================== CREATE PERL LOCAL LIB ..."
echo ""
#perl -MCPAN -e shell
echo "install Term::ReadLine::Perl"
echo "install CPAN"
echo "reload cpan"
# install perlcritic
# install perltidy
# install Perl::Tidy
echo "install Perl::Critic"
echo "install Test2::V0"
perl -MCPAN -e shell
# install ale for vim and config it
pkg install vim-ale

echo ""
echo "INSTALL BULGARIAN TRADITIONAL PHONETIC LAYOUT"
