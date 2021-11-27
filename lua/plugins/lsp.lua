local lsp = require('lspconfig');
local set_keymap = vim.api.nvim_set_keymap
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Configure LS for JavaScript
lsp.tsserver.setup({
  capabilities = capabilities,
  filetypes = {'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx'},
});

-- Configure LS for Ruby
lsp.solargraph.setup({ capabilities = capabilities });

-- Configure LS for Vue
lsp.vuels.setup({ capabilities = capabilities, filetypes = {'vue'} })

-- Add diagnostics to quick-fix list
do
  local method = 'textDocument/publishDiagnostics'
  local default_handler = vim.lsp.handlers[method]
  vim.lsp.handlers[method] = function(err, method, result, client_id, bufnr, config)
    default_handler(err, method, result, client_id, bufnr, config)
    local diagnostics = vim.lsp.diagnostic.get_all()
    local qflist = {}
    for bufnr, diagnostic in pairs(diagnostics) do
      for _, d in ipairs(diagnostic) do
        d.bufnr = bufnr
        d.lnum = d.range.start.line + 1
        d.col = d.range.start.character + 1
        d.text = d.message
        table.insert(qflist, d)
      end
    end
    vim.lsp.util.set_qflist(qflist)
  end
end

-- Add keybindings for LSP integration
set_keymap('n', '<Leader>j',     '<cmd>lua vim.lsp.buf.declaration()<CR>',      { noremap = true })
set_keymap('n', '<Leader><S-d>', '<cmd>lua vim.lsp.buf.definition()<CR>',       { noremap = true })
set_keymap('n', '<Leader>h',     '<cmd>lua vim.lsp.buf.hover()<CR>',            { noremap = true })
set_keymap('n', '<Leader>i',     '<cmd>lua vim.lsp.buf.implementation()<CR>',   { noremap = true })
set_keymap('n', '<Leader>k',     '<cmd>lua vim.lsp.buf.signature_help()<CR>',   { noremap = true })
set_keymap('n', '<Leader>d',     '<cmd>lua vim.lsp.buf.type_definition()<CR>',  { noremap = true })
set_keymap('n', '<Leader>r',     '<cmd>lua vim.lsp.buf.references()<CR>',       { noremap = true })
set_keymap('n', '<Leader>v',     '<cmd>lua vim.lsp.buf.document_symbol()<CR>',  { noremap = true })
set_keymap('n', '<Leader>w',     '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', { noremap = true })

