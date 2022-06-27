# anvil
A work in progress highly adaptable neovim distribution.

## Preview:
![anvil preview](/images/anvil.png?raw=true "anvil preview")

### Completions

![anvil completions preview](/images/anvil-completions.png?raw=true "anvil completions preview")

- Include full LSP support
- Suggestions for snippets

### StatusLine

Awesome StatusLine implemented in lua, without any plugin dependencies. ![check it out!](/lua/configuration/statusline.lua "link to anvil statusline code")

![StatusLine preview](/images/statusline.png?raw=true "StatusLine preview")

- Current mode indicator
- Current file path including unwritten state and read only indicator
- Buffer list ( use `<Leader> + b` to show and switch between previous and next buffer using `[b` and `]b`)
- Stats related to diagnostics (number of Errors `E`, Warnings `W`, Information `I` and Hints `H`)
- Language Server status
- File encoding, format ant type information
- File position indicators (current file progress + cursor coordinates)

An accent color is appled to the statusbar depending on current mode. The color is appled to Mode, Current Buffer, file format, and cursor position indicator sections of the statusline.

![StatusLine normal mode preview](/images/normal.png?raw=true "StatusLine normal mode preview")
![StatusLine insert mode preview](/images/insert.png?raw=true "StatusLine insert mode preview")
![StatusLine replace mode preview](/images/replace.png?raw=true "StatusLine replace mode preview")
![StatusLine visual mode preview](/images/visual.png?raw=true "StatusLine visual mode preview")
![StatusLine command mode preview](/images/command.png?raw=true "StatusLine command mode preview")
![StatusLine normal mode terminal preview](/images/normal-terminal.png?raw=true "StatusLine normal mode terminal preview")
![StatusLine insert mode terminal preview](/images/insert-terminal.png?raw=true "StatusLine insert mode terminal preview p")


## Directory Structure:
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

To create a highly extensible neovim configuration that can easily be adapted as an IDE for any programming language via LSP while staying light and as close to vanilla neovim as possible. This distribution aims to be a non intrusive, solid base which the user can easily customize to fit their workflow needs.

## Contributing
Found a bug or something is broken?
Have a suggestion or feature you want added?
Please open an issue.

Want to contribute? Awesome! please make a pull request.
