How to prepare your VIM:


1. Copy vimrc.txt to the HOME folder as .vimrc

2. Copy contents of dot_vim as .vim in the home folder

3. Install Vundle (vim package manager):
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

4. Install Vundle plugins from the .vimrc:
    vim +PluginInstall +qall

5. Prepare Code Completion (YouCompleteMe plugin):
    cd ~/.vim/bundle/YouCompleteMe
    ./install.py --all

More details: https://github.com/Valloric/YouCompleteMe#mac-os-x

6. Put dot_tern_config as .tern_config into the home folder (adds advanced support for JS)

7. Happy using!

