local picker = require('mini.pick')
local builtin = picker.builtin
local registry = picker.registry
local map = vim.keymap.set
local highlight = vim.api.nvim_set_hl

-- Use mini.pick as the default picker
vim.ui.select = picker.ui_select

highlight(0, 'MiniPickBorder',        { link='Pmenu' })
highlight(0, 'MiniPickBorderBusy',    { link='Pmenu' })
highlight(0, 'MiniPickBorderText',    { link='Pmenu' })
highlight(0, 'MiniPickIconDirectory', { link='Pmenu' })
highlight(0, 'MiniPickIconFile',      { link='Pmenu' })
highlight(0, 'MiniPickNormal',        { link='Pmenu' })
highlight(0, 'MiniPickHeader',        { link='Title' })
highlight(0, 'MiniPickMatchCurrent',  { link='PmenuThumb' })
highlight(0, 'MiniPickMatchMarked',   { link='FloatTitle' })
highlight(0, 'MiniPickMatchRanges',   { link='Title' })
highlight(0, 'MiniPickPreviewLine',   { link='PmenuThumb' })
highlight(0, 'MiniPickPreviewRegion', { link='PmenuThumb' })
highlight(0, 'MiniPickPrompt',        { link='Pmenu' })

local set_keymap = function(lhs, rhs, mode)
  map(mode or 'n', lhs, rhs, { noremap = true })
end

local parsed_matches = function()
  local list = {}
  local matches = picker.get_picker_matches().all

  for _, match in ipairs(matches) do
    if type(match) == 'table' then
      table.insert(list, match)
    else
      local path, lnum, col, search = string.match(match, '(.-)%z(%d+)%z(%d+)%z%s*(.+)')
      local text = path and string.format('%s [%s:%s]  %s', path, lnum, col, search)
      local filename =  path or vim.trim(match):match('%s+(.+)')

      table.insert(list, {
        filename = filename or match,
        lnum = lnum or 1,
        col = col or 1,
        text = text or match,
      })
    end
  end

  return list
end

registry.registry = function()
  local selected = picker.start({
    source = { items = vim.tbl_keys(picker.registry), name = 'Registry' }
  })

  if selected == nil then return end

  return picker.registry[selected]()
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

        vim.fn.jobstart({'git','diff', 'HEAD', file}, {
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

  local selection = vim.fn.getreg('"')

  vim.fn.setreg('"', register)
  vim.fn.winrestview(view)
  vim.api.nvim_win_set_cursor(0, cursor)

  builtin.grep(
    { pattern = selection },
    { source = { name = string.format('Grep "%s"', selection) } }
  )
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
      'node_modules',
      '--exclude',
      'build',
      '--exclude',
      'tmp',
    }
  }, {
    source = {
      name = 'All Files',
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
    choose_marked     = '<C-CR>',

    delete_char       = '<BS>',
    delete_char_right = '<S-BS>',
    delete_left       = '<A-BS>',
    delete_word       = '<C-w>',

    mark              = '<C-x>',
    mark_all          = '<C-a>',

    move_start        = '<C-g>',
    move_down         = '<C-n>',
    move_up           = '<C-p>',

    paste             = '<A-p>',

    refine            = '<C-Space>',
    refine_marked     = '<M-Space>',

    scroll_up         = '<C-u>',
    scroll_down       = '<C-d>',
    scroll_left       = '<C-h>',
    scroll_right      = '<C-l>',

    stop              = '<Esc>',

    toggle_info       = '<S-Tab>',
    toggle_preview    = '<Tab>',

    send_to_qflist    = {
      char = '<C-q>',
      func = function()
        vim.fn.setqflist(parsed_matches(), 'r')
      end,
    },
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
      local height, width, starts, ends
      local win_width = vim.o.columns
      local win_height = vim.o.lines

      if win_height <= 25 then
        height = math.min(win_height, 18)
        width = win_width
        starts = 1
        ends = win_height
      else
        width = math.floor(win_width * 0.5) -- 50%
        height = math.floor(win_height * 0.3) -- 30%
        starts = math.floor((win_width - width) / 2)
        -- center prompt: height * (50% + 30%)
        -- center window: height * [50% + (30% / 2)]
        ends = math.floor(win_height * 0.65)
      end

      return {
        col = starts,
        row = ends,
        height = height,
        width = width,
        style = 'minimal',
        border = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
      }
    end,

    -- String to use as cursor in prompt
    prompt_cursor = '|',

    -- String to use as prefix in prompt
    prompt_prefix = '',
  },
})
