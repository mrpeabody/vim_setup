#!/usr/bin/env bash

# Install dependencies first
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if [ -f "/etc/arch-release" ]; then
        sudo pacman --noconfirm -S vim git cmake gcc ctags curl
        sudo pacman --noconfirm -S go npm nodejs 
        sudo pacman --noconfirm -S python-pip python-wheel python2-setuptools python2-pip python2-wheel python2-setuptools
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
    npm install -g typescript
    npm install -g instant-markdown-d
    npm install -g csslint htmlhint standard ts-standard
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # Mac OSX
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew install vim --with-override-system-vi
    brew install cmake
    brew install python
    brew install python3
    brew install node
    brew install ctags
    brew install go
    pip3 install autopep8
    pip3 install jedi
    pip3 install jsbeautifier
    pip3 install flake8
    npm install -g typescript
    npm install -g instant-markdown-d
    npm install -g git+https://github.com/Perlence/tstags.git
    npm install -g eslint babel-eslint eslint-plugin-react
    npm install -g csslint
    npm install -g htmlhint
    npm install -g tslint
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
