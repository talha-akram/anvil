-- Visualise and control undo history in tree form.
vim.keymap.set('n', ',r', '<CMD>UndotreeToggle<CR>', { noremap = true, desc = 'Undotree' });

return {
  name = 'undotree',
  src = 'https://github.com/mbbill/undotree',
};
