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
