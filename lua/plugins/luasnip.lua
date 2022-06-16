local set_keymap = vim.keymap.set
local luasnip = require('luasnip')
local types = require('luasnip.util.types')
local options = { silent = false, noremap = true }

-- Directory where custom snippets are saved
-- local snippet_dir = vim.fn.stdpath('config') .. 'snippets'
-- require("luasnip.loaders.from_vscode").lazy_load({ paths = { snippet_dir } })
require('luasnip.loaders.from_vscode').lazy_load()

luasnip.filetype_extend('javascriptreact', {'html', 'javascript', 'react', 'react-ts'})
luasnip.filetype_extend('typescriptreact', {'html', 'typescript', 'react', 'react-ts'})
luasnip.filetype_extend('vue', {'html', 'javascript', 'pug'})
luasnip.filetype_extend('ruby', {'rails'})

-- Expand/Jump forward if a snippet is available
set_keymap('i', '<Tab>',
  function()
    if luasnip.expand_or_jumpable() then
      return '<Plug>luasnip-expand-or-jump'
    else
      return '<Tab>'
    end
  end,
  { expr = true, silent = true, noremap = true }
)

-- Jump backward
set_keymap({'i', 's'}, '<S-Tab>', function() luasnip.jump(-1) end, options)

-- Change choices in choiceNodes
set_keymap(
   {'i', 's'},
   '<A-Tab',
  function()
    if luasnip.choice_active() then
      return '<Plug>luasnip-next-choice'
    else
      return '<A-Tab>'
    end
  end,
  { expr = true, silent = true, noremap = true }
)

return luasnip.config.setup({
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = {{'●', 'Statement'}},
      },
    },
    [types.insertNode] = {
      active = {
        virt_text = {{'●', 'Identifier'}},
      },
    },
  },
})

