-- Noctis Bordo
local colorscheme = require('colorscheme');

local palette = {
  bg0           = '#312A2D',  --  Black     - Text
  bg1           = '#3C2F34',  --  DarkGrey  - CursorLine/Sign
  bg2           = '#2B2528',  --  DarkGrey  - Pmenu
  bg3           = '#3C2F34',  --  DarkGrey  - StatusLine
  bg4           = '#302629',  --  Grey      - Tabline/Winbar
  bg_red        = '#562C2B',  --  DarkRed
  bg_green      = '#474738',  --  DarkGreen
  bg_blue       = '#3C2F34',  --  DarkBlue
  fg            = '#C9BEC2',  --  White
  red           = '#D17B9A',  --  Red
  orange        = '#C5663F',  --  Red
  yellow        = '#F6C38A',  --  Yellow
  green         = '#7BE6AB',  --  Green
  cyan          = '#4CA1B3',  --  Cyan
  blue          = '#64AAE4',  --  Blue
  purple        = '#7060eb',  --  Magenta
  grey          = '#5C5457',  --  LightGrey
  light_grey    = '#87757C',  --  LightGrey
  light_yellow  = '#DDB988',  --  Yellow
  none          = 'NONE',     --  NONE
};

colorscheme.from_palette(palette, {
 Type      = { fg=palette.blue, bold=true },
 Include   = { fg=palette.red, bold=true },
 Keyword   = { fg=palette.orange, bold=true },
 Operator  = { fg=palette.red, bold=true },
});
