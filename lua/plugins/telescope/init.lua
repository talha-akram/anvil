-- Telescope configuration
local map = vim.keymap.set
local highlight = vim.api.nvim_set_hl
local telescope = require('telescope')
local telescope_builtin = require('telescope.builtin')
local use_layout = require('plugins.telescope.layouts')

highlight(0, 'FloatBorder', { link='WinSeparator' })
highlight(0, 'TelescopePromptCounter', { link='TelescopeNormal' })
highlight(0, 'TelescopeSelection', { link='TelescopePromptPrefix' })

telescope.setup({
  defaults = {
    border = true,
    prompt_title = false,
    results_title = false,
    color_devicons = false,
    layout_strategy = 'horizontal',
    borderchars = {
      prompt  = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
      results = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
      preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
    },
    layout_config = {
      bottom_pane = {
        height = 20,
        preview_cutoff = 120,
        prompt_position = 'top'
      },
      center = {
        height = 0.4,
        preview_cutoff = 40,
        prompt_position = 'top',
        width = 0.7
      },
      horizontal = {
        prompt_position = 'top',
        preview_cutoff = 40,
        height = 0.9,
        width = 0.8
      }
    },
    sorting_strategy = 'ascending',
    prompt_prefix = ' ',
    selection_caret = ' → ',
    entry_prefix = '   ',
    file_ignore_patterns = {'node_modules', 'build'},
    path_display = { 'truncate' },
    results_title = false,
    prompt_title =false,
    preview = {
      treesitter = {
        enable = {
          'css', 'dockerfile', 'elixir', 'erlang', 'fish',
          'html', 'http', 'javascript', 'json', 'lua', 'php',
          'python', 'regex', 'ruby', 'rust', 'scss', 'svelte',
          'typescript', 'vue', 'yaml', 'markdown', 'bash', 'c',
          'cmake', 'comment', 'cpp', 'dart', 'go', 'jsdoc',
          'json5', 'jsonc', 'llvm', 'make', 'ninja', 'prisma',
          'proto', 'pug', 'swift', 'todotxt', 'toml', 'tsx',
        }
      }
    },
    mappings = {
      i = {
        ['<esc>'] = require('telescope.actions').close,
        ['<C-l>'] = require('telescope.actions').smart_send_to_loclist,
        ['<C-q>'] = require('telescope.actions').smart_send_to_qflist,
        ['<C-p>'] = require('telescope.actions.layout').toggle_preview,
      },
    }
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = 'smart_case',        -- options: 'ignore_case', 'respect_case'
    }
  }
})

telescope.load_extension('fzf')
telescope.load_extension('dap')

local set_keymap = function(lhs, rhs, mode)
  map(mode or 'n', lhs, rhs, { noremap = true })
end

set_keymap('<F1>',      use_layout(telescope_builtin.help_tags,   'popup_extended'))
set_keymap('<leader>q', use_layout(telescope_builtin.quickfix,    'ivy_plus'))
set_keymap('<leader>l', use_layout(telescope_builtin.loclist,     'ivy_plus'))
set_keymap('<leader>t', use_layout(telescope_builtin.builtin,     'popup_list'))
set_keymap('<leader>o', use_layout(telescope_builtin.find_files,  'popup_list'))
set_keymap('<leader>p', use_layout(telescope_builtin.commands,    'command_pane'))
set_keymap('<leader>b', use_layout(telescope_builtin.buffers,     'popup_extended'))
set_keymap('<leader>g', use_layout(telescope_builtin.git_status,  'popup_extended'))
set_keymap('<leader>f', use_layout(telescope_builtin.grep_string, 'popup_extended'), 'v')
set_keymap('<leader>f', use_layout(telescope.extensions.live_grep_args.live_grep_args,  'popup_extended'))

local dap = telescope.extensions.dap
set_keymap('<leader>d',  use_layout(dap.commands,         'popup_list'))
set_keymap('<leader>dc', use_layout(dap.configurations,   'popup_list'))
set_keymap('<leader>db', use_layout(dap.list_breakpoints, 'popup_list'))
set_keymap('<leader>dv', use_layout(dap.variables,        'popup_list'))
set_keymap('<leader>df', use_layout(dap.frames,           'popup_list'))

return use_layout;
