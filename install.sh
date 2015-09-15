#! /bin/bash
sudo dnf install -y gparted
sudo dnf install -y fish
sudo dnf install -y gcc
sudo dnf install -y vim
sudo dnf install -y gvim
sudo dnf install -y clang
sudo dnf install -y golang
sudo dnf install -y htop
sudo dnf install -y terminator
sudo dnf install -y gnome-tweak-tool
wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
sudo dnf install -y ./google-chrome-stable_current_x86_64.rpm
rm -rf ./google-chrome-stable_current_x86_64.rpm
su -c 'dnf install -y --nogpgcheck http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm'


#programming tools installed.
#Install chrome.
