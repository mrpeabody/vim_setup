#!/usr/bin/env bash

# Install dependencies first
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if [ -f "/etc/arch-release" ]; then
        sudo pacman --noconfirm -S vim git cmake gcc ctags curl base-devel
        sudo pacman --noconfirm -S python-pip python-wheel python-setuptools
    elif [ -f "/etc/redhat-release" ]; then
	sudo dnf -y group install "Development Tools"
	sudo dnf -y install g++ curl vim-enhanced git cmake
	sudo dnf -y install python3-pip python3-devel python3-setuptools python3-wheel
    else
        sudo apt -y install vim-nox git build-essential build-essential cmake
        sudo apt install -y python-is-python3 python-dev-is-python3 python-setuptools python3-pip python3-wheel
        sudo apt install -y curl
    fi

    pip install autopep8 --user
    pip install flake8 --user

    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # Mac OSX

    # only install brew if it's not installed already
    if [[ $(command -v brew) == "" ]]; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi

    brew install git
    brew install vim
    brew install cmake
    brew install python3
    brew install ctags
    pip3 install autopep8
    pip3 install flake8

    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | zsh
fi

export NVM_DIR=$HOME/.nvm
source $NVM_DIR/nvm.sh
nvm install --lts

npm install -g typescript
npm install -g instant-markdown-d
npm install -g csslint htmlhint standard ts-standard@10.0.0

# copy required files
cp setup/vimrc.txt ~/.vimrc
if [[ "$*" == *"--with-go"*  ]]; then
    if [[ "$OSTYPE" == "darwin"* ]]; then
        sed -i '' "s/\" Plug 'fatih\/vim-go'/Plug 'fatih\/vim-go'/g" ~/.vimrc
    else
        sed -i "s/\" Plug 'fatih\/vim-go'/Plug 'fatih\/vim-go'/g" ~/.vimrc
    fi
fi

cp setup/gvimrc.txt ~/.gvimrc

if [ -d "$HOME/.vim" ]; then
    echo 'Cleaning up the old .vim directory...'
    chmod -R 0755 ~/.vim
    rm -rf ~/.vim
fi
cp -r setup/dot_vim ~/.vim
cp setup/csslintrc.txt ~/.csslintrc

# setup vim plugin manager
vim +"colorscheme OceanicNext2" +PlugInstall +qall

# setup autocomplete plugin
cd ~/.vim/plugged/YouCompleteMe

INSTALL_ARGS="--clangd-completer --ts-completer"

if [[ "$*" == *"--with-java"*  ]]; then
    INSTALL_ARGS+=" --java-completer"
fi

if [[ "$*" == *"--with-go"*  ]]; then
    INSTALL_ARGS+=" --go-completer"
fi

if [[ "$*" == *"--with-csharp"*  ]]; then
    INSTALL_ARGS+=" --cs-completer"
fi

./install.py $INSTALL_ARGS

# everything is done
echo 'Your vim setup is finished. Happy hacking!'
echo 'Please restart your terminal'
