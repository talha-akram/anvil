-- nvim-treesitter configuration
local config = require('nvim-treesitter.configs')

vim.o.foldmethod  = 'expr'
vim.o.foldexpr    = 'nvim_treesitter#foldexpr()'

config.setup({
  ensure_installed = {
    'css', 'dockerfile', 'elixir', 'erlang', 'fish', 'html', 'http', 'javascript',
    'json', 'lua', 'php', 'python', 'regex', 'ruby', 'rust', 'scss', 'svelte',
    'typescript', 'vue', 'yaml', 'markdown', 'bash', 'c', 'cmake', 'comment',
    'cpp', 'dart', 'go', 'jsdoc', 'json5', 'jsonc', 'llvm', 'make', 'ninja',
    'prisma', 'proto', 'pug', 'swift', 'todotxt', 'toml', 'tsx', 'vim',
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
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  indent = {
    enable = true,
  },
  custom_captures = {
    ['annotation'] = 'Annotation',
  },
  sync_install = false,
})

