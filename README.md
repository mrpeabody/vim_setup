## Vim/Neovim automatic installation for MacOS X/Ubuntu/Windows Bash

1. Clone this repo anywhere on your machine
2. Run **setup.sh**: `./setup.sh`
    - Optionally, if you need the support for C-languages (Java, C++, etc), 
    there's an optional clang support: `./setup.sh --clang-completer`
3. Enjoy your new fresh vim!

4. (Optional) in order for a fancy bottom panel to look great, install and use the included Monaco patched 
font for Mac, 
for other systems patched fonts can be found [here](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts).

Alternatively, in `.vimrc`, change the `g:font_patched` variable to **0** and comment out 
the `Plugin 'ryanoasis/vim-devicons'` line.


### Prerequisites
- **Python** and **Python3**
- **Node.js** 

On **Ubuntu**, it makes sense to make a symlink in order to be able to run 'node' instead of 'nodejs':
```
sudo ln -s `which nodejs` /usr/bin/node
```

### Some Features

##### Comments:
- Comment/Uncomment line: `gcc`
- Comment/Uncomment selection: `gc`
- Uncomment a block of commented lines: `gcgc`

##### Folding:
- toggle fold for a block/method/class: `<Space>`
- fold everything: `zM`
- unfold everything: `zR`

##### Scrolling through the code:
- Moves screen up one line: `Ctrl + y` 
- Moves screen down one line: `Ctrl + e`
- Moves screen up ½ page: `Ctrl + u`
- Moves screen down ½ page: `Ctrl + d`
- Moves screen up one page: `Ctrl + b`
- Moves screen down one page: `Ctrl + f`

##### Split Screen:
- `:sp` for a horizontal split
- `:vs` for a vertical split
- Navigate between splits: `Ctrl + h/j/k/l` 
- Align all splits equally: `Ctrl + W, then =`
- Swap two splits: `Ctrl + W, then R`
- Resize vertical split: `Shift + -/+`
- Increase the horizontal split: `-`

##### Tabs (like in sublime/atom/pycharm):
- Create new tab: `tt`, then enter the file path to open
- Switch between tabs:
    - Previous/Next tab: `tk / tj`
    - First/Last tab: `th / tl`
    - go to the Nth tab: `tn <1-9>`
- Close a tab: `td`

##### Formatting:
- fix indentation of a selected region: `=`
- fix indentation of the whole file: `gg=G`
- fix indentation of a current block (inside of a function/if/loop): `=aB`
- fix indentation of a current line (in NORMAL mode): `==`

##### Multiple Cursors: #####
In order to select multiple occurences of the same word, press:

- `Ctrl + N` to start/select next occurence
- `Ctrl + X` to skip current selection and move to the next one
- `Ctrl + P` to select a previous word/unselect current word

After multiple occurences are selected, any action over the selection is appropriate: `c/d/i/a` etc.
![Demo](https://github.com/terryma/vim-multiple-cursors/blob/master/assets/example1.gif?raw=true "Multiple Selections")

##### Move lines: #####
- Move current line/selection up: `Ctrl + k`
- Move current line/selection down: `Ctrl + j`

**Note**: If moving line(s) causes folding, just open all folds in the file through: `zR`

![Demo](https://camo.githubusercontent.com/c06acab07e6bf0bb27086c9694fe2f456101d21c/687474703a2f2f692e696d6775722e636f6d2f524d76384b734a2e676966 "Moving line(s)")


##### Other small features:
- flip function arguments/list elements/dictionary key-value pairs inline or stacked vertically: `<,> then a`
![Wrap/Unwrap arguments](https://camo.githubusercontent.com/9a8e220911e514ce29198d9b7827c05085fb3e35/68747470733a2f2f666f6f736f66742e6e65742f70726f6a656374732f76696d2d617267777261702f696d672f64656d6f2e676966 "Wrap/Unwrap arguments")
- remove trailing whitespace: `<,> then ss`
- add a comma/semicolon at the end of the line (detects automatically, works in both NORMAL and INSERT modes): `<,> then ;`
- Show/Hide minimap of the code: `<,> then M`
- Show/Hide the file tree (NERD Tree): `<,> then N`
- Go to next/previous git change in code: `]c` / `[c`
- Undo a git change (if the cursor on the changed line/area): `<,> then hu`


### Python/JavaScript specific Features
This setup is been created having **Python** and **JavaScript** in mind, 
therefore it has some advanced features:

- Full Support of **PEP8** (auto indentation, beautify)
    - fully format the whole file: `F8`
- Autocomplete using **Python** Jedi (IDE)
- Out-of-the-Box support of main **JavaScript** libraries (autocomplete, syntax, etc)
- JavaScript/JSON/JSX/HTML/CSS Indentation and Beautify: 
    - format selection: `Ctrl-F`
    - fully format the whole file: `F9`
- Large collection of Python and **JavaScript** snippets
- Run the file using **Python**: `F5`
- Run the file using **Python3**: `F6`


The setup also contains:

- Autocomplete (use `Ctrl + N` or `Ctrl + R` to navigate through the list of suggestions)
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

**Usage**:

- `git difftool` or `git d` then two states to compare. If no states mentioned, will compare the last committed 
changes with uncommitted ones. Even though this mode is designed to compare versions, it's still possible to use it
as a quick fix tool - a change can be undone to the previous state with `do` command.

- `git mergetool` will open a vim in the merge mode. Use `:diffget RE/BA/LO` to select remote, base (previous), or local
version as the merged one.

- in both modes, navigate through changes by using `[c` for jump to next change and `]c` to jump to 
previous change.
