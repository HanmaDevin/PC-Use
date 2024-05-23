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

echo "Creating neovim configuration folder and fetching my init.lua file"
sleep 1

mkdir -p ~/.config/nvim
cd ~/.config/nvim
curl -O https://raw.githubusercontent.com/HanmaDevin/bashscripts/main/init.lua

echo "Creating seperate directory to store plugins"
sleep 1

mkdir -p lua/plugins
cd lua/plugins

echo "Getting all my plugins"
sleep 1

curl -O https://raw.githubusercontent.com/HanmaDevin/bashscripts/main/neovim_plugins/catppuccin.lua
curl -O https://raw.githubusercontent.com/HanmaDevin/bashscripts/main/neovim_plugins/neotree.lua
curl -O https://raw.githubusercontent.com/HanmaDevin/bashscripts/main/neovim_plugins/telescope.lua
curl -O https://raw.githubusercontent.com/HanmaDevin/bashscripts/main/neovim_plugins/treesitter.lua
curl -O https://raw.githubusercontent.com/HanmaDevin/bashscripts/main/neovim_plugins/lualine.lua
curl -O https://raw.githubusercontent.com/HanmaDevin/bashscripts/main/neovim_plugins/lsp-config.lua
curl -O https://raw.githubusercontent.com/HanmaDevin/bashscripts/main/neovim_plugins/completions.lua
curl -O https://raw.githubusercontent.com/HanmaDevin/bashscripts/main/neovim_plugins/none-ls.lua
curl -O https://raw.githubusercontent.com/HanmaDevin/bashscripts/main/neovim_plugins/alpha.lua

