#!/usr/bin/env bash

# Install dependencies first
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if [ -f "/etc/arch-release" ]; then
        sudo pacman --noconfirm -S git cmake gcc ctags
        sudo pacman --noconfirm -S go npm nodejs 
        sudo pacman --noconfirm -S python-pip python-wheel python2-setuptools python2-pip python2-wheel python2-setuptools
    else
        sudo apt-get -y install vim-nox
        sudo apt-get install -y git build-essential
        sudo apt-get install -y python-dev python-setuptools python-pip python-wheel 
        sudo apt-get install -y python3-dev python3-setuptools python3-pip python3-wheel 
        sudo apt-get install -y nodejs npm 
        sudo ln -s `which nodejs` /usr/bin/node
        sudo apt-get install -y cmake
        sudo apt-get install -y exuberant-ctags
        sudo apt-get install -y golang
    fi

    sudo pip3 install autopep8
    sudo pip3 install jedi
    sudo pip3 install jsbeautifier
    sudo pip3 install flake8
    sudo npm install -g typescript
    sudo npm install -g git+https://github.com/Perlence/tstags.git
    sudo npm install -g eslint babel-eslint eslint-plugin-react csslint htmlhint tslint
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
cp setup/eslintrc.txt ~/.eslintrc

# setup vim plugin manager
vim +PlugInstall +qall

# copy the default lightline (bottom panel) theme 
cp setup/powerline_peabody.vim ~/.vim/plugged/lightline.vim/autoload/lightline/colorscheme/.

# setup jsBeautify Plugin
cd ~/.vim/plugged/vim-jsbeautify && git submodule update --init --recursive

# install Go Binaries (if not yet)
vim +GoInstallBinaries +qall

# setup autocomplete plugin
cd ~/.vim/plugged/YouCompleteMe

./install.py --java-completer --clang-completer --go-completer

# everything is done
echo 'Your vim setup is finished. Happy hacking!'
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo 'Please restart your terminal'
fi
