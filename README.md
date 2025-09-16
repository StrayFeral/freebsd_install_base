# FreeBSD base setup
## QUESTIONS
1. Hostname policy?
2. Static IP?

NOTE: This setup is tested on FreeBSD 13.5 and 14.3

## IMPORTANT LOCATIONS
* JAILS: /usr/jails
* PORTS: /usr/ports

## INSTALLATION OF FREEBSD
* At this step you are supposed to start installation of FreeBSD one way or another (from flash stick or whatever)
* After you setup the root user, create at lease one more user
* Leave the new user initial group as is
* Invite new user to group "wheel" (so they could use "sudo" later

## INITIAL MANUAL INSTALL
* Run:
```bash
freebsd-update fetch install  # get any system and security updates
pkg update
pkg upgrade
## portsnap fetch extract  # get the ports tree

pkg install -y en-freebsd-doc
pkg install -y bash
pkg install -y bash-completion
pkg install -y vim
pkg install -y git

# Setup bash
echo "/usr/local/bin/bash" | tee -a /etc/shells
chsh -s /usr/local/bin/bash
# sudo chsh -s /usr/local/bin/bash root
# use UI "Users and Groups" to change it for my user
chsh -s /usr/local/bin/bash YOURNEWUSER  # whatever username you want
```
* Add to /etc/profile:
```bash
# Enable bash completion if available
if [ -f /usr/local/share/bash-completion/bash_completion ]; then
  . /usr/local/share/bash-completion/bash_completion
fi
```
* Create ~/.bashrc
* Create ~/.vimrc
* Add to ~/.bash_profile:
```bash
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi
```
* Download these automated scripts:
```bash
git clone https://github.com/StrayFeral/freebsd_install_base.git /home/YOURNEWUSER/freebsd_install_base
chown -R YOURNEWUSER:YOURNEWUSER /home/YOURNEWUSER/freebsd_install_base
```
* If this is a virtual machine or container:
```bash
# Add this to /etc/hosts on the line where they define localhost:
# This fixes the retries of sendmail_send
blah.local blah

And if your hostname is not set as blah.local, you need to add this to /etc/rc.conf:
hostname="blah.local"
```
* RELOGIN
```bash
logout
```

## LOGIN AS ROOT and run first automated script with your new added user as a parameter (it will reboot at the end)
```bash
cd /home/YOURNEWUSER/freebsd_install_base
./freebsd_install001.sh YOURUSER |& tee -a install001_output.txt
```

## LOGIN AS ROOT and run second automated script
```bash
cd /home/YOURNEWUSER/freebsd_install_base
./freebsd_install002.sh |& tee -a install002_output.txt
```

## LOGIN AS YOUR NEW USER and run final automated script
```bash
cd ~/freebsd_install_base
./freebsd_user_install.sh |& tee -a install_user_output.txt
```
