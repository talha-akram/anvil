-- Noctis Uva
local colorscheme = require('colorscheme');

local palette = {
  bg0           = '#28263E',  --  Black     - Text
  bg1           = '#333055',  --  DarkGrey  - CursorLine/Sign
  bg2           = '#232135',  --  DarkGrey  - Pmenu
  bg3           = '#333055',  --  DarkGrey  - StatusLine
  bg4           = '#211F3B',  --  Grey      - Tabline/Winbar
  bg_red        = '#4F2839',  --  DarkRed
  bg_green      = '#404346',  --  DarkGreen
  bg_blue       = '#333055',  --  DarkBlue
  fg            = '#C4C2D4',  --  White
  red           = '#D17B9A',  --  Red
  orange        = '#D66D41',  --  Red
  yellow        = '#E8B985',  --  Yellow
  green         = '#7BE6AB',  --  Green
  cyan          = '#4CA1B3',  --  Cyan
  blue          = '#64AAE4',  --  Blue
  purple        = '#6d61e3',  --  Magenta
  grey          = '#56546C',  --  LightGrey
  light_grey    = '#706C90',  --  LightGrey
  light_yellow  = '#ddb988',  --  Yellow
  none          = 'NONE',     --  NONE
};

colorscheme.from_palette(palette, {
 Type      = { fg=palette.blue, bold=true },
 Include   = { fg=palette.red, bold=true },
 Keyword   = { fg=palette.orange, bold=true },
 Operator  = { fg=palette.red, bold=true },
});
