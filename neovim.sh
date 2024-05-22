#! /bin/bash

source /etc/os-release

read -p "Want to install neovim? (y/n)" neovim


if [[ $neovim == "y" ]]; then
    if [[ $ID == "fedora" ]]; then
        sudo dnf install neovim
    elif [[ $ID == "arch" ]]; then
        sudo pacman -S neovim
    else 
        sudo apt install neovim
    fi
fi

echo "Creating neovim configuration folder and fetching my init.lua file"

mkdir -p ~/.config/nvim
cd ~/.config/nvim
curl https://raw.githubusercontent.com/HanmaDevin/bashscripts/main/init.lua

echo "Creating seperate directory to store plugins"

mkdir lua
cd lua
curl https://raw.githubusercontent.com/HanmaDevin/bashscripts/main/plugins.lua
