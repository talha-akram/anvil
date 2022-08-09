local dap = require('dap')
local set_keymap = vim.keymap.set


set_keymap(',dc',   dap.continue)
set_keymap(',db',   dap.toggle_breakpoint)
set_keymap(',l',    dap.step_over)
set_keymap(',j',    dap.step_into)
set_keymap(',k',    dap.step_out)
set_keymap(',dr',   dap.repl.open)
set_keymap(',dl',   dap.run_last)
set_keymap(',dbc',  function()
  dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')
end)
set_keymap(',dlp',  function()
  dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')
end)
