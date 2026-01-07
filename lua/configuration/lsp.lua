local buf = vim.lsp.buf
local diagnostic = vim.diagnostic
local map = vim.keymap.set

local on_attach = function(client, bufnr)
  local set_keymap = function(lhs, rhs, desc, mode)
    map(mode or 'n', lhs, rhs, { noremap = true, buffer = bufnr, desc = desc })
  end

  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- Setup tagfunc for symbol navigation
  vim.api.nvim_buf_set_option(bufnr, 'tagfunc', 'v:lua.vim.lsp.tagfunc')
  vim.api.nvim_buf_set_option(bufnr, 'formatexpr', 'v:lua.vim.lsp.formatexpr(#{timeout_ms:250})')

  -- Add keybindings for LSP integration
  set_keymap('K', buf.hover, 'popup docs')
  set_keymap('<C-s>', buf.signature_help, 'signature help', 'i')

  set_keymap('gD', buf.declaration, 'get declaration')
  set_keymap('gd', buf.definition, 'get definition')
  set_keymap('gt', buf.type_definition, 'get type definition')
  set_keymap('gi', buf.implementation, 'get implementation')
  set_keymap('gr', buf.references, 'get references')
  set_keymap('grn', buf.rename, 'rename')
  set_keymap('ga', buf.code_action, 'get code actions', {'v', 'n'})
  set_keymap('=g', function()
    buf.format({ async = true })
  end, 'format code', {'v', 'n'})

  set_keymap('<Leader>s', buf.document_symbol, 'document symbols')
  set_keymap('<Leader>w', buf.workspace_symbol, 'workspace symbols')

  set_keymap('d]', diagnostic.goto_next, 'go to next diagnostic')
  set_keymap('d[', diagnostic.goto_prev, 'go to previous diagnostic')
  set_keymap(',d', diagnostic.open_float, 'view diagnostics')

  if client.server_capabilities.selectionRangeProvider then
    set_keymap('gs', function() buf.selection_range(1) end , 'select current range', {'n', 'v'})
    set_keymap('<C-k>', function() buf.selection_range(1) end, 'expand current selection range', {'n', 'v'})
    set_keymap('<C-j>', function() buf.selection_range(-1) end, 'contract current selection range', {'n', 'v'})
  end
end

-- Add diagnostics to quick-fix list
do
  local method = 'textDocument/publishDiagnostics'
  local default_handler = vim.lsp.handlers[method]
  vim.lsp.handlers[method] = function(err, method, result, client_id, bufnr, config)
    default_handler(err, method, result, client_id, bufnr, config)
    vim.diagnostic.setloclist({ open = false })
  end
end

-- Customize how diagnostics are displayed
vim.diagnostic.config({
  virtual_text = { current_line = true },
  signs = { priority = 0 },
  update_in_insert = false,
  severity_sort = false,
})

-- Common Language Server Configuration
return {
  capabilities = vim.lsp.protocol.make_client_capabilities(),
  on_attach = on_attach,
};
