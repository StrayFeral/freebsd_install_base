#!/usr/local/bin/bash
set -exuo pipefail

echo ""
echo "Run this script as YOUR USER on a fresh FreeBSD installation."
echo "USAGE: ./freebsd_user_install.sh |& tee -a install_user_output.txt"
echo ""

mkdir -p /home/$USER/.ssh

echo "==================================== CHANGE MOTD ..."
echo ""
mkdir -p /home/$USER/Documents
sudo cp /etc/motd /home/$USER/Documents/motd
sudo chown $USER:$USER /home/$USER/Documents/motd  # backup
sudo cp /home/$USER/freebsd_install_base/motd /etc/motd
sudo chown root:wheel /etc/motd
# sudo vi etc/motd

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
echo "==================================== LXQT FINAL MODIFICATIONS ..."
echo ""
echo "right click application menu > configure > widgets"
echo 'remove "fancy app menu", add "app menu"'

echo ""
echo "FINALLY: INSTALL BULGARIAN TRADITIONAL PHONETIC LAYOUT"
echo ""
echo "Done."
