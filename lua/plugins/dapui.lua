local dap = require('dap')
local dapui = require('dapui')


dap.listeners.after.event_initialized['dapui_config'] = dapui.open
dap.listeners.before.event_terminated['dapui_config'] = dapui.close
dap.listeners.before.event_exited['dapui_config'] = dapui.close

dapui.setup({
  icons = { expanded = '▼', collapsed = '▶' },
  mappings = {
    expand = {'<CR>', '<2-LeftMouse>'},
    open = 'o',
    remove = 'd',
    edit = 'e',
    repl = 'r',
    toggle = 't',
  },
  -- Expand lines larger than the window - Requires >= 0.7
  expand_lines = vim.fn.has('nvim-0.7'),
  layouts = {
    {
      elements = {
        -- table of ids:string or table of tables( id: string, size:(float | integer > 1) ))
        { id = 'scopes', size = 0.25, },
        { id = 'breakpoints', size = 0.10 },
        { id = 'stacks', size = 0.35 },
        { id = 'watches', size = 0.20 },
      },
      size = 40,
      position = 'left', -- Can be 'left', 'right', 'top', 'bottom'
    },
    {
      elements = {'repl', 'console'},
      size = 10,
      position = 'bottom', -- Can be 'left', 'right', 'top', 'bottom'
    }
  },
  floating = {
    border = 'single', -- Border style. Can be 'single', 'double' or 'rounded'
    mappings = {
      close = {'q', '<Esc>'},
    },
  },
  windows = { indent = 1 },
  render = {
    max_type_length = nil, -- Can be integer or nil.
  }
})

