local options = require('configuration.lsp')

-- Do not expand tabs to spaces in go files
vim.bo.expandtab = false

if (vim.fn.executable('gopls') == 1) then
  vim.lsp.start({
    name = 'gopls',
    filetypes = {'go', 'gomod', 'gowork', 'gotmpl'},
    cmd = {'gopls'},
    root_dir = vim.fs.root(0, {'go.mod', '.git'}),
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
          nilness = true,
        },
        staticcheck = true,
        usePlaceholders = true,
        gofumpt = true,
      },
    },
    on_attach = options.on_attach,
    capabilities = options.capabilities,
  })
end

-- setup dap adapters and configuration for go
local loaded, dap = pcall(require, 'dap')
if not loaded then return end

dap.adapters.go = function(callback, config)
  local stdout = vim.loop.new_pipe(false)
  local handle
  local pid_or_err
  local host = config.host or '127.0.0.1'
  local port = config.port or '38697'
  local addr = string.format('%s:%s', host, port)
  local opts = {
    stdio = {nil, stdout},
    args = {'dap', '-l', addr},
    detached = true
  }
  handle, pid_or_err = vim.loop.spawn('dlv', opts, function(code)
    stdout:close()
    handle:close()
    if code ~= 0 then
      print('dlv exited with code', code)
    end
  end)
  assert(handle, 'Error running dlv: ' .. tostring(pid_or_err))
  stdout:read_start(function(err, chunk)
    assert(not err, err)
    if chunk then
      vim.schedule(function()
        require('dap.repl').append(chunk)
      end)
    end
  end)
  -- Wait for delve to start
  vim.defer_fn(
    function()
      callback({type = 'server', host = '127.0.0.1', port = port})
    end,
    100
  )
end

dap.configurations.go = {
  {
    type = 'go',
    name = 'Debug',
    request = 'launch',
    program = '${file}',
  },
  {
    type = 'go',
    name = 'Debug Package',
    request = 'launch',
    program = '${fileDirname}',
  },
  {
    type = 'go',
    name = 'Attach',
    mode = 'local',
    request = 'attach',
    processId = require('dap.utils').pick_process,
  },
  {
    type = 'go',
    name = 'Debug test',
    request = 'launch',
    mode = 'test',
    program = '${file}',
  },
  {
    type = 'go',
    name = 'Debug test (go.mod)',
    request = 'launch',
    mode = 'test',
    program = './${relativeFileDirname}',
  }
}
