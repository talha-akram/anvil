local lsp = require('lspconfig');
local set_keymap = vim.api.nvim_set_keymap
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local on_attach = function()
  -- Add keybindings for LSP integration
  set_keymap('n', '<Leader>j',     '<cmd>lua vim.lsp.buf.declaration()<CR>',      { noremap = true })
  set_keymap('n', '<Leader><S-d>', '<cmd>lua vim.lsp.buf.definition()<CR>',       { noremap = true })
  set_keymap('n', '<Leader>h',     '<cmd>lua vim.lsp.buf.hover()<CR>',            { noremap = true })
  set_keymap('n', '<Leader>i',     '<cmd>lua vim.lsp.buf.implementation()<CR>',   { noremap = true })
  set_keymap('n', '<Leader>k',     '<cmd>lua vim.lsp.buf.signature_help()<CR>',   { noremap = true })
  set_keymap('n', '<Leader>d',     '<cmd>lua vim.lsp.buf.type_definition()<CR>',  { noremap = true })
  set_keymap('n', '<Leader>r',     '<cmd>lua vim.lsp.buf.references()<CR>',       { noremap = true })
  set_keymap('n', '<Leader>s',     '<cmd>lua vim.lsp.buf.document_symbol()<CR>',  { noremap = true })
  set_keymap('n', '<Leader>w',     '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', { noremap = true })
  set_keymap('n', '<Leader>]',     '<cmd>lua vim.diagnostic.goto_next()<CR>',     { noremap = true })
  set_keymap('n', '<Leader>[',     '<cmd>lua vim.diagnostic.goto_prev()<CR>',     { noremap = true })
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

