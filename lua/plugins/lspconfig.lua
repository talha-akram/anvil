local lsp = require('lspconfig');
local diagnostic = vim.diagnostic;
local map = vim.keymap.set;
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities());

local on_attach = function(_client, bufnr)
  local telescope_builtin = require('telescope.builtin');
  local set_keymap = function(lhs, rhs, mode)
    map(mode or 'n', lhs, rhs, { noremap = true, buffer = 0 })
  end

  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Add keybindings for LSP integration
  local buf = vim.lsp.buf

  set_keymap('<C-s>', buf.signature_help, 'i')

  set_keymap('gD', buf.declaration)
  set_keymap('gd', buf.definition)
  set_keymap('gt', buf.type_definition)
  set_keymap('gr', buf.references)

  set_keymap('K', buf.hover)

  set_keymap('<Leader><Leader>', buf.format)
  set_keymap('<Leader>i', buf.implementation)
  set_keymap('<Leader>k', buf.signature_help)
  set_keymap('<Leader>s', buf.document_symbol)
  set_keymap('<Leader>w', buf.workspace_symbol)

  set_keymap('g]', diagnostic.goto_next)
  set_keymap('g[', diagnostic.goto_prev)
  set_keymap(',d', diagnostic.open_float)

  set_keymap('<Leader>lr', telescope_builtin.lsp_references)
  set_keymap('<Leader>ls', telescope_builtin.lsp_document_symbols)
  set_keymap('<Leader>lw', telescope_builtin.lsp_workspace_symbols)
  set_keymap('<Leader>li', telescope_builtin.lsp_implementations)
  set_keymap('<Leader>ld', telescope_builtin.lsp_definitions)
  set_keymap('<Leader>ltd', telescope_builtin.lsp_type_definitions)
end

-- JavaScript
lsp.tsserver.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = {'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx'},
});

-- Ruby
lsp.solargraph.setup({ capabilities = capabilities, on_attach = on_attach });

-- Go
lsp.gopls.setup({ capabilities = capabilities, on_attach = on_attach });

-- Dart
lsp.dartls.setup({ capabilities = capabilities, on_attach = on_attach });

-- VueJS
lsp.vuels.setup({ capabilities = capabilities, on_attach = on_attach, filetypes = {'vue'} })

-- Rust
lsp.rust_analyzer.setup({ capabilities = capabilities, on_attach = on_attach })

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
local severity = diagnostic.severity
vim.diagnostic.config({
  virtual_text = true,
  signs = { priority = 0 },
  update_in_insert = false,
  severity_sort = false,
})

