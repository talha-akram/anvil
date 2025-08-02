local highlight = vim.api.nvim_set_hl;

return {
  from_palette = function(palette, override)
    local highlight_groups = {

      -- Black
      Blue                        = { fg=palette.blue,       bg=palette.none },
      -- Brown
      Cyan                        = { fg=palette.cyan,       bg=palette.none },
      -- DarkBlue
      -- DarkCyan
      -- DarkGray
      -- DarkGreen
      -- DarkMagenta
      -- DarkRed
      -- DarkYellow
      Fg                          = { fg=palette.fg,         bg=palette.none },
      Green                       = { fg=palette.green,      bg=palette.none },
      Grey                        = { fg=palette.grey,       bg=palette.none },
      -- LightBlue
      -- LightCyan
      -- LightGray
      -- LightGreen
      -- LightMagenta
      -- LightRed
      -- LightYellow
      -- Magenta
      Orange                      = { fg=palette.orange,     bg=palette.none },
      OrangeItalic                = { fg=palette.orange,     bg=palette.none, italic=true },
      Purple                      = { fg=palette.purple,     bg=palette.none },
      PurpleItalic                = { fg=palette.purple,     bg=palette.none, italic=true },
      Red                         = { fg=palette.red,        bg=palette.none },
      RedItalic                   = { fg=palette.red,        bg=palette.none, italic=true },
      -- SeaGreen
      -- SlateBlue
      -- Violet
      -- White
      Yellow                      = { fg=palette.yellow,     bg=palette.none },

      RedSign                     = { fg=palette.red,        bg=palette.bg1 },
      OrangeSign                  = { fg=palette.orange,     bg=palette.bg1 },
      YellowSign                  = { fg=palette.yellow,     bg=palette.bg1 },
      GreenSign                   = { fg=palette.green,      bg=palette.bg1 },
      CyanSign                    = { fg=palette.cyan,       bg=palette.bg1 },
      BlueSign                    = { fg=palette.blue,       bg=palette.bg1 },
      PurpleSign                  = { fg=palette.purple,     bg=palette.bg1 },

      diffAdded                   = { link='Green' },
      diffRemoved                 = { link='Red' },
      diffChanged                 = { link='Blue' },
      diffOldFile                 = { link='Yellow' },
      diffNewFile                 = { link='Orange' },
      diffFile                    = { link='Cyan' },
      diffLine                    = { link='Grey' },
      diffIndexLine               = { link='Purple' },

      helpCommand                 = { link='Cyan' },
      helpExample                 = { link='Green' },
      helpHeader                  = { fg=palette.orange,     bg=palette.none, bold=true },
      helpHeadline                = { fg=palette.red,        bg=palette.none, bold=true },
      helpHyperTextEntry          = { fg=palette.yellow,     bg=palette.none, bold=true },
      helpHyperTextJump           = { link='Yellow' },
      helpNote                    = { fg=palette.purple,     bg=palette.none, bold=true },
      helpSectionDelim            = { link='Grey' },
      helpSpecial                 = { link='Blue' },
      helpURL                     = { fg=palette.green,      bg=palette.none, underline=true },

      lCursor                     = { sp=palette.orange,     bg=palette.none, underline=true },

      netrwClassify               = { link='Green' },
      netrwCmdSep                 = { link='Grey' },
      netrwComment                = { link='Grey' },
      netrwDir                    = { link='Green' },
      netrwExe                    = { link='Yellow' },
      netrwHelpCmd                = { link='Blue' },
      netrwLink                   = { link='Grey' },
      netrwList                   = { link='Cyan' },
      netrwSymLink                = { link='Fg' },
      netrwVersion                = { link='Orange' },

      Annotation                  = { fg=palette.light_yellow, bold=true },
      Attribute                   = { fg=palette.light_yellow, bold=true },
      Boolean                     = { fg=palette.purple,     bg=palette.none },
      Character                   = { fg=palette.green,      bg=palette.none },
      ColorColumn                 = { fg=palette.none,       bg=palette.bg1 },
      Comment                     = { fg=palette.light_grey, bg=palette.none, italic=true },
      Conceal                     = { fg=palette.grey,       bg=palette.none },
      Conditional                 = { fg=palette.red,        bg=palette.none, bold=true },
      Constant                    = { fg=palette.cyan,       bg=palette.none, bold=true },
      Cursor                      = { fg=palette.none,       bg=palette.none, reverse=true },
      CursorColumn                = { fg=palette.none,       bg=palette.bg0 },
      CursorIM                    = { fg=palette.none,       bg=palette.fg },
      CursorLine                  = { fg=palette.none,       bg=palette.bg1 },
      CursorLineNr                = { fg=palette.fg,         bg=palette.bg1 },
      Debug                       = { fg=palette.yellow,     bg=palette.none },
      Define                      = { fg=palette.purple,     bg=palette.none, italic=true },
      Delimiter                   = { fg=palette.fg,         bg=palette.none },

      -- DiagnosticDeprecated        = { link='' },
      DiagnosticError             = { fg=palette.red },
      DiagnosticFloatingError     = { link='DiagnosticError' },
      DiagnosticFloatingHint      = { link='DiagnosticHint' },
      DiagnosticFloatingInfo      = { link='DiagnosticInfo' },
      DiagnosticFloatingOk        = { link='DiagnosticOk' },
      DiagnosticFloatingWarn      = { link='DiagnosticWarn' },
      DiagnosticHint              = { fg=palette.purple},
      DiagnosticInfo              = { fg=palette.blue},
      DiagnosticOk                = { fg=palette.green },
      DiagnosticSignError         = { link='DiagnosticError' },
      DiagnosticSignHint          = { link='DiagnosticHint' },
      DiagnosticSignInfo          = { link='DiagnosticInfo' },
      DiagnosticSignOk            = { link='DiagnosticOk' },
      DiagnosticSignWarn          = { link='DiagnosticWarn' },
      DiagnosticUnderlineError    = { sp=palette.red , undercurl=true },
      DiagnosticUnderlineHint     = { sp=palette.purple, undercurl=true },
      DiagnosticUnderlineInfo     = { sp=palette.blue, undercurl=true },
      DiagnosticUnderlineOk       = { sp=palette.green , undercurl=true },
      DiagnosticUnderlineWarn     = { sp=palette.orange, undercurl=true },
      -- DiagnosticUnnecessary       = { link='' },
      -- DiagnosticVirtualLinesError = { link='' },
      -- DiagnosticVirtualLinesHint  = { link='' },
      -- DiagnosticVirtualLinesInfo  = { link='' },
      -- DiagnosticVirtualLinesOk    = { link='' },
      -- DiagnosticVirtualLinesWarn  = { link='' },
      DiagnosticVirtualTextError  = { fg=palette.red , bg=palette.bg },
      DiagnosticVirtualTextHint   = { fg=palette.purple, bg=palette.bg },
      DiagnosticVirtualTextInfo   = { fg=palette.blue, bg=palette.bg },
      DiagnosticVirtualTextOk     = { fg=palette.green , bg=palette.bg },
      DiagnosticVirtualTextWarn   = { fg=palette.orange, bg=palette.bg },
      DiagnosticWarn              = { fg=palette.orange},

      DiffAdd                     = { fg=palette.none,       bg=palette.bg_green },
      -- DiffAddedGutter             = { link='' },
      DiffChange                  = { fg=palette.none,       bg=palette.bg_blue },
      DiffDelete                  = { fg=palette.none,       bg=palette.bg_red },
      -- DiffModifiedGutter          = { link='' },
      -- DiffRemovedGutter           = { link='' },
      DiffText                    = { fg=palette.none,       bg=palette.bg0, reverse=true },

      Directory                   = { fg=palette.green,      bg=palette.none },
      EndOfBuffer                 = { fg=palette.bg0,        bg=palette.bg0 },
      Error                       = { fg=palette.red,        bg=palette.none },
      ErrorMsg                    = { fg=palette.red,        bg=palette.none, bold=true, underline=true },
      Exception                   = { fg=palette.red,        bg=palette.none, italic=true },
      Float                       = { fg=palette.purple,     bg=palette.none },
      FoldColumn                  = { fg=palette.grey,       bg=palette.bg1 },
      Folded                      = { fg=palette.grey,       bg=palette.bg1 },
      Function                    = { fg=palette.green,      bg=palette.none, bold=true },
      Identifier                  = { fg=palette.blue,       bg=palette.none },
      Ignore                      = { fg=palette.grey,       bg=palette.none },
      IncSearch                   = { fg=palette.none,       bg=palette.none, reverse=true },
      Include                     = { fg=palette.purple,     bg=palette.none, italic=true },
      Keyword                     = { fg=palette.red,        bg=palette.none, italic=true },
      Label                       = { fg=palette.orange,     bg=palette.none },
      LineNr                      = { fg=palette.grey,       bg=palette.bg0 },
      Macro                       = { fg=palette.cyan,       bg=palette.none },
      MatchParen                  = { fg=palette.none,       bg=palette.none, bold=true, underline=true },
      ModeMsg                     = { fg=palette.fg,         bg=palette.none, bold=true },
      MoreMsg                     = { fg=palette.blue,       bg=palette.none, bold=true },
      NonText                     = { fg=palette.grey,       bg=palette.none },
      Normal                      = { fg=palette.fg,         bg=palette.bg0 },
      Number                      = { fg=palette.purple,     bg=palette.none },
      Operator                    = { fg=palette.orange,     bg=palette.none },
      Pmenu                       = { fg=palette.fg,         bg=palette.bg2 },
      PmenuSbar                   = { fg=palette.none,       bg=palette.bg2 },
      PmenuSel                    = { fg=palette.bg0,        bg=palette.fg },
      PmenuThumb                  = { fg=palette.none,       bg=palette.grey },
      PreCondit                   = { fg=palette.purple,     bg=palette.none, italic=true },
      PreProc                     = { fg=palette.purple,     bg=palette.none, italic=true },
      Question                    = { fg=palette.yellow,     bg=palette.none },
      QuickFixLine                = { fg=palette.blue,       bg=palette.bg1 },
      Repeat                      = { fg=palette.red,        bg=palette.none, bold=true },
      Search                      = { fg=palette.bg0,        bg=palette.red },
      SignColumn                  = { fg=palette.fg,         bg=palette.bg0 },
      SnippetTabstop              = { link='Visual' },
      Special                     = { fg=palette.yellow,     bg=palette.none },
      SpecialChar                 = { fg=palette.yellow,     bg=palette.none },
      SpecialComment              = { fg=palette.light_grey, bg=palette.none, italic=true },
      SpecialKey                  = { fg=palette.blue,       bg=palette.none },
      SpellBad                    = { fg=palette.red,        bg=palette.none, undercurl=true, sp=palette.red },
      SpellCap                    = { fg=palette.yellow,     bg=palette.none, undercurl=true, sp=palette.yellow },
      SpellLocal                  = { fg=palette.blue,       bg=palette.none, undercurl=true, sp=palette.blue },
      SpellRare                   = { fg=palette.purple,     bg=palette.none, undercurl=true, sp=palette.purple },
      Statement                   = { fg=palette.red,        bg=palette.none, italic=true },
      StatusLine                  = { fg=palette.fg,         bg=palette.bg3 },
      StatusLineNC                = { fg=palette.grey,       bg=palette.bg1 },
      StatusLineTerm              = { fg=palette.fg,         bg=palette.bg3 },
      StatusLineTermNC            = { fg=palette.grey,       bg=palette.bg1 },
      StorageClass                = { fg=palette.orange,     bg=palette.none, bold=true },
      String                      = { fg=palette.green,      bg=palette.none },
      Structure                   = { fg=palette.orange,     bg=palette.none },
      TabLine                     = { fg=palette.fg,         bg=palette.bg4 },
      TabLineFill                 = { fg=palette.grey,       bg=palette.bg1 },
      TabLineSel                  = { fg=palette.bg0,        bg=palette.green },
      Tag                         = { fg=palette.orange,     bg=palette.none },
      Terminal                    = { fg=palette.fg,         bg=palette.bg0 },
      Title                       = { fg=palette.orange,     bg=palette.none, bold=true },
      Todo                        = { fg=palette.purple,     bg=palette.none, italic=true },
      ToolbarButton               = { fg=palette.fg,         bg=palette.bg0, bold=true },
      ToolbarLine                 = { fg=palette.none,       bg=palette.grey },
      Type                        = { fg=palette.yellow,     bg=palette.none, bold=true },
      Typedef                     = { fg=palette.red,        bg=palette.none, italic=true },
      Underlined                  = { fg=palette.none,       bg=palette.none, underline=true },
      VertSplit                   = { fg=palette.light_grey, bg=palette.none },
      Visual                      = { fg=palette.bg0,        bg=palette.light_yellow },
      VisualNOS                   = { fg=palette.bg0,        bg=palette.light_yellow, underline=true },
      WarningMsg                  = { fg=palette.yellow,     bg=palette.none, bold=true },
      WildMenu                    = { fg=palette.bg0,        bg=palette.fg },
      WinBar                      = { fg=palette.bg4,        bg=palette.bg4, bold=true },
      WinBarNC                    = { fg=palette.bg4,        bg=palette.bg4, bold=true },
      WinSeparator                = { link='VertSplit' },

      ['@annotation']                         = { link='Annotation' },
      ['@attribute']                          = { link='Attribute' },     -- attribute annotations (e.g. Python decorators, Rust lifetimes)
      ['@attribute.builtin']                  = { link='Attribute' },     -- builtin annotations (e.g. @property in Python)
      ['@boolean']                            = { link='Boolean' },       -- boolean literals
      ['@character']                          = { link='Character' },     -- character literals
      ['@character.special']                  = { link='SpecialChar' },   -- special characters (e.g. wildcards)
      ['@comment']                            = { link='Comment' },       -- line and block comments
      ['@comment.documentation']              = { link='Comment' },       -- comments documenting code
      ['@comment.error']                      = { link='DiagnosticUnderlineError' }, -- error-type comments (e.g. ERROR, FIXME, DEPRECATED)
      ['@comment.note']                       = { link='DiagnosticInfo' },  -- note-type comments (e.g. NOTE, INFO, XXX)
      ['@comment.todo']                       = { link='DiagnosticHint' },   -- todo-type comments (e.g. TODO, WIP)
      ['@comment.warning']                    = { link='DiagnosticWarn' },  -- warning-type comments (e.g. WARNING, FIX, HACK)
      ['@conditional']                        = { link='Conditional' },
      ['@constant']                           = { link='Constant' },      -- constant identifiers
      ['@constant.builtin']                   = { link='Special' },       -- built-in constant values
      ['@constant.macro']                     = { link='Define' },        -- constants defined by the preprocessor
      ['@constructor']                        = { link='Special' },       -- constructor calls and definitions
      ['@debug']                              = { link='Debug' },
      ['@define']                             = { link='Define' },
      ['@diff']                               = { link='diffChanged' },
      ['@diff.delta']                         = { link='diffChanged' },   -- changed text (for diff files)
      ['@diff.minus']                         = { link='diffRemoved' },   -- deleted text (for diff files)
      ['@diff.plus']                          = { link='diffAdded' },     -- added text (for diff files)
      ['@error']                              = { link='Error' },
      ['@exception']                          = { link='Exception' },
      ['@field']                              = { link='Identifier' },
      ['@float']                              = { link='Float' },
      ['@function']                           = { link='Function' },      -- function definitions
      ['@function.builtin']                   = { link='Special' },       -- built-in functions
      ['@function.call']                      = { link='Green' },         -- function calls
      ['@function.macro']                     = { link='Macro' },         -- preprocessor macros
      ['@function.method']                    = { link='Function' },      -- method definitions
      ['@function.method.call']               = { link='Function' },      -- method calls
      ['@include']                            = { link='Include' },
      ['@keyword']                            = { link='Keyword' },       -- keywords not fitting into specific categories
      ['@keyword.conditional']                = { link='Conditional' },   -- keywords related to conditionals (e.g. if, else)
      ['@keyword.conditional.ternary']        = { link='Conditional' },   -- ternary operator (e.g. ?, :)
      ['@keyword.coroutine']                  = { link='Keyword' },       -- keywords related to coroutines (e.g. go in Go, async/await in Python)
      ['@keyword.debug']                      = { link='Keyword' },       -- keywords related to debugging
      ['@keyword.directive']                  = { link='Keyword' },       -- various preprocessor directives and shebangs
      ['@keyword.directive.define']           = { link='Keyword' },       -- preprocessor definition directives
      ['@keyword.exception']                  = { link='Keyword' },       -- keywords related to exceptions (e.g. throw, catch)
      ['@keyword.function']                   = { link='Keyword' },       -- keywords that define a function (e.g. func in Go, def in Python)
      ['@keyword.import']                     = { link='Keyword' },       -- keywords for including modules (e.g. import, from in Python)
      ['@keyword.modifier']                   = { link='Keyword' },       -- keywords defining type modifiers (e.g. const, static, public)
      ['@keyword.operator']                   = { link='Keyword' },       -- operators that are English words (e.g. and, or)
      ['@keyword.repeat']                     = { link='Keyword' },       -- keywords related to loops (e.g. for, while)
      ['@keyword.return']                     = { link='Keyword' },       -- keywords like return and yield
      ['@keyword.type']                       = { link='Keyword' },       -- keywords defining composite types (e.g. struct, enum)
      ['@label']                              = { link='Label' },         -- GOTO and other labels (e.g. label: in C), including heredoc labels
      -- ['@lsp']                                = { link='' },
      -- ['@lsp.mod.deprecated']                 = { link='' },
      -- ['@lsp.type.class']                     = { link='' },
      -- ['@lsp.type.comment']                   = { link='' },
      -- ['@lsp.type.decorator']                 = { link='' },
      -- ['@lsp.type.enum']                      = { link='' },
      -- ['@lsp.type.enumMember']                = { link='' },
      -- ['@lsp.type.event']                     = { link='' },
      -- ['@lsp.type.function']                  = { link='' },
      -- ['@lsp.type.interface']                 = { link='' },
      -- ['@lsp.type.keyword']                   = { link='' },
      -- ['@lsp.type.macro']                     = { link='' },
      -- ['@lsp.type.method']                    = { link='' },
      -- ['@lsp.type.modifier']                  = { link='' },
      -- ['@lsp.type.namespace']                 = { link='' },
      -- ['@lsp.type.number']                    = { link='' },
      -- ['@lsp.type.operator']                  = { link='' },
      -- ['@lsp.type.parameter']                 = { link='' },
      -- ['@lsp.type.property']                  = { link='' },
      -- ['@lsp.type.regexp']                    = { link='' },
      -- ['@lsp.type.string']                    = { link='' },
      -- ['@lsp.type.struct']                    = { link='' },
      -- ['@lsp.type.type']                      = { link='' },
      -- ['@lsp.type.typeParameter']             = { link='' },
      -- ['@lsp.type.variable']                  = { link='' },
      ['@macro']                              = { link='Macro' },
      -- ['@markup']                             = { link='' },
      -- ['@markup.heading']                     = { link='' },              -- headings, titles (including markers)
      -- ['@markup.heading.1']                   = { link='' },              -- top-level heading
      -- ['@markup.heading.1.delimiter.vimdoc']  = { link='' },
      -- ['@markup.heading.2']                   = { link='' },              -- section heading
      -- ['@markup.heading.2.delimiter.vimdoc']  = { link='' },
      -- ['@markup.heading.3']                   = { link='' },              -- subsection heading
      -- ['@markup.heading.4']                   = { link='' },              -- and so on
      -- ['@markup.heading.5']                   = { link='' },              -- and so forth
      -- ['@markup.heading.6']                   = { link='' },              -- six levels ought to be enough for anybody
      -- ['@markup.italic']                      = { link='' },              -- italic text
      -- ['@markup.link']                        = { link='' },              -- text references, footnotes, citations, etc.
      -- ['@markup.link.label']                  = { link='' },              -- link, reference descriptions
      -- ['@markup.link.url']                    = { link='' },              -- URL-style links
      -- ['@markup.list']                        = { link='' },              -- list markers
      -- ['@markup.list.checked']                = { link='' },              -- checked todo-style list markers
      -- ['@markup.list.unchecked']              = { link='' },              -- unchecked todo-style list markers
      -- ['@markup.math']                        = { link='' },              -- math environments (e.g. $ ... $ in LaTeX)
      -- ['@markup.quote']                       = { link='' },              -- block quotes
      -- ['@markup.raw']                         = { link='' },              -- literal or verbatim text (e.g. inline code)
      -- ['@markup.raw.block']                   = { link='' },              -- literal or verbatim text as a stand-alone block
      -- ['@markup.strikethrough']               = { link='' },              -- struck-through text
      -- ['@markup.strong']                      = { link='' },              -- bold text
      -- ['@markup.underline']                   = { link='' },              -- underlined text (only for literal underline markup!)
      ['@method']                             = { link='Function' },
      -- ['@module']                             = { link='' },              -- modules or namespaces
      -- ['@module.builtin']                     = { link='' },              -- built-in modules or namespaces
      ['@namespace']                          = { link='Identifier' },
      ['@number']                             = { link='Number' },        -- numeric literals
      -- ['@number.float']                       = { link='' },              -- floating-point number literals
      ['@operator']                           = { link='Operator' },      -- symbolic operators (e.g. +, *)
      ['@parameter']                          = { link='Identifier' },
      ['@preproc']                            = { link='PreProc' },
      ['@property']                           = { link='Identifier' },    -- the key in key/value pairs
      ['@punctuation']                        = { link='Delimiter' },
      ['@punctuation.bracket']                = { link='Special' },       -- brackets (e.g. (), {}, [])
      -- ['@punctuation.delimiter']              = { link='' },              -- delimiters (e.g. ;, ., ,)
      -- ['@punctuation.special']                = { link='' },              -- special symbols (e.g. {} in string interpolation)
      ['@repeat']                             = { link='Repeat' },
      ['@spell']                              = { link='cleared' },
      ['@storageclass']                       = { link='StorageClass' },
      ['@string']                             = { link='String' },        -- string literals
      -- ['@string.documentation']               = { link='' },           -- string documenting code (e.g. Python docstrings)
      ['@string.escape']                      = { link='SpecialChar' },   -- escape sequences
      -- ['@string.regexp']                      = { link='' },              -- regular expressions
      ['@string.special']                     = { link='SpecialChar' },   -- other special strings (e.g. dates)
      -- ['@string.special.path']                = { link='' },              -- filenames
      -- ['@string.special.symbol']              = { link='' },              -- symbols or atoms
      -- ['@string.special.url']                 = { link='' },              -- URIs (e.g. hyperlinks)
      -- ['@string.special.url']                 = { link='' },
      ['@structure']                          = { link='Structure' },
      ['@tag']                                = { link='Tag' },           -- XML-style tag names (e.g. in XML, HTML, etc.)
      -- ['@tag.attribute']                      = { link='' },              -- XML-style tag attributes
      -- ['@tag.builtin']                        = { link='' },              -- XML-style tag names (e.g. HTML5 tags)
      -- ['@tag.delimiter']                      = { link='' },              -- XML-style tag delimiters
      ['@text']                               = { link='Normal' },
      ['@text.literal']                       = { link='Comment' },
      ['@text.reference']                     = { link='Identifier' },
      ['@text.title']                         = { link='Title' },
      ['@text.todo']                          = { link='Todo' },
      ['@text.underline']                     = { link='Underlined' },
      ['@text.uri']                           = { link='Underlined' },
      ['@type']                               = { link='Type' },          -- type or class definitions and annotations
      -- ['@type.builtin']                       = { link='' },              -- built-in types
      ['@type.definition']                    = { link='Typedef' },       -- identifiers in type definitions (e.g. typedef <type> <identifier> in C)
      ['@variable']                           = { link='Identifier' },    -- various variable names
      -- ['@variable.builtin']                   = { link='' },              -- built-in variable names (e.g. this, self)
      -- ['@variable.member']                    = { link='' },              -- object and struct fields
      -- ['@variable.parameter']                 = { link='' },              -- parameters of a function
      -- ['@variable.parameter.builtin']         = { link='' },              -- special parameters (e.g. _, it)

      -- ['GitGutterAdd']  = { link='' },
      -- ['GitGutterAddLine']  = { link='' },
      -- ['GitGutterAddLineNr']  = { link='' },
      -- ['GitGutterChange']  = { link='' },
      -- ['GitGutterChangeLine']  = { link='' },
      -- ['GitGutterChangeLineNr']  = { link='' },
      -- ['GitGutterDelete']  = { link='' },
      -- ['GitGutterDeleteLine']  = { link='' },
      -- ['GitGutterDeleteLineNr']  = { link='' },
      -- ['GitSignsAdd']  = { link='' },
      -- ['GitSignsAddCul']  = { link='' },
      -- ['GitSignsAddInline']  = { link='' },
      -- ['GitSignsAddLn']  = { link='' },
      -- ['GitSignsAddLnInline']  = { link='' },
      -- ['GitSignsAddNr']  = { link='' },
      -- ['GitSignsAddPreview']  = { link='' },
      -- ['GitSignsChange']  = { link='' },
      -- ['GitSignsChangeCul']  = { link='' },
      -- ['GitSignsChangeInline']  = { link='' },
      -- ['GitSignsChangeLn']  = { link='' },
      -- ['GitSignsChangeLnInline']  = { link='' },
      -- ['GitSignsChangeNr']  = { link='' },
      -- ['GitSignsChangedelete']  = { link='' },
      -- ['GitSignsChangedeleteCul']  = { link='' },
      -- ['GitSignsChangedeleteLn']  = { link='' },
      -- ['GitSignsChangedeleteNr']  = { link='' },
      -- ['GitSignsCurrentLineBlame']  = { link='' },
      -- ['GitSignsDelete']  = { link='' },
      -- ['GitSignsDeleteCul']  = { link='' },
      -- ['GitSignsDeleteInline']  = { link='' },
      -- ['GitSignsDeleteLn']  = { link='' },
      -- ['GitSignsDeleteLnInline']  = { link='' },
      -- ['GitSignsDeleteNr']  = { link='' },
      -- ['GitSignsDeletePreview']  = { link='' },
      -- ['GitSignsDeleteVirtLn']  = { link='' },
      -- ['GitSignsDeleteVirtLnInLine']  = { link='' },
      -- ['GitSignsStagedAdd']  = { link='' },
      -- ['GitSignsStagedAddCul']  = { link='' },
      -- ['GitSignsStagedAddLn']  = { link='' },
      -- ['GitSignsStagedAddNr']  = { link='' },
      -- ['GitSignsStagedChange']  = { link='' },
      -- ['GitSignsStagedChangeCul']  = { link='' },
      -- ['GitSignsStagedChangeLn']  = { link='' },
      -- ['GitSignsStagedChangeNr']  = { link='' },
      -- ['GitSignsStagedChangedelete']  = { link='' },
      -- ['GitSignsStagedChangedeleteCul']  = { link='' },
      -- ['GitSignsStagedChangedeleteLn']  = { link='' },
      -- ['GitSignsStagedChangedeleteNr']  = { link='' },
      -- ['GitSignsStagedDelete']  = { link='' },
      -- ['GitSignsStagedDeleteCul']  = { link='' },
      -- ['GitSignsStagedDeleteNr']  = { link='' },
      -- ['GitSignsStagedTopdelete']  = { link='' },
      -- ['GitSignsStagedTopdeleteCul']  = { link='' },
      -- ['GitSignsStagedTopdeleteLn']  = { link='' },
      -- ['GitSignsStagedTopdeleteNr']  = { link='' },
      -- ['GitSignsStagedUntracked']  = { link='' },
      -- ['GitSignsStagedUntrackedCul']  = { link='' },
      -- ['GitSignsStagedUntrackedLn']  = { link='' },
      -- ['GitSignsStagedUntrackedNr']  = { link='' },
      -- ['GitSignsTopdelete']  = { link='' },
      -- ['GitSignsTopdeleteCul']  = { link='' },
      -- ['GitSignsTopdeleteLn']  = { link='' },
      -- ['GitSignsTopdeleteNr']  = { link='' },
      -- ['GitSignsUntracked']  = { link='' },
      -- ['GitSignsUntrackedCul']  = { link='' },
      -- ['GitSignsUntrackedLn']  = { link='' },
      -- ['GitSignsUntrackedNr']  = { link='' },
      -- ['GitSignsVirtLnum']  = { link='' },

      ['LspCodeLens']  = { link='' },
      ['LspCodeLensSeparator']  = { link='' },
      ['LspInlayHint']  = { link='' },
      ['LspReferenceRead']  = { link='' },
      ['LspReferenceTarget']  = { link='' },
      ['LspReferenceText']  = { link='' },
      ['LspReferenceWrite']  = { link='' },
      ['LspSignatureActiveParameter']  = { link='' },

      GitSignsCurrentLineBlame    = { link='NonText' },
      GitSignsAdd                 = { fg=palette.green },
      GitSignsAddInline           = { fg=palette.green },
      GitSignsAddLn               = { fg=palette.green },
      GitSignsAddNr               = { fg=palette.green },
      GitSignsAddPreview          = { link='DiffAdd' },
      GitSignsChange              = { fg=palette.blue },
      GitSignsChangeInline        = { link='DiffChange' },
      GitSignsChangeLn            = { fg=palette.blue },
      GitSignsChangeNr            = { fg=palette.blue },
      GitSignsDelete              = { fg=palette.red },
      GitSignsDeleteInline        = { fg=palette.red },
      GitSignsDeleteNr            = { fg=palette.red },
      GitSignsDeletePreview       = { link='DiffDelete' },
      GitSignsDeleteVirtLn        = { link='DiffDelete' },

      TelescopeMatching           = { bold=true },
    }

    for group, config in pairs(highlight_groups) do
      highlight(0, group, config)
    end

    if override ~= nil then
      for group, config in pairs(override) do
        highlight(0, group, config)
      end
    end
  end
};
