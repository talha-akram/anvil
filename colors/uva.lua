local colorscheme = require('colorscheme');

local palette = {
  bg0           = '#2f2c49',  --  Black     - Text
  bg1           = '#292640',  --  DarkGrey  - CursorLine/Sign
  bg2           = '#292640',  --  DarkGrey  - Pmenu
  bg3           = '#292640',  --  DarkGrey  - StatusLine
  bg4           = '#5c5973',  --  Grey      - Tabline/Winbar
  bg_red        = '#59363c',  --  DarkRed
  bg_green      = '#263c47',  --  DarkGreen
  bg_blue       = '#403b62',  --  DarkBlue
  fg            = '#a9a5c0',  --  White
  red           = '#df769b',  --  Red
  orange        = '#e3541c',  --  Red
  yellow        = '#d5971a',  --  Yellow
  green         = '#49e9a6',  --  Green
  cyan          = '#16a3b6',  --  Cyan
  blue          = '#49ace9',  --  Blue
  purple        = '#998ef1',  --  Magenta
  grey          = '#716c93',  --  LightGrey
  light_grey    = '#c5c2d6',  --  LightGrey
  light_yellow  = '#e4b781',  --  Yellow
  none          = 'NONE',     --  NONE
};

colorscheme.from_palette(palette, {
 Type      = { fg=palette.blue, bold=true },
 Include   = { fg=palette.red, bold=true },
 Keyword   = { fg=palette.orange, bold=true },
 Operator  = { fg=palette.red, bold=true },
});
