-- Statusline
-- inspiration: https://elianiva.my.id/post/neovim-lua-statusline

-- aliases
local fn = vim.fn
local api = vim.api
local listed = fn.buflisted
local create_highlight = api.nvim_set_hl
local severity = vim.diagnostic.severity
local get_diagnostics = vim.diagnostic.get
local augroup = api.nvim_create_augroup
local autocmd = api.nvim_create_autocmd
local hl_by_name = api.nvim_get_hl_by_name

-- defaults
local M = {}
local palette = {}
local colors = {
  Error = 'DiagnosticSignError',    -- Number of error messsages
  Warn = 'DiagnosticSignWarn',      -- Number of warning messages
  Info = 'DiagnosticSignInfo',      -- Number of information messages
  Hint = 'DiagnosticSignHint',      -- Number of hint messages
  Normal = 'Character',             -- Normal mode
  Insert = 'Question',              -- Insert mode
  Select = 'Number',                -- Visual mode and selection mode (gh etc.)
  Replace = 'Label',                -- Replace mode
  Progress = 'Macro',               -- File name and progress
  Fileinfo = 'Normal',              -- file encoding and attached language server status
  Inactive = 'Conceal'              -- Inactive buffersa and windows
}

-- helper for safely creating a highlight group
local highlight = function(group_name, group)
  if group == nil or group_name == nil then
    return
  end

  pcall(create_highlight, 0, group_name, group)
end


-- Retrieve color value of [kind] from highlight group
---@param hl_name name of highlight group
---@param kind type of value to extract (either `background` or `foreground`)
local get_color = function(hl_name, kind, default)
  local rgb = hl_by_name(hl_name, true)[kind]
  local cterm = hl_by_name(hl_name, false)[kind] or 'Grey'
  local hex = (rgb and bit.tohex(rgb, 6) or default:sub(2))
  return { gui = string.format('#%s', hex), cterm = cterm }
end

-- define highlight groups and build palette from active colorscheme colors
M.build_palette = function()
  local bg      = get_color('StatusLine', 'background', '#ffffff')

  for color, highlight_group in pairs(colors) do
    local group_name = 'StatusLine' .. color
    local found, fg = pcall(get_color, highlight_group, 'foreground', '#666666')
    if found then
      local group = setmetatable(
        { ctermfg = fg.cterm, ctermbg = bg.cterm, fg = fg.gui, bg = bg.gui },
        { __tostring = function() return group_name end }
      )
      palette[color] = group
      highlight(group_name, group)
    end
  end

  -- default highlight for the statusline
  highlight('StatusLine', palette.Normal)
  -- configure highlight for wild menu (command mode completions)
  highlight('WildMenu', palette.Progress)

  return palette
end

-- This will create required highlight groups
M:build_palette()

-- Map accent color for statusline based on active mode
local color_map = setmetatable({
  ['n']    = palette.Normal,  -- Normal
  ['no']   = palette.Normal,  -- Operator pending
  ['v']    = palette.Select,  -- Select by character (v)
  ['V']    = palette.Select,  -- Select by line (V)
  ['\022'] = palette.Select,  -- Select block wise (CTRL-V)
  ['s']    = palette.Select,  -- Select by character (gh)
  ['S']    = palette.Select,  -- Select by line (gH)
  ['\019'] = palette.Select,  -- Select block wise (g CTRL-H)
  ['i']    = palette.Info,    -- Insert
  ['ic']   = palette.Info,    -- Insert completion (generic)
  ['ix']   = palette.Info,    -- Insert completion (CTRL-X)
  ['R']    = palette.Replace, -- Replace
  ['Rc']   = palette.Replace, -- Replace completion
  ['Rv']   = palette.Replace, -- Replace virtual
  ['c']    = palette.Warn,    -- Command-line
  ['cv']   = palette.Warn,    -- Execute (gQ)
  ['ce']   = palette.Warn,    -- Execute (Q)
  ['r']    = palette.Warn,    -- Prompt for enter
  ['rm']   = palette.Warn,    -- Read more (-- more -- prompt)
  ['r?']   = palette.Warn,    -- Prompt yes/no (confirmation prompt)
  ['!']    = palette.Error,   -- Shell execution
  ['t']    = palette.Error,   -- Terminal mode (insert)
  ['nt']   = palette.Insert,   -- Terminal mode (normal)
}, {
  __index  = function(_, idx)
    return palette.Insert      -- Catch any undefined modes
  end
})

