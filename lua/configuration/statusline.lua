-- Statusline configuration
-- inspiration: https://elianiva.my.id/post/neovim-lua-statusline

local base = {}
local fn = vim.fn
local api = vim.api
local vim_cmd = vim.cmd
local listed = fn.buflisted
local get_count = vim.lsp.diagnostic.get_count

-- TODO: replace with API calls, when available
---@param group_name name of highlight group
---@param group_colours map of highlight settings (type to colour values)
local create_highlight = function(group_name, group_colours)
  local options = {}
  -- build array of all group highlight settings
  for k, v in pairs(group_colours) do
    table.insert(options, string.format('%s=%s', k, v))
  end
  vim_cmd(string.format('highlight %s %s', group_name, table.concat(options, " ")))
end

-- TODO: build palette from active colorscheme colours
-- colour palette for Statusline
-- Normal -> fg, Disabled -> Grey, Highlight -> Cyan, Orange -> DarkYellow
local palette = {
  Normal   = { ctermfg = 223, ctermbg = 235, guifg = '#ddc7a1', guibg = '#292C33' },
  Disabled = { ctermfg = 241, ctermbg = 235, guifg = '#5c6370', guibg = '#292C33' },
  Red      = { ctermfg = 167, ctermbg = 235, guifg = '#ea6962', guibg = '#292C33' },
  Orange   = { ctermfg = 208, ctermbg = 235, guifg = '#e78a4e', guibg = '#292C33' },
  Yellow   = { ctermfg = 214, ctermbg = 235, guifg = '#d8a657', guibg = '#292C33' },
  Green    = { ctermfg = 142, ctermbg = 235, guifg = '#a9b665', guibg = '#292C33' },
  Cyan     = { ctermfg = 108, ctermbg = 235, guifg = '#89b482', guibg = '#292C33' },
  Blue     = { ctermfg = 109, ctermbg = 235, guifg = '#7daea3', guibg = '#292C33' },
  Megenta  = { ctermfg = 175, ctermbg = 235, guifg = '#d3869b', guibg = '#292C33' },
}

-- Map accent color for statusline based on active mode
local colour_map = setmetatable({
  ['n']    = palette.Green,   -- Normal
  ['no']   = palette.Green,   -- Operator pending
  ['v']    = palette.Megenta, -- Visual by character (v)
  ['V']    = palette.Megenta, -- Visual by line (V)
  ['\022'] = palette.Megenta, -- Visual block wise (CTRL-V)
  ['s']    = palette.Megenta, -- Select by character (gh)
  ['S']    = palette.Megenta, -- Select by line (gH)
  ['\019'] = palette.Megenta, -- Select block wise (g CTRL-H)
  ['i']    = palette.Blue,    -- Insert
  ['ic']   = palette.Blue,    -- Insert completion (generic)
  ['ix']   = palette.Blue,    -- Insert completion (CTRL-X)
  ['R']    = palette.Orange,  -- Replace
  ['Rc']   = palette.Orange,  -- Replace completion
  ['Rv']   = palette.Orange,  -- Replace virtual
  ['c']    = palette.Yellow,  -- Command-line
  ['cv']   = palette.Yellow,  -- Execute (gQ)
  ['ce']   = palette.Yellow,  -- Execute (Q)
  ['r']    = palette.Yellow,  -- Prompt for enter
  ['rm']   = palette.Yellow,  -- Read more (-- more -- prompt)
  ['r?']   = palette.Yellow,  -- Prompt yes/no (confirmation prompt)
  ['!']    = palette.Red,     -- Shell execution
  ['t']    = palette.Red,     -- Terminal mode
}, {
  __index  = function(_, idx)
    return palette.Green      -- Catch any undefined modes
  end
})

-- Map symbols/text to be used as an identifier for currently active mode
base.mode_map = setmetatable({
  ['n']    = 'N',             -- Normal
  ['no']   = 'N-P',           -- Operator pending
  ['v']    = 'V',             -- Visual by character
  ['V']    = 'V-L',           -- Visual by line
  ['\022'] = 'V-B',           -- Visual block wise, does not work cannot map symbol (^V)
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
  ['t']    = 'T',             -- Terminal mode
}, {
  __index  = function(_, mode)
    -- Catch any undefined modes
    return string.format('? (%s)', mode)
  end,
})

-- LSP provided diagnostic error message count
base.format_errors = function()
  local count = get_count(0, 'Error')
  return count == 0 and '' or string.format(' E:%s ', count)
end

-- LSP provided diagnostic warning message count
base.format_warnings = function()
  local count = get_count(0, 'Warning')
  return count == 0 and '' or string.format(' W:%s ', count)
end

-- LSP provided diagnostic information message count
base.format_info = function()
  local count = get_count(0, 'Information')
  return count == 0 and '' or string.format(' I:%s ', count)
end

-- LSP provided diagnostic hints count
base.format_hints = function()
  local count = get_count(0, 'Hint')
  return count == 0 and '' or string.format(' H:%s ', count)
