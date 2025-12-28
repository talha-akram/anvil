-- Miramare
local colorscheme = require('colorscheme');

-- Yet to be defined and used:
  -- Brown
  -- DarkBlue
  -- DarkCyan
  -- DarkGray
  -- DarkGreen
  -- DarkMagenta
  -- DarkRed
  -- DarkYellow
  -- LightBlue
  -- LightCyan
  -- LightGray
  -- LightGreen
  -- LightMagenta
  -- LightRed
  -- LightYellow
  -- Magenta
local palette = {
  bg0           = '#32302F',  -- Text
  bg1           = '#403C3A',  -- CursorLine/Sign
  bg2           = '#292828',  -- Pmenu
  bg3           = '#292828',  -- StatusLine
  bg4           = '#302629',  -- Tabline/Winbar
  bg_red        = '#392f32',
  bg_green      = '#333b2f',
  bg_blue       = '#203a41',
  fg            = '#e6d6ac',
  white         = '#e6d6ac',
  red           = '#ea6962',
  light_red     = '#e68183',
  orange        = '#e39b7b',
  yellow        = '#d9bb80',
  green         = '#87af87',
  cyan          = '#87c095',
  blue          = '#89beba',
  purple        = '#d3a0bc',
  black         = '#45403d',
  grey          = '#7c6f64',
  light_grey    = '#928374',
  light_yellow  = '#d8caac',
  none          = 'NONE',
};

vim.opt.background = 'dark'
vim.g.colors_name = 'concoctis-neo'
colorscheme.from_palette(palette, {
  Type             = { fg=palette.blue,       bold=true },
  Include          = { fg=palette.red,        bold=true },
  Keyword          = { fg=palette.orange,     bold=true },
  Operator         = { fg=palette.red,        bold=true },
});