-- Map symbols/text to be used as an identifier for currently active mode
M.mode_map = setmetatable({
  ['n']    = 'N',             -- Normal
  ['no']   = 'N-P',           -- Operator pending
  ['v']    = 'V',             -- Select by character
  ['V']    = 'V-L',           -- Select by line
  ['\022'] = 'V-B',           -- Select block wise, does not work cannot map symbol (^V)
  ['s']    = 'S',             -- Select by character (gh)
  ['S']    = 'S-L',           -- Select by line (gH)
  ['\019'] = 'S-B',           -- Select block wise (g CTRL-H), does not work cannot map symbol (^S)
  ['i']    = 'I',             -- Insert
  ['ic']   = 'I~',            -- Insert completion (generic)
  ['ix']   = 'I~',            -- Insert completion (CTRL-X)
  ['R']    = 'R',             -- Replace
  ['Rc']   = 'R~',            -- Replace completion
  ['Rv']   = 'R-V',           -- Replace virtual
  ['c']    = 'C',             -- Command-line
  ['cv']   = 'C!',            -- Execute (gQ)
  ['ce']   = 'C!',            -- Execute (Q)
  ['r']    = 'P',             -- Prompt for enter
  ['rm']   = 'P!',            -- Read more (-- more -- prompt)
  ['r?']   = 'P?',            -- Prompt yes/no (confirmation prompt)
  ['!']    = 'S',             -- Shell execution
  ['t']    = 'I-T',           -- Terminal mode (insert)
  ['nt']   = 'N-T',           -- Terminal mode (normal)
}, {
  __index  = function(_, mode)
    -- Catch any undefined modes
    return string.format('? (%s)', mode)
  end,
})

-- LSP provided diagnostic error message count
---@param format lua format string with one `%s` indicating where count's value will be substituted
---@param severity any value form vim.diagnostic.severity table
local format_diagnostics = function(format, severity)
  local count = #(get_diagnostics(0, { severity = severity }))
  return count == 0 and '' or string.format(format, count)
end

