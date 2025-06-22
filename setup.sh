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
   echo "--with-rust      Add optional Rust support."
   echo
}
################################################################################


# Detect if a user wants a help message
if [[ "$1" == "--help"  || "$1" == "-h" ]]; then
    Help
    exit;
fi

# copy required files
cp setup/vimrc.txt ~/.vimrc

if [ -d "$HOME/.vim" ]; then
    echo 'Cleaning up the old .vim directory...'
    chmod -R 0755 ~/.vim
    rm -rf ~/.vim
fi
cp -r setup/dot_vim ~/.vim
cp setup/csslintrc.txt ~/.csslintrc

# Install dependencies
if [[ ! "$*" == *"--skip-install"*  ]]; then
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if [ -f "/etc/arch-release" ]; then
            sudo pacman --noconfirm -S git cmake gcc ctags curl base-devel
            sudo pacman --noconfirm -S python-pip python-wheel python-setuptools
            sudo pacman --noconfirm -S python-flake8 autopep8

            if [[ $DISPLAY ]]; then 
                if [[ $WAYLAND_DISPLAY ]]; then 
                    sudo pacman --noconfirm -S gvim wl-clipboard
                else
                    sudo pacman --noconfirm -S gvim xsel
                fi
            else
                sudo pacman --noconfirm -S vim
            fi
        elif [ -f "/etc/redhat-release" ]; then
            sudo dnf makecache
            sudo dnf -y install tar curl vim-enhanced git cmake
            sudo dnf -y install gcc-c++

            RH_VERSION="$(cat /etc/os-release | grep 'REDHAT_SUPPORT_PRODUCT_VERSION=' | cut -d '=' -f2 | cut -d '.' -f1 |  grep -Eo '[0-9]+')"

            if [[ "$RH_VERSION" == "9" ]]; then
                sudo dnf -y group install "Development Tools"
                sudo dnf -y install python3-pip python3-devel python3-setuptools*
                pip3 install --user flake8
                pip3 install --user autopep8
            elif [[ "$RH_VERSION" == "8" ]]; then
                sudo dnf -y group install "Development Tools"

                # it's close to impossible to support RH8 at this point, so that's the best I can do
                sudo dnf -y install python3.11 python3.11-pip python3.11-devel python3.11-setuptools* python3.11-wheel python3.11-pip-wheel
                sudo alternatives --set python /usr/bin/python3.11
                sudo ln -s /usr/bin/pip3.11 /usr/bin/pip
                pip install --user flake8
                pip install --user autopep8
            else
                sudo dnf -y group install "development-tools"
                sudo dnf -y install python3-pip python3-devel python3-setuptools python3-wheel
                sudo dnf -y install python3-flake8 python3-autopep8
            fi

            if [[ $DISPLAY ]]; then 
                echo; echo
                echo "Consider running the following command to enable system clipboard support in VIM:"
                if [[ $WAYLAND_DISPLAY ]]; then 
                    echo "       sudo dnf -y install vim-X11 wl-clipboard"
                else
                    echo "       sudo dnf -y install vim-X11 xsel"
                fi
                echo; echo
                echo "       sudo ln -s /usr/bin/vimx /usr/local/bin/vim"
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
                if [[ $WAYLAND_DISPLAY ]]; then 
                    echo "       sudo apt install -y vim-gtk3 wl-clipboard"
                else
                    echo "       sudo apt install -y vim-gtk3 xsel"
                fi
                echo; echo
            fi
        fi

        # copy fonts to a user directory
        mkdir -p ~/.local/share/fonts
        cp -rf fonts/* ~/.local/share/fonts/.

        # only install and set up NVM if it's not installed already
        if [[ ! -d "$HOME/.nvm" ]]; then
            curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash
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
            curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | zsh
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

# generate the Plug install command for the CoC plugin
INSTALL_ARGS="coc-json coc-tsserver coc-clangd coc-pyright coc-snippets"

if [[ "$*" == *"--with-java"*  ]]; then
    INSTALL_ARGS+=" coc-java"
fi

if [[ "$*" == *"--with-csharp"*  ]]; then
    INSTALL_ARGS+=" coc-omnisharp"
fi

if [[ "$*" == *"--with-rust"*  ]]; then
    INSTALL_ARGS+=" coc-rust-analyzer"
fi

if [[ "$*" == *"--with-go"*  ]]; then
    INSTALL_ARGS+=" coc-go"

    if [[ "$OSTYPE" == "darwin"* ]]; then
        sed -i '' "s/\" Plug 'fatih\/vim-go'/Plug 'fatih\/vim-go'/g" ~/.vimrc
    else
        sed -i "s/\" Plug 'fatih\/vim-go'/Plug 'fatih\/vim-go'/g" ~/.vimrc
    fi
fi

if [[ "$*" == *"--with-rust"*  ]]; then
    if [[ "$OSTYPE" == "darwin"* ]]; then
        sed -i '' "s/\" Plug 'rust-lang\/rust\.vim'/Plug 'rust-lang\/rust\.vim'/g" ~/.vimrc
    else
        sed -i "s/\" Plug 'rust-lang\/rust\.vim'/Plug 'rust-lang\/rust\.vim'/g" ~/.vimrc
    fi
fi

# setup vim plugin manager
vim +"colorscheme OceanicNext2" +PlugInstall +qall

# setup CoC
vim -c "colorscheme OceanicNext2" -c "CocInstall $INSTALL_ARGS" -c "qall"

# everything is done
echo 'Your vim setup is finished. Happy hacking!'
echo 'Please restart your terminal'
