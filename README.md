## VIM automatic installation for MacOS X and Ubuntu x86-64

1. Clone this repo anywhere on your machine
2. Run **setup.sh**: ```./setup.sh```
3. Enjoy your new fresh vim!

### Prerequisites
- **Python** and **Python3**
- **Node.js** 

On **Ubuntu**, it makes sense to make a symlink in order to be able to run 'node' instead of 'nodejs':
```sudo ln -s `which nodejs` /usr/bin/node```

### Features
This setup is been created having **Python** and **JavaScript** in mind, 
therefore it has some advanced features:

- Full Support of **PEP8** (auto indentation, beautify)
    - indent the whole file: ```gg=G```
    - fully format the whole file: ```F8```
- Autocomplete using **Python** Jedi (IDE)
- Out-of-the-Box support of main **JavaScript** libraries (autocomplete, syntax, etc)
- Large collection of Python and **JavaScript** snippets
- Run the file using **Python**: ```F5```
- Run the file using **Python3**: ```F6```


The setup also contains:

- Minimap like Sublime
- Autocomplete (use ```Ctrl+N``` or ```Ctrl+R``` to navigate through the list of suggestions)
- Snippets: type a keyword (or select from the list of suggestions), then hit Tab to insert the snippet
and then go through its placeholders
- other very neat plugins like parenthesis and quotes handling, etc.
