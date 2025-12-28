-- TreeSitter configuration
return {
  src = 'https://github.com/nvim-treesitter/nvim-treesitter',
  version = 'main',
  data = {
    setup = function()
      local languages = {
        'css', 'dockerfile', 'elixir', 'erlang', 'fish', 'html', 'http', 'javascript',
        'json', 'lua', 'php', 'python', 'regex', 'ruby', 'rust', 'scss', 'svelte',
        'typescript', 'vue', 'yaml', 'markdown', 'bash', 'c', 'cmake', 'comment',
        'cpp', 'dart', 'go', 'jsdoc', 'json5', 'jsonc', 'llvm', 'make', 'ninja',
        'prisma', 'proto', 'pug', 'swift', 'todotxt', 'toml', 'tsx', 'vim', 'vimdoc',
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
        pattern = languages,
        callback = function(event)
          local bufnr = event.buf
          local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })

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
          local parser_configs = require("nvim-treesitter.parsers")
          if not parser_configs[parser_name] then
            return -- Parser not available, skip silently
          end

          local parser_exists = pcall(vim.treesitter.get_parser, bufnr, parser_name)

          if not parser_exists then
            -- check if parser is already installed
            if vim.tbl_contains(already_installed, parser_name) then
              vim.notify("Parser for " .. parser_name .. " already installed.", vim.log.levels.INFO)
            else
              -- If not installed, install parser synchronously
              vim.notify("Installing parser for " .. parser_name, vim.log.levels.INFO)
              treesitter.install({ parser_name }):wait(90000) -- wait max. 1.5 minutes
            end
          end

          -- Start treesitter for this buffer
          -- vim.notify(vim.inspect("Starting treesitter parser " .. parser_name .. " for filetype: " .. filetype), vim.log.levels.WARN)
          vim.treesitter.start(bufnr, parser_name)
          vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
          vim.wo.foldmethod = 'expr'
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  }
}
