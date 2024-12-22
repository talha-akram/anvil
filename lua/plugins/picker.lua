local picker = require('mini.pick')
local builtin = picker.builtin
local registry = picker.registry
local map = vim.keymap.set

local set_keymap = function(lhs, rhs, mode)
  map(mode or 'n', lhs, rhs, { noremap = true })
end


picker.setup({
  delay = {
    async = 10,
    busy = 30,
  },

  mappings = {
    caret_left        = '<Left>',
    caret_right       = '<Right>',

    choose            = '<CR>',
    choose_in_split   = '<C-s>',
    choose_in_tabpage = '<C-t>',
    choose_in_vsplit  = '<C-v>',
    choose_marked     = '<A-CR>',

    delete_char       = '<BS>',
    delete_char_right = '<S-BS>',
    delete_left       = '<A-BS>',
    delete_word       = '<C-w>',

    mark              = '<C-x>',
    mark_all          = '<C-a>',

    move_start        = '<C-g>',
    move_down         = '<C-n>',
    move_up           = '<C-p>',

    paste             = '<C-p>',

    refine            = '<C-Space>',
    refine_marked     = '<M-Space>',

    scroll_up         = '<C-u>',
    scroll_down       = '<C-d>',
    scroll_left       = '<C-h>',
    scroll_right      = '<C-l>',

    stop              = '<Esc>',

    toggle_info     = '<S-Tab>',
    toggle_preview  = '<Tab>',

    -- smart_send_to_loclist = {
    --   char = '<A-l>',
    --   func = function() 'smart_send_to_loclist' end,
    -- },
    -- smart_send_to_loclist = {
    --   char = '<A-q>',
    --   func = function() 'smart_send_to_loclist' end,
    -- },
  },

  options = {
    content_from_bottom = false,
    use_cache = false,
  },

  source = {
    items = nil,
    name  = nil,
    cwd   = nil,

    match   = nil,
    preview = nil,
    show    = function(buf_id, items, query, opts)
      picker.default_show(
        buf_id,
        items,
        query,
        vim.tbl_deep_extend('force', { show_icons = false, icons = {} }, opts or {})
      )
    end,

    choose        = nil,
    choose_marked = nil,
  },

  -- Window related options
  window = {
    config = function()
      local width = vim.o.columns
      local height = vim.o.lines

      local win_width = math.floor(width * 0.5)
      local win_height = math.floor(height * 0.3)

      local col = math.floor((width - win_width) / 2)
      -- center prompt: height * (50% + 30%)
      -- center window: height * [50% + (30% / 2)]
      local bottom_edge = math.floor(height * 0.65)

      return {
        width = win_width,
        height = win_height,
        col = col,
        row = bottom_edge,
        style = 'minimal',
        border = 'single',
      }
    end,

    -- String to use as cursor in prompt
    prompt_cursor = '▏',

    -- String to use as prefix in prompt
    prompt_prefix = ' ',
  },
})

registry.registry = function()
  local items = vim.tbl_keys(MiniPick.registry)
  table.sort(items)
  local source = {items = items, name = 'Registry', choose = function() end}
  local chosen_picker_name = MiniPick.start({ source = source })
  if chosen_picker_name == nil then return end
  return MiniPick.registry[chosen_picker_name]()
end

registry.git_status = function()
  local selection = picker.builtin.cli({
    command = {
      'git', 'status', '-s'
    }
  }, {
    source = {
      name = 'Git Status',
      preview = function(bufnr, item)
        local file = vim.trim(item):match('%s+(.+)')
        -- get diff and show
        local append_data = function(_, data)
          if data then
            vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, data)
            vim.api.nvim_buf_set_option(bufnr, 'filetype', 'diff')
            vim.api.nvim_buf_set_option(bufnr, 'modifiable', false)
          end
        end

        vim.fn.jobstart({'git','diff', file}, {
          stdout_buffered = true,
          on_stdout = append_data,
          on_stderr = append_data,
        })
      end
    }
  })

  if selection then
    vim.cmd.edit(vim.trim(selection):match('%s+(.+)'))
  end
end

registry.find = function()
  local register = vim.fn.getreg('"')
  local cursor = vim.api.nvim_win_get_cursor(0)
  local view = vim.fn.winsaveview()

  vim.cmd([[normal! "xy]])

  vim.fn.setreg('"', register)
  vim.fn.winrestview(view)
  vim.api.nvim_win_set_cursor(0, cursor)

  local selection = vim.fn.getreg('"')
  builtin.grep({ pattern = selection })
end

registry.all_files = function()
  picker.builtin.cli({
    command = {
      'fd',
      '--type',
      'f',
      '--no-ignore',
      '--hidden',
      '--follow',
      '--exclude',
      '.git',
      '--exclude',
      'node_modules'
    }
  })
end

registry.quickfix = function()
  picker.start({
    source = {
      items = vim.fn.getqflist(),
      name = 'Quickfix List'
    }
  })
end

registry.loclist = function()
  picker.start({
    source = {
      items = vim.fn.getloclist(0),
      name = 'Location List'
    }
  })
end

set_keymap('<F1>',      builtin.help)
set_keymap('<leader>,', builtin.resume)
set_keymap('<leader>o', builtin.files)
set_keymap('<leader>b', builtin.buffers)
set_keymap('<leader>f', builtin.grep_live)
set_keymap('<leader>f', registry.find, 'v')
set_keymap('<leader>F', registry.all_files)
set_keymap('<leader>g', registry.git_status)
set_keymap('<leader>p', registry.registry)
set_keymap('<leader>q', registry.quickfix)
set_keymap('<leader>l', registry.loclist)
