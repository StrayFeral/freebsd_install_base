#!/usr/local/bin/bash
set -exuo pipefail

echo ""
echo "Run this script as YOUR USER on a fresh FreeBSD installation."
echo "USAGE: ./freebsd_user_install.sh |& tee -a install_user_output.txt"
echo ""

echo "==================================== CHANGE MOTD ..."
echo ""
mkdir -p /home/$USER/Documents
sudo cp /etc/motd /home/$USER/Documents/motd
sudo chown $USER:$USER /home/$USER/Documents/motd  # backup
sudo cp /home/$USER/freebsd_install_base/motd /etc/motd
sudo chown root:wheel /etc/motd
# sudo vi etc/motd

echo ""
echo "==================================== LXQT FINAL MODIFICATIONS ..."
echo ""
echo "right click application menu > configure > widgets"
echo 'remove "fancy app menu", add "app menu"'

echo ""
echo "==================================== CREATE PERL LOCAL LIB ..."
echo ""
# Yes, I know this could be automated
echo "install Term::ReadLine::Perl"
echo "install CPAN"
echo "reload cpan"
echo "install Perl::Critic"
echo "install Test2::V0"
perl -MCPAN -e shell

echo ""
echo "FINALLY: INSTALL BULGARIAN TRADITIONAL PHONETIC LAYOUT"
echo ""
echo "Done."
