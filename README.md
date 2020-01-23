# anvil
A work in progress highly adaptable neovim distribution.

## Preview:
![anvil preview](/images/anvil.png?raw=true "anvil preview")

Completions

![anvil completions preview](/images/anvil-completions.png?raw=true "anvil completions preview")

## Directory Structure:
```
.
├── after
│  └── ftplugin
│     └── python.vim
├── coc-settings.json
├── compiler
│  └── python.vim
├── images
│  ├── anvil-completions.png
│  └── anvil.png
├── init.vim
├── LICENSE
├── README.md
├── settings
│  ├── LanguageClient-neovim.vim
│  ├── lightline.vim
│  ├── neosnippet.vim
│  ├── NERDTree.vim
│  ├── nvim-LSP.vim
│  ├── REPL.vim
│  ├── reply.vim
│  ├── UltiSnips.vim
│  ├── vim-clap.vim
│  ├── vim-lsc.vim
│  └── vim-lsp.vim
└── startup
   ├── AutoCommands.vim
   ├── Keybindings.vim
   └── Options.vim
```
## Goals

To create a highly extensible neovim configuration that can easily be adapted as an IDE for any programming language via LSP while staying light and as close to vanilla neovim as possible. This distribution aims to be a non intrusive, solid base which the user can easily customize to fit their workflow needs.

## Contributing
Found a bug or somthing is broken?
Have a suggestion or feature you want added?
Please open an issue.

Want to contribute? Awesome! please make a pull request.
