-- Setup nvim-cmp.
local cmp = require('cmp')
-- local lsp_expand = require('luasnip').lsp_expand


cmp.setup({
  completion = {
    autocomplete = false
  },
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn['vsnip#anonymous'](args.body) -- For `vsnip` users.
      -- lsp_expand(args.body) -- For `LuaSnip` users.
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>']     = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>']     = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>']     = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<CR>']      = cmp.mapping.confirm({ select = true }),
    ['<C-e>']     = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
  }),
  sources = cmp.config.sources({
    -- { name = "copilot" },
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'vsnip' },
    { name = 'buffer', keyword_length = 5 },
  })
})

