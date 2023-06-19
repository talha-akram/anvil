local dap = require('dap')
local dapui = require('dapui')

vim.keymap.set('v', ',dk', dapui.eval)

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
        -- { id = 'breakpoints', size = 0.10 },
        -- { id = 'watches', size = 0.10 },
        { id = 'stacks', size = 0.50 },
        { id = 'scopes', size = 0.50 },
      },
      size = 40,
      position = 'left',
    },
    {
      elements = {'console'},
      size = 10,
      position = 'top',
    },
    {
      elements = {'repl'},
      size = 10,
      position = 'bottom',
    }
  },
  floating = {
    border = 'single',
    mappings = {
      close = {'q', '<Esc>'},
    },
  },
  windows = { indent = 1 },
  render = {
    max_type_length = nil, -- Can be integer or nil.
  }
})

