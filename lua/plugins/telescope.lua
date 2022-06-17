-- Telescope configuration
local telescope = require('telescope')
local telescope_builtin = require('telescope.builtin')
local set_keymap = function(lhs, rhs)
  vim.keymap.set('n', lhs, rhs, { noremap = true })
end

telescope.setup({
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = 'smart_case',        -- other options: 'ignore_case' or 'respect_case'
    }
  }
})

telescope.load_extension('fzf')
-- telescope.load_extension('dap')

set_keymap('<leader>o', telescope_builtin.find_files)
set_keymap('<leader>b', telescope_builtin.buffers)
set_keymap('<leader>p', telescope_builtin.commands)
set_keymap('<leader>q', telescope_builtin.quickfix)
set_keymap('<leader>g', telescope_builtin.git_status)
set_keymap('<leader>l', telescope_builtin.loclist)
set_keymap('<F1>',      telescope_builtin.help_tags)

set_keymap('<leader>f', telescope.extensions.live_grep_args.live_grep_args)

set_keymap('<leader>do', telescope.extensions.dap.commands)
set_keymap('<leader>dc', telescope.extensions.dap.configurations)
set_keymap('<leader>db', telescope.extensions.dap.list_breakpoints)
set_keymap('<leader>dv', telescope.extensions.dap.variables)
set_keymap('<leader>df', telescope.extensions.dap.frames)
