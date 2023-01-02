local colorscheme = require('colorscheme');

local palette = {
  bg0           = '#322a2d',  --  Black     - Text
  bg1           = '#413036',  --  DarkGrey  - CursorLine/Sign
  bg2           = '#544349',  --  DarkGrey  - Pmenu
  bg3           = '#413036',  --  DarkGrey  - StatusLine
  bg4           = '#715b63',  --  Grey      - Tabline/Winbar
  bg_red        = '#5f392e',  --  DarkRed
  bg_green      = '#2d3f37',  --  DarkGreen
  bg_blue       = '#997582',  --  DarkBlue
  fg            = '#cbbec2',  --  White
  red           = '#df769b',  --  Red
  orange        = '#e3541c',  --  Red
  yellow        = '#d5971a',  --  Yellow
  green         = '#49e9a6',  --  Green
  cyan          = '#16a3b6',  --  Cyan
  blue          = '#49ace9',  --  Blue
  purple        = '#7060eb',  --  Magenta
  grey          = '#8b747c',  --  LightGrey
  light_grey    = '#bbaab0',  --  LightGrey
  light_yellow  = '#e4b781',  --  Yellow
  none          = 'NONE',     --  NONE
};

colorscheme.from_palette(palette, {
 Type      = { fg=palette.blue, bold=true },
 Include   = { fg=palette.red, bold=true },
 Keyword   = { fg=palette.orange, bold=true },
 Operator  = { fg=palette.red, bold=true },
});
