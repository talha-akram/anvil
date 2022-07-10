local lsp = require('lspconfig');
local map = vim.keymap.set
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local on_attach = function(_client, bufnr)
  local telescope_builtin = require('telescope.builtin');
  local set_keymap = function(lhs, rhs)
    map('n', lhs, rhs, { noremap = true, buffer = 0 })
  end

  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Add keybindings for LSP integration
  local buf = vim.lsp.buf
  set_keymap('gD', buf.declaration)
  set_keymap('gd', buf.definition)
  set_keymap('gt', buf.type_definition)
  set_keymap('gr', buf.references)
  set_keymap('<Leader>h', buf.hover)
  set_keymap('<Leader>i', buf.implementation)
  set_keymap('<Leader>k', buf.signature_help)
  set_keymap('<Leader>s', buf.document_symbol)
  set_keymap('<Leader>w', buf.workspace_symbol)

  set_keymap('g]', vim.diagnostic.goto_next)
  set_keymap('g[', vim.diagnostic.goto_prev)

  set_keymap('<Leader>lr', telescope_builtin.lsp_references)
  set_keymap('<Leader>ls', telescope_builtin.lsp_document_symbols)
  set_keymap('<Leader>lw', telescope_builtin.lsp_workspace_symbols)
  set_keymap('<Leader>li', telescope_builtin.lsp_implementations)
  set_keymap('<Leader>ld', telescope_builtin.lsp_definitions)
  set_keymap('<Leader>ltd', telescope_builtin.lsp_type_definitions)
end

-- Configure LS for JavaScript
lsp.tsserver.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = {'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx'},
});

-- Configure LS for Ruby
lsp.solargraph.setup({ capabilities = capabilities, on_attach = on_attach });

-- Configure LS for Go
lsp.gopls.setup({ capabilities = capabilities, on_attach = on_attach });

-- Configure LS for Vue
lsp.vuels.setup({ capabilities = capabilities, on_attach = on_attach, filetypes = {'vue'} })

-- Add diagnostics to quick-fix list
do
  local method = 'textDocument/publishDiagnostics'
  local default_handler = vim.lsp.handlers[method]
  vim.lsp.handlers[method] = function(err, method, result, client_id, bufnr, config)
    default_handler(err, method, result, client_id, bufnr, config)
    vim.diagnostic.setqflist({ open = false })
  end
end

-- Customize how diagnostics are displayed
vim.diagnostic.config({
  virtual_text = true,
  signs = { priority = 0 },
  underline = { severity = vim.diagnostic.severity.ERROR },
  update_in_insert = false,
  severity_sort = false,
})

