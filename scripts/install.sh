#!/bin/bash

echo "What package manager do you use?"
echo "(1) apt"
echo "(2) dnf"
echo "(3) pacman"

read answer

case $answer in
    1)
        packages=("zip" "unzip" "wget" "curl" "neovim" "lazygit" "eza" \
        "btop" "gamemode" "mangohud" "zoxide" "fzf" "bat")

        for package in "${packages[@]}"; do
        sudo apt install -y "$package"
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

        # adding all configs
        # Adding neofetch theme to maschine
        echo "Adding neofetch config"
        sleep 2

        if [[ ! -d "$HOME/.config/neofetch/" ]]; then
        mkdir -p "$HOME/.config/neofetch/"
        fi

        cp "$HOME/Linux/Neofetch-Theme/config.conf" "$HOME/.config/neofetch/config.conf"

        echo "Finished!"
        sleep 2

        echo "Adding btop config"
        sleep 2

        if [[ ! -d "$HOME/.config/btop/" ]]; then
            mkdir -p "$HOME/.config/btop/"
        fi
        cp "$HOME/Linux/btop/btop.conf" "$HOME/.config/btop/"

        echo "Finished!"
        sleep 2

        # adding neovim plugin
        echo "Adding neovim plugin"
        sleep 2

        if [[ ! -d "$HOME/.config/nvim/lua/plugins/" ]]; then
            mkdir -p "$HOME/.config/nvim/lua/plugins/"
        fi

        cp "$HOME/Linux/neovim/lazygit.lua" "$HOME/.config/nvim/lua/plugins/"

        echo "Finished!"
        sleep 2

        echo "adding zshrc"
        sleep 2

        cp "$HOME/Linux/zsh/debianzsh" "$HOME/.zshrc"

        echo "Finished!"
        sleep 2

        echo "Adding wallpaper"
        sleep 2

        if [[ ! -d "$HOME/Pictures/wallpaper" ]]; then
            mkdir -p "$HOME/Pictures/wallpaper"
        fi

        cp -a "$HOME/Linux/wallpaper/." "$HOME/Pictures/wallpaper/"

        echo "Finished!"
        sleep 2

        echo "Adding font and cursor"
        sleep 2

        sudo cp "$HOME/Linux/Fonts/MesloLGS NF Regular.ttf" "/usr/share/fonts/"
        sudo cp -r "$HOME/Linux/Cursor/Bibata-Modern-Ice/" "/usr/share/icons/"

        echo "Finished!"
        sleep 2

        echo "Runnung neovim script"

        bash  "$HOME/Linux/scripts/neovim.sh"
        ;;

    2)
        packages=("zip" "unzip" "wget" "curl" "neovim" "lazygit" "eza" \
        "btop" "gamemode" "mangohud" "zoxide" "fzf" "bat")

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

        # adding all configs
        # Adding neofetch theme to maschine
        echo "Adding neofetch config"
        sleep 2

        if [[ ! -d "$HOME/.config/neofetch/" ]]; then
        mkdir -p "$HOME/.config/neofetch/"
        fi

        cp "$HOME/Linux/Neofetch-Theme/config.conf" "$HOME/.config/neofetch/config.conf"

        echo "Finished!"
        sleep 2

        echo "Adding btop config"
        sleep 2

        if [[ ! -d "$HOME/.config/btop/" ]]; then
            mkdir -p "$HOME/.config/btop/"
        fi
        cp "$HOME/Linux/btop/btop.conf" "$HOME/.config/btop/"

        echo "Finished!"
        sleep 2

        # adding neovim plugin
        echo "Adding neovim plugin"
        sleep 2

        if [[ ! -d "$HOME/.config/nvim/lua/plugins/" ]]; then
            mkdir -p "$HOME/.config/nvim/lua/plugins/"
        fi

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

        if [[ ! -d "$HOME/Pictures/wallpaper" ]]; then
            mkdir -p "$HOME/Pictures/wallpaper"
        fi

        cp -a "$HOME/Linux/wallpaper/." "$HOME/Pictures/wallpaper/"

        echo "Finished!"
        sleep 2

        echo "Adding font and cursor"
        sleep 2

        sudo cp "$HOME/Linux/Fonts/MesloLGS NF Regular.ttf" "/usr/share/fonts/"
        sudo cp -r "$HOME/Linux/Cursor/Bibata-Modern-Ice/" "/usr/share/icons/"

        echo "Finished!"
        sleep 2

        echo "Runnung neovim script"

        bash  "$HOME/Linux/scripts/neovim.sh"
        ;;

    3)
        packages=("zip" "unzip" "wget" "curl" "neovim" "lazygit" "eza" \
        "btop" "gamemode" "mangohud" "zoxide" "fzf" "bat")

        for package in "${packages[@]}"; do
        sudo pacman -S --noconfirm "$package"
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

        # adding all configs
        # Adding neofetch theme to maschine
        echo "Adding neofetch config"
        sleep 2

        if [[ ! -d "$HOME/.config/neofetch/" ]]; then
        mkdir -p "$HOME/.config/neofetch/"
        fi

        cp "$HOME/Linux/Neofetch-Theme/config.conf" "$HOME/.config/neofetch/config.conf"

        echo "Finished!"
        sleep 2

        echo "Adding btop config"
        sleep 2

        if [[ ! -d "$HOME/.config/btop/" ]]; then
            mkdir -p "$HOME/.config/btop/"
        fi
        cp "$HOME/Linux/btop/btop.conf" "$HOME/.config/btop/"

        echo "Finished!"
        sleep 2

        # adding neovim plugin
        echo "Adding neovim plugin"
        sleep 2

        if [[ ! -d "$HOME/.config/nvim/lua/plugins/" ]]; then
            mkdir -p "$HOME/.config/nvim/lua/plugins/"
        fi

        cp "$HOME/Linux/neovim/lazygit.lua" "$HOME/.config/nvim/lua/plugins/"

        echo "Finished!"
        sleep 2

        echo "adding zshrc"
        sleep 2

        cp "$HOME/Linux/zsh/archzsh" "$HOME/.zshrc"

        echo "Finished!"
        sleep 2

        echo "Adding wallpaper"
        sleep 2

        if [[ ! -d "$HOME/Pictures/wallpaper" ]]; then
            mkdir -p "$HOME/Pictures/wallpaper"
        fi

        cp -a "$HOME/Linux/wallpaper/." "$HOME/Pictures/wallpaper/"

        echo "Finished!"
        sleep 2

        echo "Adding font and cursor"
        sleep 2

        sudo cp "$HOME/Linux/Fonts/MesloLGS NF Regular.ttf" "/usr/share/fonts/"
        sudo cp -r "$HOME/Linux/Cursor/Bibata-Modern-Ice/" "/usr/share/icons/"

        echo "Finished!"
        sleep 2

        echo "Runnung neovim script"

        bash  "$HOME/Linux/scripts/neovim.sh"
        ;;

    *)
        echo "Do not know what to do, Bye!!"
        exit 223
        ;;
esac
