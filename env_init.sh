#!/bin/bash
set -x
set -o
[ -f ~/.vimrc ] || (echo "Creating vimrc link" && ln -s ~/.vim/vimrc ~/.vimrc)

# Setup:
# Mac OSX ~/.bash_profile -sources-> ~/.bashrc -sources-> ~/.bash_profile_sid because Mac has a bash_profile that gets sourced every time a terminal is opened
# Linux  ~/.bashrc -sources-> ~/.bash_profile_sid . These have only bashrc, simpler to understand

if [ -f ~/.bash_profile_sid ]; then
    echo "You have the bash_profile_sid!"
else
    ln -s ~/.vim/bash_profile_sid ~/.bash_profile
fi

if [ -f ~/.bash_profile ]; then
    echo "You are likely on a mac check if ~/bash_profile sources ~/.bashrc for environment to work properly"
else
    echo "You are likely on a non osx machine(i.e. linux) check if ~/.bashrc sources ~/.bash_profile_sid "
fi

if [ -f ~/.bashrc ]; then
    echo "~/.bashrc exists ensure it sources your ~/.bash_profile_sid"
else
    echo "Creating a symlink to ~/.vim/.bashrc as none exists on the system" # ~/.vim/.bashrc is set up to source ~/bash_profile_sid.
    # ln -s ~/.vim/bashrc ~/.bashrc
fi


if [ -f ~/.tmux.conf ]; then
    echo "You have the tmux config. Linking it!"
else
    ln -s ~/.vim/.tmux.conf ~/.tmux.conf
fi

if [ -f ~/.gitconfig ]; then
    echo "You have the git config. Linking it!"
else
    ln -s ~/.vim/.gitconfig ~/.gitconfig
fi
