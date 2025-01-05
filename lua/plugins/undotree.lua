-- Visualise and control undo history in tree form.
return {
  'mbbill/undotree',
  cmd = 'UndotreeToggle',
  keys = {
    { ',r', '<CMD>UndotreeToggle<CR>', desc = 'Undotree', noremap = true },
  },
}
