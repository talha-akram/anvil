local colorscheme = require('colorscheme');

local palette = {
  bg0           = '#2f2c49',  --  Black     - Text
  bg1           = '#403b62',  --  DarkGrey  - CursorLine/Sign
  bg2           = '#7060eb',  --  DarkGrey  - Pmenu
  bg3           = '#292640',  --  DarkGrey  - StatusLine
  bg4           = '#998ef1',  --  Grey
  bg_red        = '#59363c',  --  DarkRed
  bg_green      = '#6e67a8',  --  DarkGreen
  bg_blue       = '#263c47',  --  DarkBlue
  fg            = '#a9a5c0',  --  White
  red           = '#df769b',  --  Red
  orange        = '#e3541c',  --  Red
  yellow        = '#d5971a',  --  Yellow
  green         = '#49e9a6',  --  Green
  cyan          = '#5c5973',  --  Cyan
  blue          = '#49ace9',  --  Blue
  purple        = '#16a3b6',  --  Magenta
  grey          = '#716c93',  --  LightGrey
  light_grey    = '#c5c2d6',  --  LightGrey
  light_yellow  = '#e4b781',  --  Yellow
  none          = 'NONE',     --  NONE
};

colorscheme.from_palette(palette, {
 ['@type']      = { fg=palette.blue, bold=true },
 ['@include']   = { fg=palette.red, bold=true },
 ['@keyword']   = { fg=palette.orange, bold=true },
 ['@operator']  = { fg=palette.red, bold=true },
});
