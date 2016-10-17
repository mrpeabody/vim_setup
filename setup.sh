#!/usr/bin/env bash

# Install dependencies first
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    # Linux x86-64 (Ubuntu)
    sudo apt-get install -y vim python-dev python3-dev
    sudo apt-get install -y build-essential cmake python-pip
    sudo apt-get install -y exuberant-ctags
    sudo pip install autopep8
    sudo pip install jsbeautifier
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # Mac OSX
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew install vim --without-python --with-python3 --with-override-system-vim
    brew install cmake
    brew install ctags
    pip install autopep8
    pip install jsbeautifier
fi

# copy required files
cp setup/vimrc.txt ~/.vimrc
rm -rf ~/.vim
cp -r setup/dot_vim ~/.vim
cp setup/dot_tern_config ~/.tern-config
cp setup/ycm_extra_conf.py ~/.ycm_extra_conf.py

# setup vim plugin manager
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

# setup jsBeautify Plugin
cd ~/.vim/bundle/vim-jsbeautify && git submodule update --init --recursive

# setup autocomplete plugin
cd ~/.vim/bundle/YouCompleteMe
if [[ $1 ]]; then
    ./install.py --tern-completer $1
else
    ./install.py --tern-completer
fi

cd ~/.vim/bundle/tern_for_vim
npm install

# everything is done
echo 'Your vim setup is finished. Happy hacking!'
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo 'Please restart your terminal'
fi