end

-- Language server status and progress messages
base.get_lsp_status = function()
  local clients = vim.lsp.buf_get_clients()
  if (#clients > 0) then
    local client_names = {}

    for _, client in pairs(clients) do
      table.insert(client_names, client.config.name)
    end

    return string.format('● (%s) ', table.concat(client_names, ' '))
  end

  return "◯ "
end

-- Returns symbolic identifier for current mode
base.get_current_mode = function(self)
  local current_mode = api.nvim_get_mode().mode
  return string.format(' %s ', self.mode_map[current_mode])
end

-- File name with read-only marker or identifier for unsaved changes
base.get_file_state = function()
  local name = fn.expand('%:t')
  local file_name = (name == '' and '[no name]' or name)
  local read_only = "%{&readonly?' -':''}"
  local modified = "%{&modified?' +':''}"
  return string.format(' %s%s%s ', file_name, modified, read_only)
end

-- File's type as identified by neovim.
base.get_file_type = function()
  local file_type = vim.bo.filetype:lower()

  return file_type == ''
    and ' [no ft] '
    or string.format(' %s ', file_type)
end

-- File line ending format Unix / Windows
base.get_file_format = function()
  return string.format('%s ', vim.o.fileformat)
end

-- Character encoding of current file
base.get_file_encoding = function()
  return string.format('%s ', vim.o.encoding)
end

-- Accent colour to be applied to statusline based on active mode
base.highlight = function(_, group)
  return string.format('%%#%s#', group)
end

base.get_buffers = function()
  local buffers = api.nvim_list_bufs()
  local current = api.nvim_get_current_buf()
  local prev_bufs = {}
  local next_bufs = {}

  for _, buf in ipairs(buffers) do
    if listed(buf) == 1 then
      if buf < current then
        table.insert(prev_bufs, string.format(' %s ', buf))
      elseif buf > current then
        table.insert(next_bufs, string.format(' %s ', buf))
      end
    end
  end

  return {
    prev_bufs = table.concat(prev_bufs),
    current = string.format(' %s ', current),
    next_bufs = table.concat(next_bufs),
  }
end

-- Statusline to be displayed on active windows
base.set_active = function(self)
  local mode = api.nvim_get_mode().mode
  local accent_colour = self:highlight(colour_map[mode])
  local buffers = self:get_buffers()

  return table.concat({
    accent_colour,
    self:get_current_mode(),
    self:highlight(palette.Cyan),
    self:get_file_state(),
    '%<',                           -- Collapse point for smaller screen size
    self:highlight(palette.Red),
    self:format_errors(),
    self:highlight(palette.Orange),
    self:format_warnings(),
    self:highlight(palette.Yellow),
    self:format_info(),
    self:highlight(palette.Blue),
    self:format_hints(),
    self:highlight(palette.Disabled),
    buffers.prev_bufs,
    accent_colour,
    buffers.current,
    self:highlight(palette.Disabled),
    buffers.next_bufs,
    '%=',                           -- left / right separator
    self:highlight(palette.Normal),
    self:get_lsp_status(),
    self:get_file_encoding(),
    self:get_file_format(),
    accent_colour,
    self:get_file_type(),
    '%<',                           -- Collapse point for smaller screen size
    self:highlight(palette.Cyan),
    ' --%1p%%-- ',                  -- Place in file as a percentage
    accent_colour,
    ' %l:%c ',                      -- position of cursor
  })
end

-- Statusline to be displayed on inactive windows
base.set_inactive = function(self)
  return table.concat({
    self:highlight(palette.Disabled),
    self:get_file_state(),
    '%=',                           -- left / right separator
    ' --%1p%%-- ',                  -- Place in file as a percentage
    ' %l:%c ',                      -- position of cursor
  })
end

-- define highlight groups
local define_highlight_groups = function()
  for suffix, group in pairs(palette) do
    local group_name = 'StatusLine' .. suffix
    palette[suffix] = setmetatable(group, { __tostring = function() return group_name end })
    create_highlight(group_name, group)
  end

  -- default highlight for the statusline
  create_highlight('StatusLine', palette.Normal)
  -- configure highlight for wild menu (command mode completions)
  create_highlight('WildMenu', palette.Cyan)
end

-- allow defining highlight groups outside of calling setup again
base.define_highlight_groups = define_highlight_groups

-- enable StatusLine
-- calling setup will create required highlight groups and add the auto command for switching
-- between statusline active and inactive variants
base.setup = function()
  define_highlight_groups()

  vim_cmd([[
    augroup StatusLine
      au!
      au WinEnter,BufEnter * setlocal statusline=%!v:lua.StatusLine('active')
      au WinLeave,BufLeave * setlocal statusline=%!v:lua.StatusLine('inactive')
    augroup END
  ]])
end

-- Build statusline
StatusLine = setmetatable(base, {
  __call = function(self, mode)
    return self['set_' .. mode](self)
  end,
})

return StatusLine

