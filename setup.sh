#!/usr/bin/env bash

# Install dependencies first
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    # Linux x86-64 (Ubuntu)
    sudo apt-get install build-essential cmake
    sudo apt-get install python-dev python3-dev
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # Mac OSX
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew install macvim --with-override-system-vim
    brew install cmake
fi

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
