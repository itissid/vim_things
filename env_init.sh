#!/bin/bash
set -x
set -o
[ -d ~/.vim ] || (mkdir ~/.vim)
[ -f ~/.vimrc ] || (echo "Creating vimrc link" && ln -s ~/.vim/vimrc ~/.vimrc)

# Setup:
# Mac OSX ~/.bash_profile -sources-> ~/.bashrc -sources-> ~/.bash_profile_sid because Mac has a bash_profile that gets sourced every time a terminal is opened
# Linux  ~/.bashrc -sources-> ~/.bash_profile_sid . These have only bashrc, simpler to understand

if [ -f ~/.bash_profile_sid ]; then
    echo "You have the bash_profile_sid!"
else
    ln -s ~/.vim/.bash_profile_sid ~/.bash_profile
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
    ln -s ~/.vim/.bashrc ~/.bashrc
fi


if [ -f ~/.tmux.conf ]; then
    echo "You have the tmux config. Not changing anything."
else
    ln -s ~/.vim/.tmux.conf ~/.tmux.conf
fi

if [ -f ~/.gitconfig ]; then
    echo "You have the git config in the project. Leaving it alone"
else
    ln -s ~/.vim/.gitconfig ~/.gitconfig
fi

if [ -f ~/.iterm2_shell_integration ]; then
    echo "You have a iterm integration, leaving it alone"
else
    ln -s ~/.vim/.iterm2_shell_integration ~/.iterm2_shell_integration
fi

# https://github.com/rcaloras/bash-preexec
if [ -f ~/.bash-preexec.sh ]; then
    echo "You have the the bash preexec config. Not changing anything."
else
    ln -s ~/.vim/.bash-preexec.sh ~/.bash-preexec.sh
fi

if [ -f ~/.zshrc ]; then
    echo "You have the the zshrc . Not changing anything."
else
    ln -s ~/.vim/.zshrc ~/.zshrc
fi

if [ -f ~/.zshenv ]; then
    echo "You have the the zshenv. Not changing anything."
else
    ln -s ~/.vim/.zshenv ~/.zshenv
fi
