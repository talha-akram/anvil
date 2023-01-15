-- Noctis Azureus
local colorscheme = require('colorscheme');

local palette = {
  bg0           = '#1E2931',  --  Black     - Text
  bg1           = '#223441',  --  DarkGrey  - CursorLine/Sign
  bg2           = '#1A232A',  --  DarkGrey  - Pmenu
  bg3           = '#223441',  --  DarkGrey  - StatusLine
  bg4           = '#12202A',  --  Grey      - Tabline/Winbar
  bg_red        = '#472B2E',  --  DarkRed
  bg_green      = '#38463B',  --  DarkGreen
  bg_blue       = '#153A5B',  --  DarkBlue
  fg            = '#C6CDD2',  --  White
  red           = '#BF8FA1',  --  Red
  orange        = '#B8785B',  --  Red
  yellow        = '#CEB796',  --  Yellow
  green         = '#84BEA1',  --  Green
  cyan          = '#51828B',  --  Cyan
  blue          = '#608BAE',  --  Blue
  purple        = '#6F68AC',  --  Magenta
  grey          = '#4B575F',  --  LightGrey
  light_grey    = '#637785',  --  LightGrey
  light_yellow  = '#DAC1A3',  --  Yellow
  none          = 'NONE',     --  NONE
};

colorscheme.from_palette(palette, {
 Type      = { fg=palette.blue, bold=true },
 Include   = { fg=palette.red, bold=true },
 Keyword   = { fg=palette.orange, bold=true },
 Operator  = { fg=palette.red, bold=true },
});
