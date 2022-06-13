-- nvim-treesitter configuration
local config = require('nvim-treesitter.configs')

vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'

return config.setup({
  ensure_installed = {
    'css', 'dockerfile', 'elixir', 'erlang', 'fish', 'html', 'http', 'javascript',
    'json', 'lua', 'php', 'python', 'regex', 'ruby', 'rust', 'scss', 'svelte',
    'typescript', 'vue', 'yaml', 'markdown', 'bash', 'c', 'cmake', 'comment',
    'cpp', 'dart', 'go', 'jsdoc', 'json5', 'jsonc', 'llvm', 'make', 'ninja',
    'prisma', 'proto', 'pug', 'swift', 'todotxt', 'toml', 'tsx',
  },
  highlight = {
    additional_vim_regex_highlighting = false,
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gsn",
      node_decremental = "gsm",
      node_incremental = "gsn",
      scope_incremental = "gss"
    },
  },
  context_commentstring = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  sync_install = false,
})