-- Language server status and progress messages
M.get_lsp_status = function()
  local clients = vim.lsp.buf_get_clients()
  if (#clients > 0) then
    local client_status = {}

    for _, client in pairs(clients) do
      local messages = {}
      for _token, message in pairs(client.messages.progress) do
        if message.done then
          messages = {}
          break
        elseif message.percentage then
          table.insert(messages, string.format('%s %s', message.title, message.message))
        end
      end
      if #messages > 0 then
        table.insert(client_status, string.format('%s[%s]', client.config.name, messages[1]))
      else
        table.insert(client_status, client.config.name)
      end
    end

    return string.format(' {%s} ', table.concat(client_status, ' '))
  end

  return ''
end

-- Returns symbolic identifier for current mode
M.get_current_mode = function(self)
  local current_mode = api.nvim_get_mode().mode
  return string.format(' %s ', self.mode_map[current_mode])
end

-- File name with read-only marker or identifier for unsaved changes
M.get_file_state = function()
  local name = vim.bo.filetype == 'help' and fn.expand('%:t') or fn.expand('%')
  local file_name = (name == '' and '[no name]' or name)
  local read_only = "%{&readonly?' -':''}"
  local modified = "%{&modified?' +':''}"
  return string.format('%s%s%s ', file_name, modified, read_only)
end

-- File's type as identified by neovim.
M.get_file_type = function()
  local file_type = vim.bo.filetype

  return file_type == ''
    and ' [no ft] '
    or string.format('  %s', file_type)
end

-- File line ending format Unix / Windows
M.get_file_format = function()
  return string.format('%s ', vim.o.fileformat)
end

-- Character encoding of current file
M.get_file_encoding = function()
  return string.format('%s ', vim.o.encoding)
end

-- Indentation settings for current file
M.get_file_indentation = function(self)
  local indentation = 'tabs'
  local characters = vim.o.tabstop
  local on_click = '%@v:lua.StatusLine.select_indentation@'

  if vim.o.expandtab then
    indentation = 'spaces'
    characters = vim.o.shiftwidth
  end

  return string.format(' %s%s:%d%s ', on_click, indentation, characters, '%X')
end

-- Interactively switch indentation settings, onclick action of file indentation component
M.select_indentation = function()
  vim.ui.select({'tabs', 'spaces'}, {
    prompt = 'Select character to be used for indentation:',
    format_item = function(item)
      return 'Indent using '.. item
    end,
  }, function(choice)
    if choice == nil then return end

    if choice == 'spaces' then
      vim.o.expandtab = true
    else
      vim.o.expandtab = false
    end

    local width = tonumber(fn.input('Enter number of characters per indentation level: '))

    if width then
      vim.o.shiftwidth = width
      vim.o.tabstop = width
    end
   end)
end

-- Apply color to a statusline component using a highlight group
M.highlight = function(self, group)
  return string.format('%%#%s#', group)
end

-- List buffer numbers across the statusline as a substitute for tabs
M.get_buffers = function()
  local buffers = api.nvim_list_bufs()
  local current = api.nvim_get_current_buf()
  local prev_bufs = {}
  local next_bufs = {}


  for _, buf in ipairs(buffers) do
    if listed(buf) == 1 then
      -- local buffer = string.format('%s(0, %s)@ %s %s', '%@nvim_win_set_buf', buf, buf, '%X')
      local buffer = string.format('%%%s%s %s', buf, '@v:lua.StatusLine.switch_buffer@', buf, '%X')
      if buf < current then
        table.insert(prev_bufs, buffer)
      elseif buf > current then
        table.insert(next_bufs, buffer)
      end
    end
  end

  return {
    prev_bufs = table.concat(prev_bufs),
    current = string.format('%%%s%s %s', current, '@v:lua.StatusLine.switch_buffer@', current, '%X'),
    next_bufs = table.concat(next_bufs),
  }
end

M.switch_buffer = function(buf)
  vim.api.nvim_win_set_buf(0, buf)
end

M.extract_colors = function(self, highlights)
  colors = highlights
  self:build_palette()
end

M.selection = function()
  if vim.fn.mode():find("[Vv]") == nil then return "" end

  local starts = vim.fn.line('v')
  local ends = vim.fn.line('.')
  local count = starts <= ends and ends - starts + 1 or starts - ends + 1
  local wc = vim.fn.wordcount()
  return string.format(' (L %s, C %s)', count, wc['visual_chars'])
end

-- Statusline to be displayed on active windows
M.set_active = function(self)
  local mode = api.nvim_get_mode().mode
  local accent_color = self:highlight(color_map[mode])
  local buffers = self:get_buffers()

  return table.concat({
    accent_color,
    self:get_current_mode(),
    self:highlight(palette.Progress),
    self:get_file_state(),
    self:highlight(palette.Error),
    format_diagnostics(' E:%s', severity.ERROR),
    self:highlight(palette.Warn),
    format_diagnostics(' W:%s', severity.WARN),
    self:highlight(palette.Info),
    format_diagnostics(' I:%s', severity.INFO),
    self:highlight(palette.Hint),
    format_diagnostics(' H:%s', severity.HINT),
    self:highlight(palette.Fileinfo),
    self:get_lsp_status(),
    '%=',                                               -- left / right separator
    '%<',                                               -- Collapse point for smaller screen sizes
    accent_color,
    ' %l:%c',                                          -- position of cursor
    self:highlight(palette.Fileinfo),
    self:selection(),
    self:get_file_indentation(),
    self:get_file_encoding(),
    self:get_file_format(),
    self:highlight(palette.Inactive),
    buffers.prev_bufs,
    accent_color,
    buffers.current,
    self:highlight(palette.Inactive),
    buffers.next_bufs,
    accent_color,
    self:get_file_type(),
    self:highlight(palette.Progress),
    ' --%1p%%-- ',                                      -- Place in file as a percentage
  })
end

-- Statusline to be displayed on inactive windows
M.set_inactive = function(self)
  return table.concat({
    self:highlight(palette.Inactive),
    self:get_file_state(),
    '%=',                                               -- left / right separator
    ' --%1p%%-- ',                                      -- Place in file as a percentage
    ' %l:%c ',                                          -- position of cursor
  })
end

-- Make statusline callable
StatusLine = setmetatable(M, {
  __call = function(self, mode)
    return self['set_' .. mode](self)
  end,
})

local statusline = augroup('StatusLine', { clear = true })
-- Rebuild statusline pallet on colorscheme change event
autocmd('ColorScheme', {
  desc = 'rebuild statusline color pallet and highlight groups',
  callback = StatusLine.build_palette,
  group = statusline
})


-- Enable StatusLine
-- Setup autocmds to switch between active and inactive variants when
-- not using a global status line
if vim.o.laststatus ~= 3 then
  -- Set statusline to active variant for focused buffer
  autocmd({ 'WinEnter', 'BufEnter' }, {
    desc = 'show active statusline with details',
    callback = function() vim.wo.statusline = '%!v:lua.StatusLine("active")' end,
    group = statusline
  })
  -- Set statusline to inactive variant for buffers without focus
  autocmd({ 'WinLeave', 'BufLeave' }, {
    desc = 'show muted statusline without additional details',
    callback = function() vim.wo.statusline = '%!v:lua.StatusLine("inactive")' end,
    group = statusline
  })
else
  -- Use active varient for global statusline
  vim.o.statusline = '%!v:lua.StatusLine("active")'
end

