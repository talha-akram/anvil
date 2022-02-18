-- nvim-treesitter ccnfiguration
local config = require('nvim-treesitter.configs')

return config.setup({
  ensure_installed = {
    'css', 'dockerfile', 'elixir', 'erlang', 'fish', 'html', 'http', 'javascript',
    'json', 'lua', 'php', 'python', 'regex', 'ruby', 'rust', 'scss', 'svelte',
    'typescript', 'vue', 'yaml', 'markdown'
  },
  highlight = {
    additional_vim_regex_highlighting = false,
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_decremental = "grm",
      node_incremental = "grn",
      scope_incremental = "grc"
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

