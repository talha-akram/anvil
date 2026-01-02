# Anvil
My very light neovim personal developement environment (PDE) that provides a great development experience out of the box with minimal dependence on [plugins](https://github.com/talha-akram/anvil/blob/master/lua/configuration/plugins/init.lua).

## Preview:
![anvil preview](https://github.com/user-attachments/assets/710967a1-7f6d-4a70-827f-247de3ae982b)

### Completions
#### `<A-Space>` opens completions for available snippets where as `<C-Space>` open code completions

<img width="1262" alt="image" src="https://github.com/user-attachments/assets/d6e99dea-58ee-4c4b-a03a-64cedfd45827" />

The completions are powered by the LSP and the snippets are provided by `friendly-snippets`. Additionally custom snippets can be added under `snippets/${FILE_TYPE}.json`which will get loaded automatically and become available for that file type. The snippets are defined using the LSP snippet definition format and will override any matching snippet from `friendly-snippets`.

### Fast minimal picker using [mini.pick](https://github.com/echasnovski/mini.pick):
Anvil uses [mini.pick](https://github.com/echasnovski/mini.pick) as the default fuzzy finder and general purpose list picker.

![completion preview](https://github.com/user-attachments/assets/978b0aca-2dba-4fb8-85fc-f193cb246a8f)

To see what is available, checkout [lua/configuration/plugins/picker.lua](https://github.com/talha-akram/anvil/blob/master/lua/configuration/plugins/picker.lua).

### Status Line
A simple yet informative Status Line that does not require any patched fonts, includes:
- Current mode indicator.
- Current file path including unwritten state and read only indicator.
- Stats related to diagnostics (number of Errors `E`, Warnings `W`, Information `I` and Hints `H`).
- Attached Language Servers.
- Cursor position (including selected characters and line count in visual mode).
- File indentation and encoding information.
- Buffer number information.
- File type.
- Scroll position.

#### Preview
![Status Line preview](https://github.com/user-attachments/assets/5e37fde3-ea61-4a03-9adb-6c9b1eb6ffe8)
