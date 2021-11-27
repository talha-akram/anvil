-- nvim-treesitter ccnfiguration
local config = require('nvim-treesitter.configs')

return config.setup({
  ensure_installed = {
    'css', 'dockerfile', 'elixir', 'erlang', 'fish', 'html', 'http', 'javascript',
    'json', 'lua', 'php', 'python', 'regex', 'ruby', 'rust', 'scss', 'svelte',
    'typescript', 'vue', 'yaml'
  },
  ignore_install = {},
  modules = {
    highlight = {
      additional_vim_regex_highlighting = false,
      custom_captures = {},
      disable = { "markdown" },
      enable = true,
    },
    incremental_selection = {
      disable = {},
      enable = true,
      keymaps = {
        init_selection = "gnn",
        node_decremental = "grm",
        node_incremental = "grn",
        scope_incremental = "grc"
      },
    },
    indent = {
      disable = {},
      enable = true,
    }
  },
  sync_install = false,
  update_strategy = "lockfile"
})

