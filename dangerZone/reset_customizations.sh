#!/bin/bash

echo "Resetting Vim configuration..."
if [ -f ~/.vimrc ]; then
    rm ~/.vimrc
fi
if [ -d ~/.vim ]; then
    rm -rf ~/.vim
fi
cp /etc/skel/.vimrc ~/
cp -r /etc/skel/.vim ~/

echo "Resetting tmux configuration..."
if [ -f ~/.tmux.conf ]; then
    rm ~/.tmux.conf
fi
if [ -d ~/.tmux ]; then
    rm -rf ~/.tmux
fi
cp /etc/skel/.tmux.conf ~/

echo "Resetting Fish shell configuration..."
if [ -d ~/.config/fish ]; then
    rm -rf ~/.config/fish
fi
cp -r /etc/skel/.config/fish ~/.config/

echo "Resetting other common configurations..."
# Add other configurations you might have customized
if [ -f ~/.bashrc ]; then
    rm ~/.bashrc
    cp /etc/skel/.bashrc ~/
fi

if [ -f ~/.profile ]; then
    rm ~/.profile
    cp /etc/skel/.profile ~/
fi

if [ -f ~/.zshrc ]; then
    rm ~/.zshrc
    cp /etc/skel/.zshrc ~/
fi

echo "Resetting complete. Please restart your terminal or log out and log back in for changes to take effect."
