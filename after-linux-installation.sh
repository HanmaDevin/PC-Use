#! /bin/bash

# import os information location 
source /etc/os-release

echo "Welcome to my after linux gnome installation configurator script"

# creating packages array with user input
read -a packages -p "What packages do you want to install? (Press Enter for no installation)"

# variable $ID comes from the os information import
# check if array is not empty
if [[ ${#packages[@]} ]]; then
    # check for linux distro
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
read -p "Do you have git installed? (y/n)" git_installed

if [[ $git_installed == "n" ]]; then
    if [[ $ID == "fedora" ]]; then
        sudo dnf install git
    elif [[ $ID == "arch" ]]; then
        sudo pacman -S git
    else 
        sudo apt install git
    fi
fi

read -p "Want to configure git? (y/n)" gitconfig

if [[ $gitconfig == "y" ]]; then
    read -p "What is your Github username?" username
    git config --global user.name "$username"
    read -p "What is your email?" useremail
    git config --global user.email "$usermail"
fi

read -p "Ready to add ssh-key? (y/n)" sshready

if [[ $sshready == "y" ]]; then
    echo "Do not change de default file location and name in the following!!!"
    read -p "what is your email account?" email
    read -p "What is your user name?" user
    ssh-keygen -t ed25519 -C $email
    ssh-add ~/.ssh/id_ed25519
    echo "Paste the following content in your ssh-key section in Github"
    echo $(cat ~/.ssh/id_ed25519.pub)
fi

read -p "Do you want to install oh-my-zsh? (y/n)" ohmyzsh

if [[ $ohmyzsh == "y" ]]; then 
    if [[ $ID == "fedora" ]]; then
        sudo dnf install zsh
    elif [[ $ID == "arch" ]]; then
        sudo pacman -S zsh
    else 
        sudo apt install zsh
    fi
fi

read -p "Do you want to install zsh-plugins (y/n)" zshplugins

if [[ $zshplugins == "y" ]]; then
    if [[ -d "~/zsh-plugins" ]]; then
        rm -r ~/zsh-plugins
    fi
        cd ~
        mkdir zsh-plugins
        cd zsh-plugins
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
        sleep 1
        git clone https://github.com/zsh-users/zsh-autosuggestions.git
        sleep 1
        echo "source ~/zsh-plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc
        echo "source ~/zsh-plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
fi

read -p "Do you want to spice up nano? (y/n)" nano

if [[ $nano == "y" ]]; then
    cd ~
    if [[ -f "~/.nanorc" ]]; then 
        rm ~/.nanorc
    fi
    touch .nanorc
    echo "set atblanks" >> ~/.nanorc       
    echo "set cutfromcursor" >> ~/.nanorc   
    echo "set nohelp" >> ~/.nanorc 
    echo "set softwrap" >> ~/.nanorc
    echo "set tabsize 4" >> ~/.nanorc 
    echo "set tabstospaces" >> ~/.nanorc
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

    cd ~
    mkdir .nano
    cd .nano
    git clone https://github.com/scopatz/nanorc.git
    rm ~/.nano/nanorc/nanorc.nanorc
    echo 'include "~/.nano/nanorc/*.nanorc"' >> ~/.nanorc
fi

read -p "Do you have vim installed? (y/n)" vim_installed

if [[ $vim_installed == "n" ]]; then
    
    if [[ $ID == "fedora" ]]; then
        sudo dnf install vim
    elif [[ $ID == "arch" ]]; then
        sudo pacman -S vim
    else 
        sudo apt install vim
    fi

    read -p "Do you want to spice up vim? (y/n)" vim

    if [[ $vim == "y" ]]; then
        cd ~
        mkdir -p ~/.vim/autoload
        touch ~/.vimrc

        echo -e '" Enable compatibility with vi which can cause unexpected issues\n set nocompatible' >> ~/.vimrc
        echo -e '" Enable file type detection\n filetype on' >> ~/.vimrc
        echo -e '" Enable plugins for file type\n filetype plugin on' >> ~/.vimrc
        echo -e '" File type indentation\n filetype indent on' >> ~/.vimrc
        echo -e '" Add line numbers\n set number' >> ~/.vimrc
        echo -e '" Set tab width to 4\n set tabstop=4' >> ~/.vimrc
        echo -e '" Ignore capital letters with search\n set ignorecase' >> ~/.vimrc
        echo -e '" Enable autocompletion\n set wildmenu' >> ~/.vimrc
        echo -e '" Highlight search\n set hlsearch' >> ~/.vimrc
        echo -e '" Allows to still search in upper case\n set smartcase' >> ~/.vimrc
        echo -e '" Show current mode on last line\n set showmode' >> ~/.vimrc	

    fi
fi

read -p "Do you want to install Vencord? (y/n)" vencord

if [[ $vencord == "y" ]]; then
    sh -c "$(curl -sS https://raw.githubusercontent.com/Vendicated/VencordInstaller/main/install.sh)"
fi

echo "Now installing my favorite fonts"
sleep 1

curl -O https://github.com/HanmaDevin/Linux/blob/main/Fonts/Poppins.zip
unzip Poppins.zip
rm Poppins.zip

sudo mv Poppins* /usr/share/fonts

curl -O https://github.com/HanmaDevin/Linux/blob/main/Fonts/Recursive.zip
unzip Recursive.zip
rm Recursive.zip

sudo mv Recursive* /usr/share/fonts

echo "installing favorite cursor"
sleep 1

curl -O https://github.com/HanmaDevin/Linux/blob/main/Cursor/Bibata-Modern-Ice.tar.xz
tar -xf Bibata-Modern-Ice.tar.xz
rm Bibata-Modern-Ice.tar.xf

sudo mv Bibata* /usr/share/icons

echo "Getting ulauncher themes"

curl -O https://github.com/HanmaDevin/Linux/blob/main/Ulauncher-Themes/Everforest_Dark.zip
curl -O https://github.com/HanmaDevin/Linux/blob/main/Ulauncher-Themes/Everforest_Light.zip
curl -O https://github.com/HanmaDevin/Linux/blob/main/Ulauncher-Themes/Gruvbox_Dark.zip
curl -O https://github.com/HanmaDevin/Linux/blob/main/Ulauncher-Themes/Gruvbox_Light.zip
curl -O https://github.com/HanmaDevin/Linux/blob/main/Ulauncher-Themes/Tokyonight_Dark.zip
curl -O https://github.com/HanmaDevin/Linux/blob/main/Ulauncher-Themes/Tokyonight_Light.zip

unzip *.zip
rm *.zip

if [ -d ~/.config/ulauncher ]; then
  mkdir user-themes
  sudo mv * ~/.config/ulauncher/user-themes
fi

sleep 1

echo "Thank you for using my script!"
sleep 1
