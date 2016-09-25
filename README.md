## Vim/Neovim automatic installation for MacOS X/Ubuntu/Windows Bash

1. Clone this repo anywhere on your machine
2. Run **setup.sh**: ```./setup.sh```
    - Optionally, if you need the support for C-languages (Java, C++, etc), 
    there's an optional clang support: ```./setup.sh --clang-completer```
3. Enjoy your new fresh vim!

### Prerequisites
- **Python** and **Python3**
- **Node.js** 

On **Ubuntu**, it makes sense to make a symlink in order to be able to run 'node' instead of 'nodejs':
```
sudo ln -s `which nodejs` /usr/bin/node
```

### Features
This setup is been created having **Python** and **JavaScript** in mind, 
therefore it has some advanced features:

- Full Support of **PEP8** (auto indentation, beautify)
    - indent the whole file: ```gg=G```
    - fully format the whole file: ```F8```
- Autocomplete using **Python** Jedi (IDE)
- Out-of-the-Box support of main **JavaScript** libraries (autocomplete, syntax, etc)
- JavaScript/JSON/JSX/HTML/CSS Indentation and Beautify: 
    - format selection: `Ctrl-F`
    - fully format the whole file: `F9`
- Large collection of Python and **JavaScript** snippets
- Run the file using **Python**: ```F5```
- Run the file using **Python3**: ```F6```


The setup also contains:

- Autocomplete (use ```Ctrl+N``` or ```Ctrl+R``` to navigate through the list of suggestions)
- Snippets: type a keyword (or select from the list of suggestions), then hit Tab to insert the snippet
and then go through its placeholders
- other very neat plugins like parenthesis and quotes handling, etc.

#### Neovim support ####
This setup should work for Neovim as well. The easiest way to use the same settings for both apps is to make 
symlinks for Neovim:

```
ln -s ~/.vim ~/.config/nvim
ln -s ~/.vimrc ~/.config/nvim/init.vim
```

#### (Neo)vim as a git diff/merge tool ####
The following commands will make git use vim as a diff/merge tool:

```
git config --global diff.tool vimdiff
git config --global merge.tool vimdiff
git config --global difftool.prompt false
git config --global merge.conflictstyle diff3
git config --global alias.d difftool
```

Usage:
- `git difftool` or `git d` then two states to compare. If no states mentioned, will compare the last committed 
changes with uncommitted ones. Even though this mode is designed to compare versions, it's still possible to use it
as a quick fix tool - a change can be undone to the previous state with `do` command

- `git mergetool` will open a vim in the merge mode. Use `:diffget RE/BA/LO` to select remote, base (previous) or local
version as the merged one.

- in both modes, navigate through changes by using `Ctrl + [` for jump to next change and `Ctrl + ]` to jump to 
previous change.
