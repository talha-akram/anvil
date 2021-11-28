# anvil
A work in progress highly adaptable neovim distribution.

## Preview:
![anvil preview](/images/anvil.png?raw=true "anvil preview")

### Completions

![anvil completions preview](/images/anvil-completions.png?raw=true "anvil completions preview")

### StatusLine

Awesome statusline implemented in lua, without any plugin dependencies.

![check it out!](/lua/configuration/statusline.lua "link to anvil statusline code")

## Directory Structure:
```
.
├── after
│  └── ftplugin
│     └── python.vim
├── autoload
├── compiler
│  └── python.vim
├── images
│  ├── anvil-completions.png
│  └── anvil.png
├── init.lua
├── LICENSE
├── lua
│  ├── configuration
│  │  ├── eslint.lua
│  │  ├── init.lua
│  │  ├── options.lua
│  │  └── statusline.lua
│  └── plugins
│     ├── cmp.lua
│     ├── init.lua
│     ├── lsp.lua
│     ├── reply.lua
│     ├── telescope.lua
│     ├── treesitter.lua
│     └── vsnip.lua
├── plugin
│  └── packer_compiled.lua
├── README.md
├── settings
├── snippets
│  ├── javascript.json
│  ├── javascriptreact.json
│  └── javascriptreact.snippets
├── startup
│  ├── AutoCommands.vim
│  └── Keybindings.vim
```
## Goals

To create a highly extensible neovim configuration that can easily be adapted as an IDE for any programming language via LSP while staying light and as close to vanilla neovim as possible. This distribution aims to be a non intrusive, solid base which the user can easily customize to fit their workflow needs.

## Contributing
Found a bug or something is broken?
Have a suggestion or feature you want added?
Please open an issue.

Want to contribute? Awesome! please make a pull request.
