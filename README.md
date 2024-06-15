# Bash Scripts

## About

I am learning bash scripting and in here i want to graduatly add usefull scripts for myself and anybody else.

## Scripts

The after linux installation script walks you through a few steps to get your system with basic developer tools running.
First you can install what ever packages you want to install. Then you can setup git and create a beautiful terminal.
There is also a useful nano and vim configuration which can be added. At the end you can install Vencord, a useful tool for Discord.
With Vencord you can customize Discord with a bunch of plugins.

## Themes, Icons and Cursors

Themes and icons can be installed by unpacking the content and moving the content to the appropiate location in the system.
themes go to <strong>/usr/share/themes</strong>
icons and cursors go to <strong>/usr/share/icons</strong>. To move files you can use the *mv*-command.
So just type in your terminal: ```sudo mv <content> destination```
If you want to use the neofetch theme then copy the contents of the txt file to <strong>~/.config/neofetch/config.conf</strong>

## Ulauncher

Ulauncher is a app quick-launcher. It works like spotlight search on MacOS.

### GRUB Themes

The grub-theme can be installed with python: ```sudo python3 <name of the theme.py> -i```
and to uninstall it do: ```sudo python3 <name of the theme.py> -u```

