-- Base NeoVim configuration
require('configuration')

-- Only load plugins when not runing as root
if (vim.fn.exists('$SUDO_USER') == 0) then
  require('plugins')
end

-- Set colorscheme
vim.cmd([[
  try
    colorscheme everforest
    catch
  endtry
]])

StatusLine:extract_colors({
  Error = 'DiagnosticSignError',
  Warn = 'DiagnosticSignWarn',
  Info = 'DiagnosticSignInfo',
  Hint = 'DiagnosticSignHint',
  Insert = 'Question',
  Replace = 'Label',
  Select = 'Number',
  Normal = 'Character',
  Progress = 'Macro',
  Status = 'Normal'
})

