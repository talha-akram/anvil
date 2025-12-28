-- TreeSitter configurations for nvim
return {
  name = 'nvim-treesitter',
  src = 'https://github.com/nvim-treesitter/nvim-treesitter',
  version = 'main',
  data = {
    build_cmd = 'TSUpdate',
    setup = function()
      vim.o.foldmethod  = 'expr'
      vim.o.foldexpr    = 'v:lua.vim.treesitter.foldexpr()'

      -- Configure slim support
      vim.filetype.add({
        extension = {
          slim = 'slim',
          coffee = 'coffeescript',
        },
      })

      require('nvim-treesitter').setup({
        ensure_installed = {
          'css', 'dockerfile', 'elixir', 'erlang', 'fish', 'html', 'http', 'javascript',
          'json', 'lua', 'php', 'python', 'regex', 'ruby', 'rust', 'scss', 'svelte',
          'typescript', 'vue', 'yaml', 'markdown', 'bash', 'c', 'cmake', 'comment',
          'cpp', 'dart', 'go', 'jsdoc', 'json5', 'jsonc', 'llvm', 'make', 'ninja',
          'prisma', 'proto', 'pug', 'swift', 'todotxt', 'toml', 'tsx', 'vim', 'vimdoc',
          'gitcommit', 'git_rebase', 'slim',
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
        indent = {
          enable = true,
        },
        custom_captures = {
          ['annotation'] = 'Annotation',
        },
        sync_install = false,
      })
    end,
  }
}
