-- Base NeoVim configuration
require('configuration')

-- Only load plugins when not runing as root
if (vim.fn.exists('$SUDO_USER') == 0) then
  require('plugins')
end

-- Set colorscheme
vim.cmd([[
  try
    colorscheme noctis
    catch
  endtry
]])

-- Specify Highlight groups to use for extracting fg color for
-- statusline components
StatusLine:extract_colors({
  Error = 'DiagnosticSignError',
  Warn = 'DiagnosticSignWarn',
  Info = 'DiagnosticSignInfo',
  Hint = 'DiagnosticSignHint',
  Normal = 'Character',
  Insert = 'Question',
  Select = 'Number',
  Replace = 'Label',
  Progress = 'Macro',
  Fileinfo = 'Normal',
  Inactive = 'Conceal'
})

