#! /bin/bash

source /etc/os-release

echo "Welcome to my neovim configuration script"

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

cd ~/.config/
mkdir nvim

echo "Cloning into LazyVim"
sleep 1

git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git

cd ~/.config/nvim/lua/plugins/
curl -O https://raw.githubusercontent.com/HanmaDevin/NeoVim/main/neogit.lua
