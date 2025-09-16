# FreeBSD base setup
## QUESTIONS
1. Hostname policy?
2. Static IP?

NOTE: This setup is tested on FreeBSD 13.5 and 14.3

## IMPORTANT LOCATIONS
* JAILS: /usr/jails
* PORTS:  /usr/ports

## INITIAL MANUAL INSTALL
* Run:
```bash
freebsd-update fetch install  # get any system and security updates
pkg update
pkg upgrade
## portsnap fetch extract  # get the ports tree

pkg install en-freebsd-doc
pkg install bash
pkg install bash-completion
pkg install vim
pkg install git

# Setup bash
echo "/usr/local/bin/bash" | tee -a /etc/shells
chsh -s /usr/local/bin/bash
# sudo chsh -s /usr/local/bin/bash root
# use UI "Users and Groups" to change it for my user
chsh -s /usr/local/bin/bash MYUSER  # whatever username you want
```
* Add to /etc/profile:
```bash
# Enable bash completion if available
if [ -f /usr/local/share/bash-completion/bash_completion ]; then
  . /usr/local/share/bash-completion/bash_completion
fi
```
* Create ~/.bashrc
* Create vimrc
* Add to ~/.bash_profile:
```bash
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi
```
* RELOGIN
```bash
logout
```

## Run first automated script as ROOT with your new added user as a parameter (it will reboot at the end)
```bash
./freebsd_install001.sh YOURUSER |& tee -a install001_output.txt
```

## Run second automated script as ROOT
```bash
./freebsd_install002.sh |& tee -a install002_output.txt
```

## Run final automated script as your NEW USER
```bash
./freebsd_user_install.sh |& tee -a install_user_output.txt
```
