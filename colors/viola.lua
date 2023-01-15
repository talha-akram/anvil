-- Noctis Viola
local colorscheme = require('colorscheme');

local palette = {
  bg0           = '#2E243B',  --  Black     - Text
  bg1           = '#3C2E4F',  --  DarkGrey  - CursorLine/Sign
  bg2           = '#292135',  --  DarkGrey  - Pmenu
  bg3           = '#3C2E4F',  --  DarkGrey  - StatusLine
  bg4           = '#5c5973',  --  Grey      - Tabline/Winbar
  bg_red        = '#753939',  --  DarkRed
  bg_green      = '#4A534A',  --  DarkGreen
  bg_blue       = '#3C2E4F',  --  DarkBlue
  fg            = '#C1B6CE',  --  White
  red           = '#d17b9a',  --  Red
  orange        = '#D66D41',  --  Red
  yellow        = '#F6C38A',  --  Yellow
  green         = '#7BE6AB',  --  Green
  cyan          = '#4CA1B3',  --  Cyan
  blue          = '#64AAE4',  --  Blue
  purple        = '#6D61E3',  --  Magenta
  grey          = '#5C5368',  --  LightGrey
  light_grey    = '#7B6697',  --  LightGrey
  light_yellow  = '#DDB988',  --  Yellow
  none          = 'NONE',     --  NONE
};

colorscheme.from_palette(palette, {
 Type      = { fg=palette.blue, bold=true },
 Include   = { fg=palette.red, bold=true },
 Keyword   = { fg=palette.orange, bold=true },
 Operator  = { fg=palette.red, bold=true },
});
