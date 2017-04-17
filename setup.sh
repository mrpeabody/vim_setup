#!/usr/bin/env bash

# Install dependencies first
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux x86-64 (Ubuntu)
    sudo apt-get install -y nodejs npm git python-pip vim vim-nox-py2 python-wheel python-setuptools build-essential python-dev
    sudo apt-get install -y cmake
    sudo apt-get install -y exuberant-ctags
    sudo pip install autopep8
    sudo pip install jedi
    sudo pip install jsbeautifier
    sudo pip install flake8
    sudo ln -s `which nodejs` /usr/bin/node
    sudo npm install -g typescript
    sudo npm install -g git+https://github.com/Perlence/tstags.git
    sudo npm install -g jshint
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # Mac OSX
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew install vim --with-override-system-vi
    brew install cmake
    brew install python
    brew install node
    brew install ctags
    pip install autopep8
    pip install jedi
    pip install jsbeautifier
    pip install flake8
    npm install -g typescript
    npm install -g git+https://github.com/Perlence/tstags.git
    npm install -g jshint
fi

# copy required files
cp setup/vimrc.txt ~/.vimrc
cp setup/gvimrc.txt ~/.gvimrc
rm -rf ~/.vim
cp -r setup/dot_vim ~/.vim
cp setup/dot_tern_config ~/.tern-config
cp setup/ycm_extra_conf.py ~/.ycm_extra_conf.py
cp setup/jshintrc.txt ~/.jshintrc

# setup vim plugin manager
vim +PlugInstall +qall

# setup jsBeautify Plugin
cd ~/.vim/plugged/vim-jsbeautify && git submodule update --init --recursive

# setup autocomplete plugin
cd ~/.vim/plugged/YouCompleteMe
if [[ $1 ]]; then
    ./install.py --tern-completer $1
else
    ./install.py --tern-completer
fi

cd ~/.vim/plugged/tern_for_vim
npm install

# everything is done
echo 'Your vim setup is finished. Happy hacking!'
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo 'Please restart your terminal'
fi
