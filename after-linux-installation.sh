#! /bin/bash

# import os information location
source /etc/os-release

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
	echo "source ~/zsh-plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" >>~/.zshrc
	echo "source ~/zsh-plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >>~/.zshrc
fi

read -p "Do you want to spice up nano? (y/n)" nano

if [[ $nano == "y" ]]; then
	cd ~
	if [[ -f "~/.nanorc" ]]; then
		rm ~/.nanorc
	fi

	curl -O https://raw.githubusercontent.com/HanmaDevin/Linux/main/.nanorc

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
		curl -O https://raw.githubusercontent.com/HanmaDevin/Linux/main/.vimrc

	fi
fi

read -p "Do you want to install Vencord? (y/n)" vencord

if [[ $vencord == "y" ]]; then
	sh -c "$(curl -sS https://raw.githubusercontent.com/Vendicated/VencordInstaller/main/install.sh)"
fi
