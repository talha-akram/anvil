-- Use Tree-sitter to select and manipulate text object
return {
  src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
  version = 'main',
  data = {
    setup = function()
      require('nvim-treesitter-textobjects').setup({
        move = {
          enable = true,
          set_jumps = true,
        },
        swap = {
          enable = true,
        },
      });

      local move = require('nvim-treesitter-textobjects.move');
      local swap = require('nvim-treesitter-textobjects.swap');
      local keymaps = {
        {
          { 'n', 'x', 'o' },
          '[f',
          function() move.goto_previous_start('@function.outer', 'textobjects') end,
          { desc = 'prev function' },
        },
        {
          { 'n', 'x', 'o' },
          ']f',
          function() move.goto_next_start('@function.outer', 'textobjects') end,
          { desc = 'next function' },
        },
        {
          { 'n', 'x', 'o' },
          '[F',
          function() move.goto_previous_end('@function.outer', 'textobjects') end,
          { desc = 'prev function end' },
        },
        {
          { 'n', 'x', 'o' },
          ']F',
          function() move.goto_next_end('@function.outer', 'textobjects') end,
          { desc = 'next function end' },
        },
        {
          { 'n', 'x', 'o' },
          '[p',
          function() move.goto_previous_start('@parameter.outer', 'textobjects') end,
          { desc = 'prev argument' },
        },
        {
          { 'n', 'x', 'o' },
          ']p',
          function() move.goto_next_start('@parameter.outer', 'textobjects') end,
          { desc = 'next argument' },
        },
        {
          { 'n', 'x', 'o' },
          '[P',
          function() move.goto_previous_end('@parameter.outer', 'textobjects') end,
          { desc = 'prev argument end' },
        },
        {
          { 'n', 'x', 'o' },
          ']P',
          function() move.goto_next_end('@parameter.outer', 'textobjects') end,
          { desc = 'next argument end' },
        },
        {
          { 'n', 'x', 'o' },
          '[s',
          function() move.goto_previous_start('@block.outer', 'textobjects') end,
          { desc = 'prev block' },
        },
        {
          { 'n', 'x', 'o' },
          ']s',
          function() move.goto_next_start('@block.outer', 'textobjects') end,
          { desc = 'next block' },
        },
        {
          { 'n', 'x', 'o' },
          '[S',
          function() move.goto_previous_end('@block.outer', 'textobjects') end,
          { desc = 'prev block' },
        },
        {
          { 'n', 'x', 'o' },
          ']S',
          function() move.goto_next_end('@block.outer', 'textobjects') end,
          { desc = 'next block' },
        },
        {
          { 'n', 'x', 'o' },
          'gan',
          function() swap.swap_next('@parameter.inner') end,
          { desc = 'swap next argument' },
        },
        {
          { 'n', 'x', 'o' },
          'gap',
          function() swap.swap_previous('@parameter.inner') end,
          { desc = 'swap prev argument' },
        },
      }

      for _index, map in ipairs(keymaps) do
        vim.keymap.set(unpack(map))
      end
    end,
  }
}
