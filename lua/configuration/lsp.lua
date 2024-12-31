local buf = vim.lsp.buf
local diagnostic = vim.diagnostic
local map = vim.keymap.set

local set_keymap = function(lhs, rhs, mode)
  map(mode or 'n', lhs, rhs, { noremap = true, buffer = 0 })
end

local on_attach = function(_client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- Setup tagfunc for symbol navigation
  vim.api.nvim_buf_set_option(bufnr, 'tagfunc', 'v:lua.vim.lsp.tagfunc')

  -- Add keybindings for LSP integration
  set_keymap('K', buf.hover)
  set_keymap('<C-s>', buf.signature_help, 'i')

  set_keymap('gD', buf.declaration)
  set_keymap('gd', buf.definition)
  set_keymap('gt', buf.type_definition)
  set_keymap('gi', buf.implementation)
  set_keymap('gr', buf.references)
  set_keymap('grn', buf.rename)
  set_keymap('ga', buf.code_action, {'v', 'n'})
  set_keymap('=g', buf.format, {'v', 'n'})

  set_keymap('<Leader>t', buf.type_definition)
  set_keymap('<Leader>k', buf.signature_help)
  set_keymap('<Leader>s', buf.document_symbol)
  set_keymap('<Leader>w', buf.workspace_symbol)

  set_keymap('g]', diagnostic.goto_next)
  set_keymap('g[', diagnostic.goto_prev)
  set_keymap(',d', diagnostic.open_float)
end

-- Add diagnostics to quick-fix list
do
  local method = 'textDocument/publishDiagnostics'
  local default_handler = vim.lsp.handlers[method]
  vim.lsp.handlers[method] = function(err, method, result, client_id, bufnr, config)
    default_handler(err, method, result, client_id, bufnr, config)
    vim.diagnostic.setqflist({ open = false })
    vim.diagnostic.setloclist({ open = false })
  end
end

-- Customize how diagnostics are displayed
vim.diagnostic.config({
  virtual_text = true,
  signs = { priority = 0 },
  update_in_insert = false,
  severity_sort = false,
})

-- Common Language Server Configuration
return {
  capabilities = vim.lsp.protocol.make_client_capabilities(),
  on_attach = on_attach,
};
