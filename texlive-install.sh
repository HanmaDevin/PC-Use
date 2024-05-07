#! /bin/bash

echo "This script will help you install texlive"
sleep 1
echo "Where do you want to download it? Enter a Directory"
read dir

mkdir $dir
cd $dir

wget https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
zcat < install-tl-unx.tar.gz | tar xf -
cd install-tl-*
sudo perl ./install-tl --no-interaction

terminal=$(echo $SHELL)

if [[ $terminal == "/usr/bin/bash" ]]; then
    echo "PATH=/usr/local/texlive/2024/bin/x86_64-linux:$PATH; export PATH" >> ~/.bashrc
    echo "MANPATH=/usr/local/texlive/2024/texmf-dist/doc/man:$MANPATH; export MANPATH" >> ~/.bashrc
    echo "INFOPATH=/usr/local/texlive/2024/texmf-dist/doc/info:$INFOPATH; export INFOPATH" >> ~/.bashrc

elif [[ $terminal == "/usr/bin/zsh" ]]; then
    echo "PATH=/usr/local/texlive/2024/bin/x86_64-linux:$PATH; export PATH" >> ~/.zshrc
    echo "MANPATH=/usr/local/texlive/2024/texmf-dist/doc/man:$MANPATH; export MANPATH" >> ~/.zshrc
    echo "INFOPATH=/usr/local/texlive/2024/texmf-dist/doc/info:$INFOPATH; export INFOPATH" >> ~/.zshrc
fi