-- TreeSitter configuration
return {
  src = 'https://github.com/nvim-treesitter/nvim-treesitter',
  version = 'main',
  data = {
    setup = function()
      local languages = {
        'css', 'dockerfile', 'fish', 'html', 'http', 'javascript',
        'json', 'lua', 'python', 'regex', 'ruby', 'rust', 'scss',
        'typescript', 'vue', 'yaml', 'markdown', 'bash', 'c', 'cmake', 'comment',
        'cpp', 'dart', 'go', 'jsdoc', 'json5', 'llvm', 'make', 'ninja',
        'proto', 'pug', 'swift', 'todotxt', 'toml', 'tsx', 'vim', 'vimdoc',
        'gitcommit', 'git_rebase', 'slim',
      }

      -- Configure slim support
      vim.filetype.add({
        extension = {
          slim = 'slim',
          coffee = 'coffeescript',
        },
      })

      require('nvim-treesitter').install(languages)

      vim.api.nvim_create_autocmd('FileType', {
        desc = "Enable Treesitter",
        group = vim.api.nvim_create_augroup("enable_treesitter", {}),
        callback = function(event)
          local bufnr = event.buf
          local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
          -- Start treesitter for this buffer
          local start_ts = function()
            vim.treesitter.start(bufnr, parser_name)
            vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
            vim.wo.foldmethod = 'expr'
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end

          -- Skip if no filetype
          if filetype == "" then
            return
          end

          -- Get parser name based on filetype
          local parser_name = vim.treesitter.language.get_lang(filetype)
          if not parser_name then
            vim.notify(vim.inspect("No treesitter parser found for filetype: " .. filetype), vim.log.levels.WARN)
            -- Use regex based syntax-highlighting as fallback
            vim.bo[bufnr].syntax = "ON"
            return
          end

          -- Try to get existing parser
          local ts_config = require('nvim-treesitter.config')
          if not vim.tbl_contains(ts_config.get_available(), parser_name) then return end

          local already_installed = ts_config.get_installed('parsers')
          if not vim.tbl_contains(already_installed, parser_name) then
            -- Install parser
            vim.notify("Installing parser for " .. parser_name, vim.log.levels.INFO)
            require('nvim-treesitter').install({ parser_name }):await(start_ts)
            return
          end

          start_ts()
        end,
      })
    end,
  }
}
