#!/usr/bin/env bash

# Install dependencies first
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if [ -f "/etc/arch-release" ]; then
        sudo pacman --noconfirm -S vim git cmake gcc ctags curl
        sudo pacman --noconfirm -S go npm nodejs 
        sudo pacman --noconfirm -S python-pip python-wheel python2-setuptools python2-pip python2-wheel python2-setuptools
    elif [ -f "/etc/fedora-release" ]; then
	sudo dnf -y group install "C Development Tools and Libraries" "Development Tools"
	sudo dnf -y install g++ curl vim-enhanced git cmake java-latest-openjdk java-latest-openjdk-devel
	sudo dnf -y install python3-pip python3-devel python3-setuptools python3-wheel
    else
        sudo apt -y install vim-nox git build-essential build-essential cmake default-jdk
        sudo apt install -y python-is-python3 python-dev-is-python3 python-setuptools python3-pip python3-wheel
        sudo apt install -y curl
    fi

    pip install autopep8 --user
    pip install jedi --user
    pip install jsbeautifier --user
    pip install flake8 --user

    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
    export NVM_DIR=$HOME/.nvm
    source $NVM_DIR/nvm.sh
    nvm install --lts
    npm install -g typescript
    npm install -g instant-markdown-d
    npm install -g csslint htmlhint standard ts-standard
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # Mac OSX
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    brew install git
    brew install vim
    brew install cmake
    brew install python3
    brew install ctags
    pip3 install autopep8
    pip3 install jedi
    pip3 install jsbeautifier
    pip3 install flake8

    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | zsh
    export NVM_DIR=$HOME/.nvm
    source $NVM_DIR/nvm.sh
    nvm install --lts

    npm install -g typescript
    npm install -g instant-markdown-d
    npm install -g csslint htmlhint standard ts-standard
fi

# copy required files
cp setup/vimrc.txt ~/.vimrc
cp setup/gvimrc.txt ~/.gvimrc
rm -rf ~/.vim
cp -r setup/dot_vim ~/.vim
cp setup/csslintrc.txt ~/.csslintrc

# setup vim plugin manager
vim +"colorscheme OceanicNext2" +PlugInstall +qall

# copy the default lightline (bottom panel) theme 
cp setup/powerline_peabody.vim ~/.vim/plugged/lightline.vim/autoload/lightline/colorscheme/.

# setup jsBeautify Plugin
cd ~/.vim/plugged/vim-jsbeautify && git submodule update --init --recursive

# setup autocomplete plugin
cd ~/.vim/plugged/YouCompleteMe

./install.py --java-completer --clangd-completer --ts-completer

# everything is done
echo 'Your vim setup is finished. Happy hacking!'
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo 'Please restart your terminal'
fi
