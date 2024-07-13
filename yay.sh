#!/bin/bash

# installing yay
git clone "https://aur.archlinux.org/yay.git"
sleep 2
cd "$HOME/yay"
sleep 2
makepkg -si

# installing software with yay
yay -S google-chrome
yay -S heroic-games-launcher-bin
yay -S lightdm-settings
