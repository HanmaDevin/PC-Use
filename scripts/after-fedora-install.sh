#!/bin/bash

packages=("zip" "unzip" "wget" "curl" "ulauncher" "neovim" "lazygit" "eza" "texlive-scheme-basic" "btop" "gamemode" "mangohud" "zoxide" "fzf" "bat")

for package in "${packages[@]}"; do
  sudo dnf install -y "$package"
done

read -p "Want to configure git? (y/n)" gitconfig

if [[ $gitconfig == "y" ]]; then
  read -p "What is your Github username?" username
  git config --global user.name "$username"
  read -p "What is your email?" useremail
  git config --global user.email "$useremail"
fi

read -p "Ready to add ssh-key? (y/n)" sshready

if [[ $sshready == "y" ]]; then
  echo "Do not change de default file location and name in the following!!!"
  read -p "what is your email account?" email
  ssh-keygen -t ed25519 -C $email
  ssh-add ~/.ssh/id_ed25519
  echo "Paste the following content in your ssh-key section in Github"
  echo $(cat ~/.ssh/id_ed25519.pub)
fi

if [[ ! -d "$HOME/.config/neofetch/" ]]; then
  mkdir -p "$HOME/.config/neofetch/"
fi

# adding all configs
# Adding neofetch theme to maschine
echo "Adding neofetch config"
sleep 2

cp "$HOME/Linux/Neofetch-Theme/config.conf" "$HOME/.config/neofetch/config.conf"

echo "Finished!"
sleep 2

echo "Adding btop config"
sleep 2

mkdir -p "$HOME/.config/btop/"
cp "$HOME/Linux/btop/btop.conf" "$HOME/.config/btop/"

echo "Finished!"
sleep 2

# adding neovim plugin
echo "Adding neovim plugin"
sleep 2

mkdir -p "$HOME/.config/nvim/lua/plugins/"
cp "$HOME/Linux/neovim/lazygit.lua" "$HOME/.config/nvim/lua/plugins/"

echo "Finished!"
sleep 2

echo "adding zshrc"
sleep 2

cp "$HOME/Linux/zsh/fedorazsh" "$HOME/.zshrc"

echo "Finished!"
sleep 2

echo "Adding wallpaper"
sleep 2

mkdir -p ~/Pictures/wallpaper
cp -a "$HOME/Linux/wallpaper/." "$HOME/Pictures/wallpaper/"

echo "Finished!"
sleep 2

echo "Adding font and cursor"
sleep 2

sudo cp "$HOME/Linux/Fonts/MesloLGS NF Regular.ttf" "/usr/share/fonts/"
sudo cp -r "$HOME/Linux/Cursor/Bibata-Modern-Ice/" "/usr/share/icons/"

echo "installing discord and steam"
sleep 2

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak install discord
sudo flatpak install steam

echo "Running scripts"

python3 <(curl https://raw.githubusercontent.com/catppuccin/ulauncher/main/install.py -fsSL) -f all -a all

bash "$HOME/Linux/scripts/neovim.sh"
