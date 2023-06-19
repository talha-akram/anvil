local dap = require('dap')
local set_keymap = vim.keymap.set
local options = { noremap = true }

set_keymap('n', ',dc', dap.continue, options)
set_keymap('n', ',db', dap.toggle_breakpoint, options)
set_keymap('n', ',l',  dap.step_over, options)
set_keymap('n', ',j',  dap.step_into, options)
set_keymap('n', ',k',  dap.step_out, options)
set_keymap('n', ',dr', dap.repl.open, options)
set_keymap('n', ',dl', dap.run_last, options)

set_keymap('n', ',dbc',  function()
  dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
end, options)

set_keymap('n', ',dlp',  function()
  dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
end, options)


dap.adapters.dart = {
  type = "executable",
  command = "flutter",
  args = {"debug_adapter"}
}

dap.configurations.dart = {
  {
    type = "dart",
    request = "launch",
    name = "Launch Flutter Program",
    program = "${file}",
    cwd = "${workspaceFolder}",
    toolArgs = {"-d", "chrome"}
  }
}
