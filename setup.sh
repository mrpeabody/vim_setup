#!/usr/bin/env bash

# Install dependencies first
brew install macvim --with-override-system-vim
brew install cmake

# copy required files
cp setup/vimrc.txt ~/.vimrc
rm -rf ~/.vim
cp -r setup/dot_vim ~/.vim
cp setup/dot_tern_config ~/.tern_config
cp setup/ycm_extra_conf.py ~/.ycm_extra_conf.py

# setup vim plugin manager
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

# setup autocomplete plugin
cd ~/.vim/bundle/YouCompleteMe
./install.py --clang-completer --tern-completer

# everything is done
echo 'Your vim setup is finished. Happy hacking!'
