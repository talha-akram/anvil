# Anvil
A highly adaptable Neovim distribution. The goal is to have a minimal Neovim
configuration providing a great development experience out of the box.
So instead of spending hours getting the basics to work (LSP, autocomplete,
snippets, TreeSitter and git etc.) you can focus on customizing Neovim with
features you need without being overwhelmed by bloat that is endemic to most
Neovim distributions. Anvil is extremely lightweight, has little to no
configuration of its own and only adds essential plugins that are needed to
have a comfortable development experience. For most users, all that should be
needed is to customize the key bindings and configure a language server.

## Preview:
![anvil preview](/images/anvil.png?raw=true "anvil preview")

### Completions

Includes full LSP support and suggestions for snippets

![anvil completions preview](/images/anvil-completions.png?raw=true "anvil completions preview")

Anvil uses LuaSnip as the snippet engine, and has support for vscode and LSP snippets out of the box.
Adding more snippets is as simple as editing a ![json file](./snippets/javascript.json "link to
javascript.json file containing example snippets") file while more advance/smart snippets can be written
in Lua using LuaSnip. omnifunc is set to show LSP completions and completefunc is set to show snippet
completions while nvim-cmp is configured to show completions from all sources.

### StatusLine

Awesome StatusLine implemented in Lua, without any plugin dependencies.
![check it out!](/lua/configuration/statusline.lua "link to anvil statusline code")

![StatusLine preview](/images/statusline.png?raw=true "StatusLine preview")

- Current mode indicator
- Current file path including unwritten state and read only indicator
- Buffer list ( use `<Leader> + b` or `[b` and `]b` to quickly switch between buffers)
- Stats related to diagnostics (number of Errors `E`, Warnings `W`, Information `I` and Hints `H`)
- Language Server status
- File encoding, format and type information
- File position indicators (current file progress + cursor coordinates)

All this without any patched font madness! works great over ssh and locally.

An accent color is applied to the statusbar depending on current mode. The color is applied to Mode,
Current Buffer, file format, and cursor position indicator sections of the statusline.

![StatusLine normal mode preview](/images/normal.png?raw=true "StatusLine normal mode preview")
![StatusLine insert mode preview](/images/insert.png?raw=true "StatusLine insert mode preview")
![StatusLine replace mode preview](/images/replace.png?raw=true "StatusLine replace mode preview")
![StatusLine visual mode preview](/images/visual.png?raw=true "StatusLine visual mode preview")
![StatusLine command mode preview](/images/command.png?raw=true "StatusLine command mode preview")
![StatusLine normal mode terminal preview](/images/normal-terminal.png?raw=true "StatusLine normal mode terminal preview")
![StatusLine insert mode terminal preview](/images/insert-terminal.png?raw=true "StatusLine insert mode terminal preview p")


## Directory Structure:

Anvil has a very simple directory structure to make it easy to understand, navigate and extend.

```
.
├── compiler
│  └── python.vim
├── images
│  ├── anvil-completions.png
│  └── anvil.png
├── init.lua
├── LICENSE
├── lua
│  ├── configuration
│  │  ├── autocommands.lua
│  │  ├── init.lua
│  │  ├── keymaps.lua
│  │  ├── options.lua
│  │  └── statusline.lua
│  └── plugins
│     ├── cmp.lua
│     ├── dapui.lua
│     ├── diffview.lua
│     ├── gitsigns.lua
│     ├── init.lua
│     ├── lspconfig.lua
│     ├── luasnip.lua
│     ├── neogit.lua
│     ├── reply.lua
│     ├── telescope.lua
│     └── treesitter.lua
├── plugin
│  └── packer_compiled.lua
├── README.md
├── settings
├── snippets
│  ├── javascript.json
│  ├── javascriptreact.json
│  └── package.json
└── undodir
```
## Goals

To create a highly extensible neovim configuration that can easily be adapted as an IDE for
any programming language via LSP while staying light and as close to vanilla neovim as possible.
This distribution aims to be a non intrusive, solid base which the user can easily customize to
fit their workflow needs.

## Contributing
Found a bug or something is broken?
Have a suggestion or feature you want added?
Please open an issue.

Want to contribute? Awesome! please make a pull request.
