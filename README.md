# Anvil
A highly adaptable Neovim distribution. The goal is to have a minimal Neovim
configuration providing a great development experience out of the box.
Anvil favours building on top of native features over adding plugins.
So instead of spending hours getting the basics to work or navigating through
a huge mess of plugins, you can focus on customizing Neovim with
features you need without being overwhelmed. Anvil is extremely lightweight,
has little to no configuration of its own and only adds essential plugins that
are needed to have a comfortable development experience. For most users, all
that should be needed is to customize the key bindings and configure a language server.

## Preview:
<img width="1271" alt="anvil preview" src="https://github.com/user-attachments/assets/710967a1-7f6d-4a70-827f-247de3ae982b" />

### Completions
#### `<A-Space>` opens completions for available snippets where as `<C-Space>` open code completions

<img width="1262" alt="image" src="https://github.com/user-attachments/assets/d6e99dea-58ee-4c4b-a03a-64cedfd45827" />

The completions are powered by the LSP and the snippets are provided by `friendly-snippets`. Additionally custom snippets can be added under `snippets/${FILE_TYPE}.json`which will get loaded automatically and become available for that file type. The snippets are defined using the LSP snippet definition format and will override any matching snippet from `friendly-snippets`.

### Fast minimal picker using MiniPick:
Anvil uses [mini.pick](https://github.com/echasnovski/mini.pick) as the default fuzzy finder and general purpose list picker, primarily due to how easy it is to extend with functionality, ease of use, performance, small size and zero dependencies on other plugins / extensions.

![image](https://github.com/user-attachments/assets/a36d5696-0b6a-4185-b6f5-0db4ac68bef9)

Have a look at [lua/plugins/picker.lua](https://github.com/talha-akram/anvil/blob/master/lua/plugins/picker.lua) to see what is available and to use as a reference to help in building your own custom pickers.

### Status Line
An easy to modify Status Line written in Lua shows detailed information related to your opened buffer:
- Current mode indicator.
- Current file path including unwritten state and read only indicator.
- Stats related to diagnostics (number of Errors `E`, Warnings `W`, Information `I` and Hints `H`).
- Attached Language Servers.
- Cursor position (including selected characters and line count in visual mode).
- File indentation and encoding information.
- Buffer number information.
- File type.
- Scroll position.

All this without using any patched fonts, works great over ssh and locally and looks great everywhere!

#### StatusLine preview

<img width="1216" alt="image" src="https://github.com/user-attachments/assets/5e37fde3-ea61-4a03-9adb-6c9b1eb6ffe8" />

An accent color is applied to the StatusBar depending on current mode. The accent color is only applied to the mode indicator, cursor position, buffer number and file type information.

## Goals
To create a highly extensible Neovim configuration that can easily be adapted as an IDE for
any programming language via LSP while staying light and as close to vanilla Neovim as possible.
This distribution aims to be a non intrusive, solid base which the user can easily customize to
fit their workflow needs.

## Contributing
Found a bug or something is broken?
Have a suggestion or feature you want added?
Please open an issue.

Want to contribute? Awesome! Please make a pull request.
