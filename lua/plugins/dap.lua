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


-- Ruby / Rails
dap.adapters.ruby = {
  type = 'executable';
  command = 'readapt';
  args = {'stdio'};
}

dap.configurations.ruby = {
  {
    type = 'ruby';
    request = 'launch';
    name = 'Rails';
    program = 'rdbg';
    programArgs = {
      '-O', '-n', '-c', '--', 'bundle', 'exec', 'rails', 'server'
    };
    useBundler = true;
  },
}

-- Dart / Flutter
dap.adapters.dart = {
  type = 'executable',
  command = vim.fn.stdpath('data')..'/mason/bin/dart-debug-adapter',
  args = {'dart'}
}

dap.adapters.flutter = {
  type = 'executable',
  command = vim.fn.stdpath('data')..'/mason/bin/dart-debug-adapter',
  args = {'flutter'}
}
