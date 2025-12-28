-- Visualise and control undo history in tree form.
return {
  src = 'https://github.com/mbbill/undotree',
  data = {
    setup = function()
      vim.keymap.set('n', ',r', '<CMD>UndotreeToggle<CR>', { noremap = true, desc = 'Undotree' });
    end,
  },
};
