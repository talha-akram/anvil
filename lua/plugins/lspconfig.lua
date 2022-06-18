local lsp = require('lspconfig');
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local on_attach = function()
  local telescope_builtin = require('telescope.builtin');
  local set_keymap = function(lhs, rhs)
    vim.keymap.set('n', lhs, rhs, { noremap = true })
  end

  -- Add keybindings for LSP integration
  set_keymap('<Leader>j', '<cmd>lua vim.lsp.buf.declaration()<CR>')
  set_keymap('<Leader>d', '<cmd>lua vim.lsp.buf.definition()<CR>')
  set_keymap('<Leader>h', '<cmd>lua vim.lsp.buf.hover()<CR>')
  set_keymap('<Leader>i', '<cmd>lua vim.lsp.buf.implementation()<CR>')
  set_keymap('<Leader>k', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
  set_keymap('<Leader>td', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
  set_keymap('<Leader>r', '<cmd>lua vim.lsp.buf.references()<CR>')
  set_keymap('<Leader>s', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
  set_keymap('<Leader>w', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')
  set_keymap('<Leader>]', '<cmd>lua vim.diagnostic.goto_next()<CR>')
  set_keymap('<Leader>[', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
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

