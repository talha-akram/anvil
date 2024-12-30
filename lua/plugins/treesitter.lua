-- nvim-treesitter configuration
local config = require('nvim-treesitter.configs')
local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
local query = vim.treesitter.query
local query_types = { 'folds', 'highlights', 'indents', 'injections', 'locals' }

vim.o.foldmethod  = 'expr'
vim.o.foldexpr    = 'nvim_treesitter#foldexpr()'
vim.g.skip_ts_context_commentstring_module = true

config.setup({
  ensure_installed = {
    'css', 'dockerfile', 'elixir', 'erlang', 'fish', 'html', 'http', 'javascript',
    'json', 'lua', 'php', 'python', 'regex', 'ruby', 'rust', 'scss', 'svelte',
    'typescript', 'vue', 'yaml', 'markdown', 'bash', 'c', 'cmake', 'comment',
    'cpp', 'dart', 'go', 'jsdoc', 'json5', 'jsonc', 'llvm', 'make', 'ninja',
    'prisma', 'proto', 'pug', 'swift', 'todotxt', 'toml', 'tsx', 'vim', 'vimdoc',
    'gitcommit', 'git_rebase',
  },
  highlight = {
    additional_vim_regex_highlighting = false,
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gs',
      node_decremental = '<C-j>',
      node_incremental = '<C-k>',
      scope_incremental = 'gss'
    },
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  },
  indent = {
    enable = true,
  },
  custom_captures = {
    ['annotation'] = 'Annotation',
  },
  sync_install = false,
})

-- Configure slim support
local slim_parser = vim.fn.stdpath('data') .. '/lazy/tree-sitter-slim'

vim.filetype.add({
  extension = {
    slim = 'slim',
  },
})

parser_config.slim = {
  install_info = {
    url = slim_parser,
    files = {'src/parser.c', 'src/scanner.c'},
  },
  filetype = 'slim',
}

-- ToDo: Need to figureout why this is notot working
for _, query_type in ipairs(query_types) do
  local query_file = string.format('%s/queries/%s.scm', slim_parser, query_type)

  if vim.fn.filereadable(query_file) == 1 then
    query.set('slim', query_type, table.concat(vim.fn.readfile(query_file), '\n'))
  end
end
