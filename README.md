## Vim/Neovim automatic installation for most distros

Supported OS/distros:

- WSL ([Windows Terminal](https://apps.microsoft.com/detail/9n0dx20hk701?rtc=1&hl=en-us&gl=US) app is strongly recommended)
- MacOS ([iTerm2](https://iterm2.com/) app is strongly recommended)
- Debian / Ubuntu / Mint
- Fedora
- Arch / Manjaro
- RedHat / CentOS / AlmaLinux / Rocky Linux


### Installation

1. Clone this repo anywhere on your machine (or [download](https://github.com/mrpeabody/vim_setup/archive/refs/heads/master.zip) the archive from here):

```bash
git clone https://github.com/mrpeabody/vim_setup
```

2. Run **setup.sh**:

```bash
cd vim_setup && ./setup.sh
```

> Optional Extra languages are supported:
>    - If Java support needed, run **setup.sh** with `--with-java`: `./setup.sh --with-java`
>    - If C# support needed, run **setup.sh** with `--with-csharp`: `./setup.sh --with-csharp`
>    - If Golang support needed, run **setup.sh** with `--with-go`: `./setup.sh --with-go`
>    - If Rust support needed, run **setup.sh** with `--with-rust`: `./setup.sh --with-rust`
>    - Flags can be combined, for example: `./setup.sh --with-java --with-go`
>
>   *Note: Extra SDKs for these languages must be installed prior*

3. Install and use one of the included patched fonts. The most popular dev fonts are included in the
`fonts` directory, more can be found [here](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts). 
Otherwise, in `~/.vimrc`, change the **g:font_patched** variable to **0** and comment out the `Plugin 'ryanoasis/vim-devicons'` line.

4. Restart the terminal and enjoy your new fresh vim!


### Some Features

##### Comments:
- Comment/Uncomment line: `gcc`
- Comment/Uncomment selection: `gc`
- Uncomment a block of commented lines: `gcgc`

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
    - go to the Nth tab: `tn <1-9>, then Enter`
    - move the tab to the Nth position (starting with 0): `tm <0-9>, then Enter`
- Close a tab: `td`


##### Formatting:
- fix indentation of a selected region: `=`
- fix indentation of the whole file: `gg=G`
- fix indentation of a current block (inside of a function/if/loop): `=aB`
- fix indentation of a current line (in NORMAL mode): `==`


##### Multiple Cursors: #####
In order to select multiple occurrences of the same word, press:

- `Ctrl + N` to start/select next occurrence
- `Ctrl + X` to skip current selection and move to the next one
- `Ctrl + P` to select a previous word/unselect current word

After multiple occurrences are selected, any action over the selection is appropriate: `c/d/i/a` etc.

![Demo](https://github.com/terryma/vim-multiple-cursors/blob/master/assets/example1.gif?raw=true "Multiple Selections")


##### Move lines: #####
- Move current line/selection up: `Alt + k`
- Move current line/selection down: `Alt + j`

**Note**: if your ALT key is not working, look [below](#alt-key) for the solution.

![Demo](https://camo.githubusercontent.com/692e9921774e6b4ab43c06bd19dce6b6ea411a9eeff86b70bb522e1e3ce269f3/687474703a2f2f692e696d6775722e636f6d2f524d76384b734a2e676966 "Moving line[s]")


##### Code structure view (just like in PyCharm) #####
- Show / Hide the code structure: `<,> then b`


##### Open File(s) Quickly  #####

![File search demo](https://ctrlpvim.github.io/ctrlp.vim/images/ctrlp.png "File search Demo")

- Hit `Ctrl + p` to open file search menu, then start typing to get search results
- Use `Ctrl + j/k` to navigate through search results
- Use `Ctrl + z` to select/deselect multiple files
- Create a file and directories in the path, type the path/filename then: `Ctrl + y` 
- Switch search mode (files only, buffers only, most recent files, all together): `Ctrl + f / b`
- Open the file(s) in a split/vertical split/tab: `Ctrl + x / v / t`
- Close search menu: `Esc`


##### Markdown Live Preview #####

- Start Live preview (it also autoscrolls as you work on the file): `:InstantMarkdownPreview`
- Stop Live preview: `:InstantMarkdownStop`

![Markdown Live Preview Demo](https://i.imgur.com/r7G6FNA.gif)


##### Other small features:

- flip function arguments/list elements/dictionary key-value pairs inline or stacked vertically: `<,> then a`

![Wrap/Unwrap arguments](https://git.sr.ht/~foosoft/vim-argwrap/blob/master/img/demo.gif "Wrap/Unwrap arguments")

- remove trailing whitespace: `<,> then ss`
- Show/Hide the file tree (NERD Tree): `<,> then N`
- Go to next/previous git change in code: `]c` / `[c`
- Undo a git change (if the cursor on the changed line/area): `<,> then hu`
- Toggle Relative/Absolute line numbers: `Ctrl + T twice`
- Going through syntax errors/warnings: `]e` / `[e`
- Open a list of errors/warnings (if any): `<,> then L`
- Align text by a character: use `gl` and `gL` hotkey (spaces to the left or right):  `gl<where><character>`


### Python/JavaScript/TypeScript/Go/C/C++ specific Features

This setup is been created having **Python** and **JavaScript/TypeScript/Go/C/C++** in mind, 
therefore it has some advanced features:

- Full Support of **PEP8** (auto indentation, beautify)
- Syntax validation, including formatting recommendations
- Autocomplete using **Python** Jedi (IDE), including function signatures and argument hints
- IDE-level support of **TypeScript** **Go**, including function signatures and type-awareness
- Smart JavaScript/JSON/JSX/HTML/CSS Indentation
- Out-of-the-Box support of main **JavaScript** libraries (autocomplete, syntax, etc)
- Large collection of **Python** and **JavaScript/TypeScript/Go** snippets


##### Special hotkeys #####

**JavaScript**, **TypeScript**, **Java**, **Go**, **Python**, **C/C++**:

- fully format the whole file: `F8` (except **Java** and **C/C++**)
- show symbol documentation: `<,> then d`
- navigate to the location where a symbol is defined: `Ctrl + ]`
- show location(s) where a symbol is referenced: `Ctrl + ^`
- show/hide location(s) list: `<,> then q`
- go to next/previous location in the list: `]q` / `[q`
- refactor (change name of) a symbol under cursor: `<,> then e`

**Python**:

- run the file using **Python**: `F5`
- run the file using **Python3**: `F6`


### Miscellaneous
- Autocomplete (use `Ctrl + N` or `Ctrl + P` to navigate through the list of suggestions)
- Snippets: type a keyword (or select from the list of suggestions), then hit Tab to insert the snippet
and then go through its placeholders
- other very neat plugins like parentheses and quotes handling, etc.


#### ALT key ####
In order for **ALT** key to work on Mac, do the following:

- iTerm2: `Preferences -> Profiles -> Keys -> Left option key acts as:` set to `+Esc`
- Terminal: `Preferences -> Profiles -> Use Option as Meta key` check


#### vim as a git diff/merge tool ####
The following commands will make git use vim as a diff/merge tool:

```bash
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


#### Neovim support ####
This setup works great for Neovim as well. The easiest way to use the same settings for both apps is to configure the `nvim.vim`
to utilize the `.vimrc` config.

First, create the Neovim config directory:

```bash
mkdir -p ~/.config/nvim
```

In the `~/.config/nvim` directory, create the `nvim.vim` file with the following contents:

```bash
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc
```

Then, Neovim requires a few extra packages from PIP and NPM in order to function with this setup:

```bash
pip install --user --upgrade pynvim
npm install -g neovim
```

To make Neovim work well with git (log pager, commit message editor, difftool, etc) -- in addition to the other git settings from above:

```bash
git config --global mergetool.vimdiff.cmd 'nvim -dR $LOCAL $REMOTE'
git config --global core.pager "nvim -R"
git config --global color.pager no
```
