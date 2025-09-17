# FreeBSD base setup
## QUESTIONS BEFORE INSTALLATION
1. Hostname policy?
2. Static IP?

**NOTE: This setup is tested on FreeBSD 13.5 and 14.3**

## IMPORTANT LOCATIONS
* JAILS: /usr/jails
* PORTS: /usr/ports

## WHAT ARE THESE INSTRUCTIONS AND SCRIPTS ACTUALLY DOING?
* Semi-automated installation of FreeBSD
* Setup of root and one more user
* Installation of LXQT (if you want another desktop environment - feel free to modify
* Installation of other utilities

## WHY ARE THESE INSTRUCTIONS AND SCRIPTS CREATED
* To help me create FreeBSD virtual machines faster and eventually help to setup a development host

## INSTALLATION OF FREEBSD
* At this step you are supposed to start installation of FreeBSD one way or another (from flash stick or whatever)
* After you setup the root user, create at least one more user
* Leave the new user initial group as is
* Invite new user to group "wheel" (so they could use "sudo" later)
* Any reference to "YOURNEWUSER" goes to this new (and any new) user you created

## INITIAL MANUAL INSTALL
* These very first steps are supposed to lay out the foundation on top of which the automated scripts below could work but also help you debug installation issues, in case such arise.
```bash
freebsd-update fetch install  # get any system and security updates
pkg update
pkg upgrade

pkg install -y en-freebsd-doc
pkg install -y bash
pkg install -y bash-completion
pkg install -y vim
pkg install -y git
pkg install -y sudo

# Setup bash
echo "/usr/local/bin/bash" | tee -a /etc/shells
chsh -s /usr/local/bin/bash
chsh -s /usr/local/bin/bash YOURNEWUSER  # change the shell for your other new user
```
* Add to /etc/profile:
```bash
# Enable bash completion if available
if [ -f /usr/local/share/bash-completion/bash_completion ]; then
  . /usr/local/share/bash-completion/bash_completion
fi
```
* Create ~/.bashrc - do whatever you want, I won't get into this
* Create ~/.vimrc - same here
* Add to ~/.bash_profile:
```bash
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi
```
* Enable sudo
```bash
# add any new user to group "wheel"
echo "%wheel ALL=(ALL:ALL) ALL" | tee -a /usr/local/etc/sudoers.d/wheelers
# you might NOT want to do the next line, i do it for virtual machines
echo "Defaults timestamp_timeout=300  # 5 hours" | tee -a /usr/local/etc/sudoers.d/wheelers
chmod 0440 /usr/local/etc/sudoers.d/wheelers
```
* Download these automated scripts:
```bash
git clone https://github.com/StrayFeral/freebsd_install_base.git /home/YOURNEWUSER/freebsd_install_base
chown -R YOURNEWUSER:YOURNEWUSER /home/YOURNEWUSER/freebsd_install_base
```
* If this is a virtual machine or container:
```bash
# Add this to /etc/hosts on the line where they define localhost:
# This fixes the retries of sendmail_submit and saves some time on boot-up
blah.local blah

# And if your hostname is not set as blah.local, you need to add this to /etc/rc.conf:
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
