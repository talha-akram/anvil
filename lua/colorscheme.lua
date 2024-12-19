local highlight = vim.api.nvim_set_hl;

return {
  from_palette = function(palette, override)
    local highlight_groups = {
      Fg                          = { fg=palette.fg,         bg=palette.none },
      Grey                        = { fg=palette.grey,       bg=palette.none },
      Yellow                      = { fg=palette.yellow,     bg=palette.none },
      Blue                        = { fg=palette.blue,       bg=palette.none },
      RedItalic                   = { fg=palette.red,        bg=palette.none, italic=true },
      OrangeItalic                = { fg=palette.orange,     bg=palette.none, italic=true },
      PurpleItalic                = { fg=palette.purple,     bg=palette.none, italic=true },
      Red                         = { fg=palette.red,        bg=palette.none },
      Orange                      = { fg=palette.orange,     bg=palette.none },
      Purple                      = { fg=palette.purple,     bg=palette.none },
      Green                       = { fg=palette.green,      bg=palette.none },
      Cyan                        = { fg=palette.cyan,       bg=palette.none },

      RedSign                     = { fg=palette.red,        bg=palette.bg1 },
      OrangeSign                  = { fg=palette.orange,     bg=palette.bg1 },
      YellowSign                  = { fg=palette.yellow,     bg=palette.bg1 },
      GreenSign                   = { fg=palette.green,      bg=palette.bg1 },
      CyanSign                    = { fg=palette.cyan,       bg=palette.bg1 },
      BlueSign                    = { fg=palette.blue,       bg=palette.bg1 },
      PurpleSign                  = { fg=palette.purple,     bg=palette.bg1 },

      Normal                      = { fg=palette.fg,         bg=palette.bg0 },
      Terminal                    = { fg=palette.fg,         bg=palette.bg0 },
      EndOfBuffer                 = { fg=palette.bg0,        bg=palette.bg0 },
      FoldColumn                  = { fg=palette.grey,       bg=palette.bg1 },
      Folded                      = { fg=palette.grey,       bg=palette.bg1 },
      SignColumn                  = { fg=palette.fg,         bg=palette.bg0 },
      ColorColumn                 = { fg=palette.none,       bg=palette.bg1 },
      Conceal                     = { fg=palette.grey,       bg=palette.none },
      Cursor                      = { fg=palette.none,       bg=palette.none, reverse=true },
      lCursor                     = { sp=palette.orange,     bg=palette.none, underline=true },
      CursorColumn                = { fg=palette.none,       bg=palette.bg1 },
      CursorLine                  = { fg=palette.none,       bg=palette.bg1 },
      LineNr                      = { fg=palette.grey,       bg=palette.bg1 },
      CursorLineNr                = { fg=palette.fg,         bg=palette.bg1 },
      DiffAdd                     = { fg=palette.none,       bg=palette.bg_green },
      DiffChange                  = { fg=palette.none,       bg=palette.bg_blue },
      DiffDelete                  = { fg=palette.none,       bg=palette.bg_red },
      DiffText                    = { fg=palette.none,       bg=palette.bg0, reverse=true },
      Directory                   = { fg=palette.green,      bg=palette.none },
      ErrorMsg                    = { fg=palette.red,        bg=palette.none, bold=true, underline=true },
      WarningMsg                  = { fg=palette.yellow,     bg=palette.none, bold=true },
      ModeMsg                     = { fg=palette.fg,         bg=palette.none, bold=true },
      MoreMsg                     = { fg=palette.blue,       bg=palette.none, bold=true },
      IncSearch                   = { fg=palette.none,       bg=palette.none, reverse=true },
      Search                      = { fg=palette.bg0,        bg=palette.red },
      MatchParen                  = { fg=palette.none,       bg=palette.none, bold=true, underline=true },
      NonText                     = { fg=palette.grey,       bg=palette.none },
      Pmenu                       = { fg=palette.fg,         bg=palette.bg2 },
      PmenuSbar                   = { fg=palette.none,       bg=palette.bg2 },
      PmenuThumb                  = { fg=palette.none,       bg=palette.grey },
      PmenuSel                    = { fg=palette.bg0,        bg=palette.fg },
      WildMenu                    = { fg=palette.bg0,        bg=palette.fg },
      Question                    = { fg=palette.yellow,     bg=palette.none },
      SpellBad                    = { fg=palette.red,        bg=palette.none, undercurl=true, sp=palette.red },
      SpellCap                    = { fg=palette.yellow,     bg=palette.none, undercurl=true, sp=palette.yellow },
      SpellLocal                  = { fg=palette.blue,       bg=palette.none, undercurl=true, sp=palette.blue },
      SpellRare                   = { fg=palette.purple,     bg=palette.none, undercurl=true, sp=palette.purple },
      StatusLine                  = { fg=palette.fg,         bg=palette.bg3 },
      StatusLineTerm              = { fg=palette.fg,         bg=palette.bg3 },
      StatusLineNC                = { fg=palette.grey,       bg=palette.bg1 },
      StatusLineTermNC            = { fg=palette.grey,       bg=palette.bg1 },
      TabLine                     = { fg=palette.fg,         bg=palette.bg4 },
      TabLineFill                 = { fg=palette.grey,       bg=palette.bg1 },
      TabLineSel                  = { fg=palette.bg0,        bg=palette.green },
      VertSplit                   = { fg=palette.light_grey, bg=palette.none },
      Visual                      = { fg=palette.bg0,        bg=palette.light_yellow },
      VisualNOS                   = { fg=palette.bg0,        bg=palette.light_yellow, underline=true },
      CursorIM                    = { fg=palette.none,       bg=palette.fg },
      ToolbarLine                 = { fg=palette.none,       bg=palette.grey },
      ToolbarButton               = { fg=palette.fg,         bg=palette.bg0, bold=true },
      QuickFixLine                = { fg=palette.blue,       bg=palette.bg1 },
      Underlined                  = { fg=palette.none,       bg=palette.none, underline=true },
      Ignore                      = { fg=palette.grey,       bg=palette.none },
      WinBar                      = { fg=palette.bg4,        bg=palette.bg4, bold=true },
      WinBarNC                    = { fg=palette.bg4,        bg=palette.bg4, bold=true },
      WinSeparator                = { link='VertSplit' },

      helpNote                    = { fg=palette.purple,     bg=palette.none, bold=true },
      helpHeadline                = { fg=palette.red,        bg=palette.none, bold=true },
      helpHeader                  = { fg=palette.orange,     bg=palette.none, bold=true },
      helpURL                     = { fg=palette.green,      bg=palette.none, underline=true },
      helpHyperTextEntry          = { fg=palette.yellow,     bg=palette.none, bold=true },
      helpHyperTextJump           = { link='Yellow' },
      helpCommand                 = { link='Cyan' },
      helpExample                 = { link='Green' },
      helpSpecial                 = { link='Blue' },
      helpSectionDelim            = { link='Grey' },

      netrwDir                    = { link='Green' },
      netrwClassify               = { link='Green' },
      netrwLink                   = { link='Grey' },
      netrwSymLink                = { link='Fg' },
      netrwExe                    = { link='Yellow' },
      netrwComment                = { link='Grey' },
      netrwList                   = { link='Cyan' },
      netrwHelpCmd                = { link='Blue' },
      netrwCmdSep                 = { link='Grey' },
      netrwVersion                = { link='Orange' },

      DiagnosticError             = { fg=palette.red },
      DiagnosticHint              = { fg=palette.purple},
      DiagnosticInfo              = { fg=palette.blue},
      DiagnosticWarn              = { fg=palette.orange},
      DiagnosticFloatingError     = { link='DiagnosticError' },
      DiagnosticFloatingHint      = { link='DiagnosticHint' },
      DiagnosticFloatingInfo      = { link='DiagnosticInfo' },
      DiagnosticFloatingWarn      = { link='DiagnosticWarn' },
      DiagnosticSignError         = { link='DiagnosticError' },
      DiagnosticSignHint          = { link='DiagnosticHint' },
      DiagnosticSignInfo          = { link='DiagnosticInfo' },
      DiagnosticSignWarn          = { link='DiagnosticWarn' },
      DiagnosticUnderlineError    = { sp=palette.red , undercurl=true },
      DiagnosticUnderlineHint     = { sp=palette.purple, undercurl=true },
      DiagnosticUnderlineInfo     = { sp=palette.blue, undercurl=true },
      DiagnosticUnderlineWarn     = { sp=palette.orange, undercurl=true },
      DiagnosticVirtualTextError  = { fg=palette.red , bg=palette.bg },
      DiagnosticVirtualTextHint   = { fg=palette.purple, bg=palette.bg },
      DiagnosticVirtualTextInfo   = { fg=palette.blue, bg=palette.bg },
      DiagnosticVirtualTextWarn   = { fg=palette.orange, bg=palette.bg },

      Annotation                  = { fg=palette.light_yellow, bold=true },
      Attribute                   = { fg=palette.light_yellow, bold=true },
      Boolean                     = { fg=palette.purple,     bg=palette.none },
      Number                      = { fg=palette.purple,     bg=palette.none },
      Float                       = { fg=palette.purple,     bg=palette.none },
      PreProc                     = { fg=palette.purple,     bg=palette.none, italic=true },
      PreCondit                   = { fg=palette.purple,     bg=palette.none, italic=true },
      Include                     = { fg=palette.purple,     bg=palette.none, italic=true },
      Define                      = { fg=palette.purple,     bg=palette.none, italic=true },
      Conditional                 = { fg=palette.red,        bg=palette.none, bold=true },
      Repeat                      = { fg=palette.red,        bg=palette.none, bold=true },
      Keyword                     = { fg=palette.red,        bg=palette.none, italic=true },
      Typedef                     = { fg=palette.red,        bg=palette.none, italic=true },
      Exception                   = { fg=palette.red,        bg=palette.none, italic=true },
      Statement                   = { fg=palette.red,        bg=palette.none, italic=true },
      StorageClass                = { fg=palette.orange,     bg=palette.none, bold=true },
      Title                       = { fg=palette.orange,     bg=palette.none, bold=true },
      Type                        = { fg=palette.yellow,     bg=palette.none, bold=true },
      Function                    = { fg=palette.green,      bg=palette.none, bold=true },
      Constant                    = { fg=palette.cyan,       bg=palette.none, bold=true },
      Error                       = { fg=palette.red,        bg=palette.none },
      Tag                         = { fg=palette.orange,     bg=palette.none },
      Label                       = { fg=palette.orange,     bg=palette.none },
      Structure                   = { fg=palette.orange,     bg=palette.none },
      Operator                    = { fg=palette.orange,     bg=palette.none },
      Special                     = { fg=palette.yellow,     bg=palette.none },
      SpecialChar                 = { fg=palette.yellow,     bg=palette.none },
      Character                   = { fg=palette.green,      bg=palette.none },
      Macro                       = { fg=palette.cyan,       bg=palette.none },
      Identifier                  = { fg=palette.blue,       bg=palette.none },
      SpecialKey                  = { fg=palette.blue,       bg=palette.none },
      String                      = { fg=palette.green,      bg=palette.none },
      Comment                     = { fg=palette.light_grey, bg=palette.none, italic=true },
      SpecialComment              = { fg=palette.light_grey, bg=palette.none, italic=true },
      Todo                        = { fg=palette.purple,     bg=palette.none, italic=true },
      Delimiter                   = { fg=palette.fg,         bg=palette.none },
      Debug                       = { fg=palette.yellow,     bg=palette.none },

      diffAdded                   = { link='Green' },
      diffRemoved                 = { link='Red' },
      diffChanged                 = { link='Blue' },
      diffOldFile                 = { link='Yellow' },
      diffNewFile                 = { link='Orange' },
      diffFile                    = { link='Cyan' },
      diffLine                    = { link='Grey' },
      diffIndexLine               = { link='Purple' },
      -- SnippetTabstop.

      -- @variable                       various variable names
      -- @variable.builtin               built-in variable names (e.g. this, self)
      -- @variable.parameter             parameters of a function
      -- @variable.parameter.builtin     special parameters (e.g. _, it)
      -- @variable.member                object and struct fields
      -- @constant                       constant identifiers
      -- @constant.builtin               built-in constant values
      -- @constant.macro                 constants defined by the preprocessor
      -- @module                         modules or namespaces
      -- @module.builtin                 built-in modules or namespaces
      -- @label                          GOTO and other labels (e.g. label: in C), including heredoc labels
      -- @string                         string literals
      -- @string.documentation           string documenting code (e.g. Python docstrings)
      -- @string.regexp                  regular expressions
      -- @string.escape                  escape sequences
      -- @string.special                 other special strings (e.g. dates)
      -- @string.special.symbol          symbols or atoms
      -- @string.special.path            filenames
      -- @string.special.url             URIs (e.g. hyperlinks)
      -- @character                      character literals
      -- @character.special              special characters (e.g. wildcards)
      -- @boolean                        boolean literals
      -- @number                         numeric literals
      -- @number.float                   floating-point number literals
      -- @type                           type or class definitions and annotations
      -- @type.builtin                   built-in types
      -- @type.definition                identifiers in type definitions (e.g. typedef <type> <identifier> in C)
      -- @attribute                      attribute annotations (e.g. Python decorators, Rust lifetimes)
      -- @attribute.builtin              builtin annotations (e.g. @property in Python)
      -- @property                       the key in key/value pairs
      -- @function                       function definitions
      -- @function.builtin               built-in functions
      -- @function.call                  function calls
      -- @function.macro                 preprocessor macros
      -- @function.method                method definitions
      -- @function.method.call           method calls
      -- @constructor                    constructor calls and definitions
      -- @operator                       symbolic operators (e.g. +, *)
      -- @keyword                        keywords not fitting into specific categories
      -- @keyword.coroutine              keywords related to coroutines (e.g. go in Go, async/await in Python)
      -- @keyword.function               keywords that define a function (e.g. func in Go, def in Python)
      -- @keyword.operator               operators that are English words (e.g. and, or)
      -- @keyword.import                 keywords for including modules (e.g. import, from in Python)
      -- @keyword.type                   keywords defining composite types (e.g. struct, enum)
      -- @keyword.modifier               keywords defining type modifiers (e.g. const, static, public)
      -- @keyword.repeat                 keywords related to loops (e.g. for, while)
      -- @keyword.return                 keywords like return and yield
      -- @keyword.debug                  keywords related to debugging
      -- @keyword.exception              keywords related to exceptions (e.g. throw, catch)
      -- @keyword.conditional            keywords related to conditionals (e.g. if, else)
      -- @keyword.conditional.ternary    ternary operator (e.g. ?, :)
      -- @keyword.directive              various preprocessor directives and shebangs
      -- @keyword.directive.define       preprocessor definition directives
      -- @punctuation.delimiter          delimiters (e.g. ;, ., ,)
      -- @punctuation.bracket            brackets (e.g. (), {}, [])
      -- @punctuation.special            special symbols (e.g. {} in string interpolation)
      -- @comment                        line and block comments
      -- @comment.documentation          comments documenting code
      -- @comment.error                  error-type comments (e.g. ERROR, FIXME, DEPRECATED)
      -- @comment.warning                warning-type comments (e.g. WARNING, FIX, HACK)
      -- @comment.todo                   todo-type comments (e.g. TODO, WIP)
      -- @comment.note                   note-type comments (e.g. NOTE, INFO, XXX)
      -- @markup.strong                  bold text
      -- @markup.italic                  italic text
      -- @markup.strikethrough           struck-through text
      -- @markup.underline               underlined text (only for literal underline markup!)
      -- @markup.heading                 headings, titles (including markers)
      -- @markup.heading.1               top-level heading
      -- @markup.heading.2               section heading
      -- @markup.heading.3               subsection heading
      -- @markup.heading.4               and so on
      -- @markup.heading.5               and so forth
      -- @markup.heading.6               six levels ought to be enough for anybody
      -- @markup.quote                   block quotes
      -- @markup.math                    math environments (e.g. $ ... $ in LaTeX)
      -- @markup.link                    text references, footnotes, citations, etc.
      -- @markup.link.label              link, reference descriptions
      -- @markup.link.url                URL-style links
      -- @markup.raw                     literal or verbatim text (e.g. inline code)
      -- @markup.raw.block               literal or verbatim text as a stand-alone block
      -- @markup.list                    list markers
      -- @markup.list.checked            checked todo-style list markers
      -- @markup.list.unchecked          unchecked todo-style list markers
      -- @diff.plus                      added text (for diff files)
      -- @diff.minus                     deleted text (for diff files)
      -- @diff.delta                     changed text (for diff files)
      -- @tag                            XML-style tag names (e.g. in XML, HTML, etc.)
      -- @tag.builtin                    XML-style tag names (e.g. HTML5 tags)
      -- @tag.attribute                  XML-style tag attributes
      -- @tag.delimiter                  XML-style tag delimiters

      ['@annotation']             = { link='Annotation' },
      ['@attribute']              = { link='Attribute' },
      ['@spell']                  = { link='cleared' },
      ['@error']                  = { link='Error' },
      ['@text']                   = { link='Normal' },
      ['@text.literal']           = { link='Comment' },
      ['@text.reference']         = { link='Identifier' },
      ['@text.title']             = { link='Title' },
      ['@text.uri']               = { link='Underlined' },
      ['@text.underline']         = { link='Underlined' },
      ['@text.todo']              = { link='Todo' },
      ['@comment']                = { link='Comment' },
      ['@punctuation']            = { link='Delimiter' },
      ['@constant']               = { link='Constant' },
      ['@constant.builtin']       = { link='Special' },
      ['@constant.macro']         = { link='Define' },
      ['@define']                 = { link='Define' },
      ['@macro']                  = { link='Macro' },
      ['@string']                 = { link='String' },
      ['@string.escape']          = { link='SpecialChar' },
      ['@string.special']         = { link='SpecialChar' },
      ['@character']              = { link='Character' },
      ['@character.special']      = { link='SpecialChar' },
      ['@number']                 = { link='Number' },
      ['@boolean']                = { link='Boolean' },
      ['@float']                  = { link='Float' },
      ['@function']               = { link='Function' },
      ['@function.builtin']       = { link='Special' },
      ['@function.macro']         = { link='Macro' },
      ['@parameter']              = { link='Identifier' },
      ['@punctuation.bracket']    = { link='Special' },
      ['@method']                 = { link='Function' },
      ['@field']                  = { link='Identifier' },
      ['@property']               = { link='Identifier' },
      ['@constructor']            = { link='Special' },
      ['@conditional']            = { link='Conditional' },
      ['@repeat']                 = { link='Repeat' },
      ['@label']                  = { link='Label' },
      ['@operator']               = { link='Operator' },
      ['@keyword']                = { link='Keyword' },
      ['@exception']              = { link='Exception' },
      ['@variable']               = { link='Identifier' },
      ['@type']                   = { link='Type' },
      ['@type.definition']        = { link='Typedef' },
      ['@storageclass']           = { link='StorageClass' },
      ['@structure']              = { link='Structure' },
      ['@namespace']              = { link='Identifier' },
      ['@include']                = { link='Include' },
      ['@preproc']                = { link='PreProc' },
      ['@debug']                  = { link='Debug' },
      ['@tag']                    = { link='Tag' },

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
