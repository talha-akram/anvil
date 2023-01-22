local lsp = require('lspconfig');
local diagnostic = vim.diagnostic;
local map = vim.keymap.set;
local use_layout = require('plugins.telescope.layouts')
-- local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities());

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
  set_keymap('ga', buf.code_action, {'v', 'n'})

  set_keymap('K', buf.hover)

  set_keymap('<Leader><Leader>', buf.format)
  set_keymap('<Leader>i', buf.implementation)
  set_keymap('<Leader>k', buf.signature_help)
  set_keymap('<Leader>s', buf.document_symbol)
  set_keymap('<Leader>w', buf.workspace_symbol)

  set_keymap('g]', diagnostic.goto_next)
  set_keymap('g[', diagnostic.goto_prev)
  set_keymap(',d', diagnostic.open_float)

  set_keymap('<Leader>lr',  use_layout(telescope_builtin.lsp_references, 'ivy_plus'))
  set_keymap('<Leader>ls',  use_layout(telescope_builtin.lsp_document_symbols, 'ivy_plus'))
  set_keymap('<Leader>lw',  use_layout(telescope_builtin.lsp_workspace_symbols, 'ivy_plus'))
  set_keymap('<Leader>li',  use_layout(telescope_builtin.lsp_implementations, 'ivy_plus'))
  set_keymap('<Leader>ld',  use_layout(telescope_builtin.lsp_definitions, 'ivy_plus'))
  set_keymap('<Leader>ltd', use_layout(telescope_builtin.lsp_type_definitions, 'ivy_plus'))
end

-- Language Server Configuration
local options = {
  -- capabilities = capabilities,
  on_attach = on_attach
};

-- Languange Servers we want to enable
local language_servers = {
  'tsserver',
  'solargraph',
  'gopls',
  'dartls',
  'vuels',
  'rust_analyzer'
};

-- Setup and configure language servers
for _index, server in ipairs(language_servers) do
  lsp[server].setup(options);
end

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
local severity = diagnostic.severity
vim.diagnostic.config({
  virtual_text = true,
  signs = { priority = 0 },
  update_in_insert = false,
  severity_sort = false,
})

