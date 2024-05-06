#!/bin/bash

# import os information location 
source /etc/os-release

echo "Welcome to my after linux gnome installation configurator script"
sleep 1
# creating packages array with user input
read -a packages -p "What packages do you want to install?"

# variable $ID comes from the os information import
# check for linux distro
if [[ ${#packages[@]} ]]; then
    if [[ $ID == "fedora" ]]; then
        # loop through array
        for package in ${packages[@]}; do
            sudo dnf install $package
        done
    elif [[ $ID == "arch" ]]; then
        for package in ${packages[@]}; do
            sudo pacman -S $package
        done
    else 
        for package in ${packages[@]}; do
            sudo apt install $package
        done
    fi
fi
echo "Do you have git installed? (y/n)"

read git_installed

if [[ $git_installed == "n" ]]; then
    if [[ $ID == "fedora" ]]; then
        sudo dnf install git
    elif [[ $ID == "arch" ]]; then
        sudo pacman -S git
    else 
        sudo apt install git
    fi
fi
sleep 1

echo "Ready to add ssh-key? (y/n)"
read sshready

if [[ $sshready == "y" ]]; then
    echo "Do not change de default file location and name in the following!!!"
    read -p "what is your email account?" email
    ssh-keygen -t ed25519 -C $email
    ssh-add ~/.ssh/id_ed25519
    echo "Paste the following content in your ssh-key section in Github"
    echo $(cat ~/.ssh/id_ed25519.pub)
fi



echo "Do you want to install oh-my-zsh? (y/n)"
read ohmyzsh

if [[ $ohmyzsh == "y" ]]; then 
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

sleep 1

echo "Do you want to install zsh-plugins (y/n)"
read zshplugins

if [[ $zshplugins == "y" ]]; then
    mkdir ~/zsh-plugins
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/zsh-plugins 
    echo "source ~/zsh-plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
    git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/zsh-plugins
    echo "source ~/zsh-plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc
fi

sleep 1

echo "Do you want to spice up nano? (y/n)"
read spiceup

if [[ $spiceup == "y" ]]; then
    cd ~
    rm ~/.nanorc
    touch .nanorc
    echo "set atblanks" >> ~/.nanorc       
    echo "set cutfromcursor" >> ~/.nanorc   
    echo "set nohelp" >> ~/.nanorc 
    echo "set softwrap" >> ~/.nanorc
    echo "set tabsize 4" >> ~/.nanorc 
    echo "set tabstospaces" >> ~/.nanorc
    echo 'include "/usr/share/nano/*.nanorc"' >> ~/.nanorc 
    echo "set constantshow" >> ~/.nanorc
    echo "set linenumbers" >> ~/.nanorc
    echo "set casesensitive" >> ~/.nanorc
    echo "set historylog" >> ~/.nanorc
    echo "set positionlog" >> ~/.nanorc     
    echo "set zap" >> ~/.nanorc
    echo "set autoindent" >> ~/.nanorc   
    echo "set indicator" >> ~/.nanorc      
    echo "set minibar" >> ~/.nanorc
    echo "bind ^C copy main" >> ~/.nanorc
    echo "bind ^V paste all" >> ~/.nanorc
    echo "bind ^F whereis all" >> ~/.nanorc
    echo "bind ^S savefile main" >> ~/.nanorc
fi

echo "Thank you for using my script!"
sleep 1
