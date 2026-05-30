-- TreeSitter configuration

local function build_coffeescript_parser(force)
  -- Install alongside the parsers nvim-treesitter manages.
  local parser_dir = vim.fn.stdpath('data') .. '/site/parser'
  local out = parser_dir .. '/coffeescript.so'

  if not force and vim.uv.fs_stat(out) then return end
  if vim.fn.executable('git') == 0 or vim.fn.executable('cc') == 0 then
    vim.notify('coffeescript grammar: git and cc are required to build', vim.log.levels.WARN)
    return
  end

  vim.fn.mkdir(parser_dir, 'p')

  local repo = 'https://github.com/svkozak/tree-sitter-coffeescript'
  local src = vim.fn.tempname()
  vim.notify('Building coffeescript treesitter parser...', vim.log.levels.INFO)

  vim.system({ 'git', 'clone', '--depth', '1', repo, src }, {}, function(clone)
    if clone.code ~= 0 then
      vim.schedule(function()
        vim.notify('coffeescript grammar clone failed: ' .. (clone.stderr or ''), vim.log.levels.ERROR)
      end)
      return
    end

    local compile = {
      'cc', '-o', out, '-shared', '-Os', '-fPIC',
      '-I' .. src .. '/src', src .. '/src/parser.c', src .. '/src/scanner.c',
    }
    vim.system(compile, {}, function(cc)
      vim.schedule(function()
        vim.fn.delete(src, 'rf')
        if cc.code == 0 then
          vim.notify('coffeescript parser built (restart or :e to apply)', vim.log.levels.INFO)
        else
          vim.notify('coffeescript grammar compile failed: ' .. (cc.stderr or ''), vim.log.levels.ERROR)
        end
      end)
    end)
  end)
end

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

      vim.api.nvim_create_user_command('TSCoffeeScriptBuild', function()
        build_coffeescript_parser(true)
      end, { desc = 'Rebuild the CoffeeScript treesitter parser' })

      -- Build once if the parser is not present yet.
      build_coffeescript_parser(false)

      vim.api.nvim_create_autocmd('FileType', {
        desc = "Enable Treesitter",
        group = vim.api.nvim_create_augroup("enable_treesitter", {}),
        callback = function(event)
          local bufnr = event.buf
          local filetype = vim.bo[bufnr].filetype

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

          -- Start available parsers
          local start_ts = function()
            vim.treesitter.start(bufnr, parser_name)
            vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
            vim.wo.foldmethod = 'expr'
            vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end

          -- Try to start an available parser
          local ok, available = pcall(vim.treesitter.language.add, parser_name)
          if ok and available then
            start_ts()
            return
          end

          -- Install from available parsers if not already installed.
          local ts_config = require('nvim-treesitter.config')
          if not vim.tbl_contains(ts_config.get_available(), parser_name) then
            vim.bo[bufnr].syntax = "ON"
            return
          end
          vim.notify("Installing parser for " .. parser_name, vim.log.levels.INFO)
          require('nvim-treesitter').install({ parser_name }):await(start_ts)
        end,
      })
    end,
  }
}
