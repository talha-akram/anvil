-- Miramare
local colorscheme = require('colorscheme');

local palette = {
  bg0           = '#242021',  -- Text
  bg1           = '#2A2426',  -- CursorLine/Sign
  bg2           = '#2A2426',  -- Pmenu
  bg3           = '#242021',  -- StatusLine
  bg4           = '#302629',  -- Tabline/Winbar
  bg4           = '#242021',
  bg_red        = '#392f32',
  bg_green      = '#333b2f',
  bg_blue       = '#203a41',
  fg            = '#e6d6ac',
  red           = '#e68183',
  orange        = '#e39b7b',
  yellow        = '#d9bb80',
  green         = '#87af87',
  cyan          = '#87c095',
  blue          = '#89beba',
  purple        = '#d3a0bc',
  grey          = '#444444',
  light_grey    = '#5b5b5b',
  light_yellow  = '#d8caac',
  none          = 'NONE',
};

colorscheme.from_palette(palette);
