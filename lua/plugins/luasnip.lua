local set_keymap = vim.keymap.set
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local luasnip = require('luasnip')
local types = require('luasnip.util.types')
local options = { expr = true, silent = true, noremap = true }

-- Load snippets provided by extensions
require('luasnip.loaders.from_vscode').lazy_load()

-- Load custom snippets
local snippet_dir = vim.fn.stdpath('config') .. '/snippets'
require('luasnip.loaders.from_vscode').lazy_load({ paths = {snippet_dir} })

luasnip.filetype_extend('javascriptreact', {'html', 'react'})
luasnip.filetype_extend('typescriptreact', {'html', 'react-ts'})
luasnip.filetype_extend('vue', {'html', 'javascript', 'pug'})
luasnip.filetype_extend('ruby', {'rails'})

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
  options
)

-- Expand/Jump forward if a snippet is available
set_keymap('i', '<Tab>',
  function()
    if luasnip.expand_or_jumpable() then
      return '<Plug>luasnip-expand-or-jump'
    else
      return '<Tab>'
    end
  end,
  options
)

-- Jump backward
set_keymap(
  {'i', 's'},
  '<S-Tab>',
  function() luasnip.jump(-1) end,
  { silent = false, noremap = true }
)

local to_completion = function(snippet)
  return {
    word      = snippet.trigger,
    menu      = snippet.name,
    info      = vim.trim(table.concat(vim.tbl_flatten({snippet.dscr or "", "", snippet:get_docstring()}), '\n')),
    dup       = true,
    user_data = 'luasnip'
  }
end

local snippet_filter = function(line_to_cursor, base)
  return function(s)
    return not s.hidden and vim.startswith(s.trigger, base) and s.show_condition(line_to_cursor)
  end
end

-- Set 'completefunc' or 'omnifunc' to 'v:lua.completefunc' to get snippet completion.
function completefunc(findstart, base)
  local line, col = vim.api.nvim_get_current_line(), vim.api.nvim_win_get_cursor(0)[2]
  local line_to_cursor = line:sub(1, col)

  if findstart == 1 then
    return vim.fn.match(line_to_cursor, '\\k*$')
  end

  local snippets = vim.list_extend(vim.list_slice(luasnip.get_snippets('all')), luasnip.get_snippets(vim.bo.filetype))
  snippets = vim.tbl_filter(snippet_filter(line_to_cursor, base), snippets)
  snippets = vim.tbl_map(to_completion, snippets)
  table.sort(snippets, function(s1, s2) return s1.word < s2.word end)
  return snippets
end

local luasnip_expand = augroup('LuaSnip-expand', { clear = true })
autocmd('CompleteDone', {
  desc = 'expand snippet after selecting completion option',
  callback = function()
    if vim.v.completed_item.user_data == 'luasnip' and luasnip.expandable() then
      luasnip.expand()
    end
  end,
  group = luasnip_expand
})

vim.o.completefunc = 'v:lua.completefunc'

luasnip.config.setup({
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

