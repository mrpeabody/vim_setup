#!/usr/bin/env bash

################################################################################
# Help                                                                         #
################################################################################
Help()
{
   # Display Help
   echo "This script sets up VIM with extra plugins and settings, along with Node.js environment and basic dev tools"
   echo
   echo "Syntax: ./setup.sh [-h|--help|--with-go|--with-java|--with-csharp]"
   echo "options:"
   echo "[h | --help]     Print this Help."
   echo "--skip-install   Don't install packages, only set up VIM"
   echo "--with-go        Add optional Golang support."
   echo "--with-java      Add optional Java support."
   echo "--with-csharp    Add optional C# support."
   echo
}
################################################################################


# Detect if a user wants a help message
if [[ "$1" == "--help"  || "$1" == "-h" ]]; then
    Help
    exit;
fi


if [[ ! "$*" == *"--skip-install"*  ]]; then
    # Install dependencies first
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if [ -f "/etc/arch-release" ]; then
            sudo pacman --noconfirm -S vim git cmake gcc ctags curl base-devel
            sudo pacman --noconfirm -S python-pip python-wheel python-setuptools
            sudo pacman --noconfirm -S flake8 autopep8

            if [[ $DISPLAY ]]; then 
                echo; echo
                echo "Consider running the following command to enable system clipboard support in VIM:"
                echo "       sudo pacman -S gvim xsel"
                echo; echo
            fi
        elif [ -f "/etc/redhat-release" ]; then
            sudo dnf makecache
            sudo dnf -y group install "Development Tools"
            sudo dnf -y install g++ curl vim-enhanced git cmake
            sudo dnf -y install python3-pip python3-devel python3-setuptools python3-wheel
            sudo dnf -y install python3-flake8 python3-autopep8
            if [[ $DISPLAY ]]; then 
                echo; echo
                echo "Consider running the following command to enable system clipboard support in VIM:"
                echo "       sudo dnf -y install vim-X11 xsel"
                echo; echo
            fi

        else
            sudo apt -y update
            sudo apt -y install vim-nox git build-essential cmake
            sudo apt install -y python-is-python3 python-dev-is-python3 python3-setuptools python3-pip python3-wheel
            sudo apt -y install flake8 python3-flake8 python3-autopep8
            sudo apt -y install fonts-powerline
            sudo apt install -y curl

            if [[ $DISPLAY ]]; then 
                echo; echo
                echo "Consider running the following command to enable system clipboard support in VIM:"
                echo "       sudo apt install -y vim-gtk3 xsel"
                echo; echo
            fi
        fi

        # copy fonts to a user directory
        mkdir -p ~/.local/share/fonts
        cp -rf fonts/* ~/.local/share/fonts/.

        # only install and set up NVM if it's not installed already
        if [[ ! -d "$HOME/.nvm" ]]; then
            curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
            export NVM_DIR=$HOME/.nvm
            source $NVM_DIR/nvm.sh
            nvm install --lts
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        # Mac OSX

        # only install brew if it's not installed already
        if [[ $(command -v brew) == "" ]]; then
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
            eval "$(/opt/homebrew/bin/brew shellenv)"
        else
            brew update && brew outdated && brew upgrade
        fi

        brew list git &>/dev/null || brew install git
        brew list vim &>/dev/null || brew install vim
        brew list cmake &>/dev/null || brew install cmake
        brew list python3 &>/dev/null || brew install python3
        brew list python-setuptools &>/dev/null || brew install python-setuptools
        brew list ctags &>/dev/null || brew install ctags
        brew list autopep8 &>/dev/null || brew install autopep8
        brew list flake8 &>/dev/null || brew install flake8

        # only install and set up NVM if it's not installed already
        if [[ ! -d "$HOME/.nvm" ]]; then
            curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | zsh
            export NVM_DIR=$HOME/.nvm
            source $NVM_DIR/nvm.sh
            nvm install --lts
        fi
    fi

    # export NVM again, in case previous setup run failed but NVM got installed
    export NVM_DIR=$HOME/.nvm
    source $NVM_DIR/nvm.sh

    npm list -g typescript &>/dev/null || npm install -g typescript
    npm list -g instant-markdown-d &>/dev/null || npm install -g instant-markdown-d
    npm list -g csslint &>/dev/null || npm install -g csslint
    npm list -g htmlhint &>/dev/null || npm install -g htmlhint
    npm list -g standard &>/dev/null || npm install -g standard
    npm list -g ts-standard@10.0.0 &>/dev/null || npm install -g ts-standard@10.0.0
    npm list -g pyright &>/dev/null || npm install -g pyright
fi


# copy required files
cp setup/vimrc.txt ~/.vimrc
if [[ "$*" == *"--with-go"*  ]]; then
    if [[ "$OSTYPE" == "darwin"* ]]; then
        sed -i '' "s/\" Plug 'fatih\/vim-go'/Plug 'fatih\/vim-go'/g" ~/.vimrc
    else
        sed -i "s/\" Plug 'fatih\/vim-go'/Plug 'fatih\/vim-go'/g" ~/.vimrc
    fi
fi

if [ -d "$HOME/.vim" ]; then
    echo 'Cleaning up the old .vim directory...'
    chmod -R 0755 ~/.vim
    rm -rf ~/.vim
fi
cp -r setup/dot_vim ~/.vim
cp setup/csslintrc.txt ~/.csslintrc

# generate the Plug install command for the YouCompleteMe plugin
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

if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i '' "s/ARGS_TO_REPLACE/$INSTALL_ARGS/g" ~/.vimrc
else
    sed -i "s/ARGS_TO_REPLACE/$INSTALL_ARGS/g" ~/.vimrc
fi

# setup vim plugin manager
vim +"colorscheme OceanicNext2" +PlugInstall +qall

# everything is done
echo 'Your vim setup is finished. Happy hacking!'
echo 'Please restart your terminal'
