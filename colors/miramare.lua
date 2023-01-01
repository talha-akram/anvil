local colorscheme = require('colorscheme');

local palette = {
  bg0           = '#2A2426',  --  Black     - Text
  bg1           = '#242021',  --  DarkGrey  - CursorLine/Sign
  bg2           = '#242021',  --  DarkGrey  - Pmenu
  bg3           = '#242021',  --  DarkGrey  - StatusLine
  bg4           = '#242021',  --  Grey
  bg_red        = '#392f32',  --  DarkRed
  bg_green      = '#333b2f',  --  DarkGreen
  bg_blue       = '#203a41',  --  DarkBlue
  fg            = '#e6d6ac',  --  White
  red           = '#e68183',  --  Red
  orange        = '#e39b7b',  --  Red
  yellow        = '#d9bb80',  --  Yellow
  green         = '#87af87',  --  Green
  cyan          = '#87c095',  --  Cyan
  blue          = '#89beba',  --  Blue
  purple        = '#d3a0bc',  --  Magenta
  grey          = '#444444',  --  LightGrey
  light_grey    = '#5b5b5b',  --  LightGrey
  light_yellow  = '#d8caac',  --  Yellow
  none          = 'NONE',     --  NONE
};

colorscheme.from_palette(palette);
