-- Colorscheme generated by https://github.com/arcticlimer/djanho
vim.cmd[[highlight clear]]

local highlight = function(group, bg, fg, attr)
    fg = fg and 'guifg=' .. fg or ''
    bg = bg and 'guibg=' .. bg or ''
    attr = attr and 'gui=' .. attr or ''

    vim.api.nvim_command('highlight ' .. group .. ' '.. fg .. ' ' .. bg .. ' '.. attr)
end

local link = function(target, group)
    vim.api.nvim_command('highlight! link ' .. target .. ' '.. group)
end

local Color13 = '#3a3738'
local Color3 = '#d3b692'
local Color14 = '#2a3f4d'
local Color15 = '#5d6e79'
local Color8 = '#5998c0'
local Color5 = '#72c09f'
local Color10 = '#1b2932'
local Color12 = '#273e41'
local Color6 = '#7068b1'
local Color0 = '#5e7887'
local Color9 = '#b16a4e'
local Color16 = '#96a8b6'
local Color11 = '#496d83'
local Color17 = '#202e37'
local Color1 = '#c5cdd3'
local Color4 = '#a88c00'
local Color7 = '#3f848d'
local Color2 = '#c88da2'

highlight('Comment', nil, Color0, nil)
highlight('TSCharacter', nil, Color1, nil)
highlight('Keyword', nil, Color2, nil)
highlight('Conditional', nil, Color2, nil)
highlight('Repeat', nil, Color2, nil)
highlight('Identifier', nil, Color3, nil)
highlight('Constant', nil, Color4, nil)
highlight('String', nil, Color5, nil)
highlight('Number', nil, Color6, nil)
highlight('Function', nil, Color7, nil)
highlight('Type', nil, Color8, nil)
highlight('Error', nil, Color9, nil)
highlight('Comment', nil, nil, 'italic')
highlight('Keyword', nil, nil, 'bold')
highlight('Operator', nil, nil, 'bold')
highlight('Conditional', nil, nil, 'bold')
highlight('Repeat', nil, nil, 'bold')
highlight('StatusLine', Color11, Color10, nil)
highlight('WildMenu', Color10, Color1, nil)
highlight('Pmenu', Color10, Color1, nil)
highlight('PmenuSel', Color1, Color10, nil)
highlight('PmenuThumb', Color10, Color1, nil)
highlight('DiffAdd', Color12, nil, nil)
highlight('DiffDelete', Color13, nil, nil)
highlight('Normal', Color10, Color1, nil)
highlight('Visual', Color14, nil, nil)
highlight('CursorLine', Color14, nil, nil)
highlight('ColorColumn', Color14, nil, nil)
highlight('SignColumn', Color10, nil, nil)
highlight('LineNr', nil, Color15, nil)
highlight('TabLine', Color17, Color16, nil)
highlight('TabLineSel', Color8, Color10, nil)
highlight('TabLineFill', Color17, Color16, nil)
highlight('TSPunctDelimiter', nil, Color1, nil)

link('TSKeyword', 'Keyword')
link('TSNamespace', 'TSType')
link('TSNumber', 'Number')
link('TSString', 'String')
link('TSFloat', 'Number')
link('TSTag', 'MyTag')
link('Macro', 'Function')
link('TSField', 'Constant')
link('TSFuncMacro', 'Macro')
link('Whitespace', 'Comment')
link('TSComment', 'Comment')
link('TSOperator', 'Operator')
link('TSPunctSpecial', 'TSPunctDelimiter')
link('TSConditional', 'Conditional')
link('Repeat', 'Conditional')
link('TSParameter', 'Constant')
link('Operator', 'Keyword')
link('CursorLineNr', 'Identifier')
link('TSParameterReference', 'TSParameter')
link('TSLabel', 'Type')
link('TSFunction', 'Function')
link('NonText', 'Comment')
link('TSType', 'Type')
link('TSTagDelimiter', 'Type')
link('Conditional', 'Operator')
link('Folded', 'Comment')
link('TSConstant', 'Constant')
link('TSPunctBracket', 'MyTag')
link('TSProperty', 'TSField')
link('TSRepeat', 'Repeat')
link('TSConstBuiltin', 'TSVariableBuiltin')
link('TelescopeNormal', 'Normal')