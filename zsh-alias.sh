#! /bin/bash

FILE=~/.zshrc

if [[ -f $FILE ]]; then
    echo "# Alias" >> $FILE
    echo 'alias down="cd ~/Downloads"' >> $FILE
    echo 'alias py="/bin/python3"' >> $FILE
    echo 'alias zshconfig="nano ~/.zshrc"' >> $FILE
    echo 'alias nanoconfig="nano ~/.nanorc"' >> $FILE
    echo 'alias ls="lsd"' >> $FILE
    echo 'alias bat="batcat"' >> $FILE 
fi
