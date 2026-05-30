local diagnostic = vim.diagnostic

-- Defaults merged into every server config
vim.lsp.config('*', {
  capabilities = vim.lsp.protocol.make_client_capabilities(),
})

--   grn rename · gra code action · grr references · gri implementation
--   grt type definition · gO document symbol · <C-s> signature help (insert)
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspAttach', { clear = true }),
  callback = function(event)
    local bufnr = event.buf
    local client = assert(vim.lsp.get_client_by_id(event.data.client_id))
    local buf = vim.lsp.buf

    local function map(lhs, rhs, desc, mode)
      vim.keymap.set(mode or 'n', lhs, rhs, { buffer = bufnr, desc = desc })
    end

    map('gD', buf.declaration, 'declaration')
    map('gd', buf.definition, 'definition')
    map('gt', buf.type_definition, 'type definition')
    map('gi', buf.implementation, 'implementation')
    map('gr', buf.references, 'references')
    map('ga', buf.code_action, 'code actions', { 'n', 'v' })
    map('=g', function() buf.format({ async = true }) end, 'format code', { 'n', 'v' })

    map('<Leader>s', buf.document_symbol, 'document symbols')
    map('<Leader>w', buf.workspace_symbol, 'workspace symbols')

    map('d]', function() diagnostic.jump({ count = 1, float = true }) end, 'next diagnostic')
    map('d[', function() diagnostic.jump({ count = -1, float = true }) end, 'previous diagnostic')
    map(',d', diagnostic.open_float, 'view diagnostics')

    -- LSP autocompletion.
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
    end

    -- LSP-driven folding.
    if client:supports_method('textDocument/foldingRange') then
      local win = vim.api.nvim_get_current_win()
      vim.wo[win][0].foldmethod = 'expr'
      vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
    end

    -- Inlay hints, off by default with a per-buffer toggle.
    if client:supports_method('textDocument/inlayHint') then
      map('<Leader>i', function()
        local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
        vim.lsp.inlay_hint.enable(not enabled, { bufnr = bufnr })
      end, 'toggle inlay hints')
    end

    -- Document colours (virtual swatches), auto-enabled when supported.
    if client:supports_method('textDocument/documentColor') then
      vim.lsp.document_color.enable(true, { bufnr = bufnr }, { style = 'virtual' })
      map('<Leader>c', function()
        vim.lsp.document_color.enable(true, { bufnr = bufnr }, { style = 'virtual' })
      end, 'show document colors')
    end

    -- Expand/contract selection by LSP semantic range.
    if client:supports_method('textDocument/selectionRange') then
      map('gs', function() buf.selection_range(1) end, 'select current range', { 'n', 'v' })
      map('<C-k>', function() buf.selection_range(1) end, 'expand selection range', { 'n', 'v' })
      map('<C-j>', function() buf.selection_range(-1) end, 'contract selection range', { 'n', 'v' })
    end
  end,
})

-- Add diagnostics into loclist as they change.
vim.api.nvim_create_autocmd('DiagnosticChanged', {
  group = vim.api.nvim_create_augroup('UserDiagnosticLoclist', { clear = true }),
  callback = function() diagnostic.setloclist({ open = false }) end,
})

-- Diagnostic
diagnostic.config({
  virtual_lines = { current_line = true },
  virtual_text = false,
  signs = { priority = 0 },
  update_in_insert = false,
  severity_sort = true,
})

-- Ruby: prefer ruby-lsp and fall back to rubocop's LSP.
if vim.fn.executable('ruby-lsp') == 1 then
  vim.lsp.enable('ruby-lsp')
elseif vim.fn.executable('rubocop') == 1 then
  vim.lsp.enable('rubocop')
end

-- LSPs to check if they exists before enabling them
local optional_servers = {
  coffeesense   = 'coffeesense-language-server',
  dartls        = 'dart',
  gopls         = 'gopls',
  ['quick-lint'] = 'quick-lint-js',
  ['ts-ls']     = 'typescript-language-server',
  vuels         = 'vls',
}

for name, executable in pairs(optional_servers) do
  if vim.fn.executable(executable) == 1 then
    vim.lsp.enable(name)
  end
end
