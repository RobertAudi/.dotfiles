" Railscasts scheme by Ryan Bates (http://railscasts.com)

" GUI color definitions
let s:gui00 = '2b2b2b' "   #2b2b2b
let s:gui01 = '333435' "   #333435
let s:gui02 = '3a4055' "   #3a4055
let s:gui03 = '5a647e' "   #5a647e
let s:gui04 = 'd4cfc9' "   #d4cfc9
let s:gui05 = 'e6e1dc' "   #e6e1dc
let s:gui06 = 'f4f1ed' "   #f4f1ed
let s:gui07 = 'f9f7f3' "   #f9f7f3
let s:gui08 = 'da4939' "   #da4939
let s:gui09 = 'cc7833' "   #cc7833
let s:gui0A = 'ffc66d' "   #ffc66d
let s:gui0B = 'a5c261' "   #a5c261
let s:gui0C = '519f50' "   #519f50
let s:gui0D = '6d9cbe' "   #6d9cbe
let s:gui0E = 'b6b3eb' "   #b6b3eb
let s:gui0F = 'bc9458' "   #bc9458

let s:gui_error   = 'd94a39' " #d94a39
let s:gui_warning = 'ffa500' " #ffa500
let s:gui_info    = '6d9cbe' " #0096ff
let s:gui_hint    = 'd783ff' " #d783ff

" Terminal color definitions
let s:cterm00 = '00'
let s:cterm01 = '18'
let s:cterm02 = '19'
let s:cterm03 = '08'
let s:cterm04 = '20'
let s:cterm05 = '07'
let s:cterm06 = '21'
let s:cterm07 = '15'
let s:cterm08 = '01'
let s:cterm09 = '16'
let s:cterm0A = '03'
let s:cterm0B = '02'
let s:cterm0C = '06'
let s:cterm0D = '04'
let s:cterm0E = '05'
let s:cterm0F = '17'

let s:cterm_error   = '09'
let s:cterm_warning = '11'
let s:cterm_info    = '12'
let s:cterm_hint    = '13'

" Neovim terminal colours
let g:terminal_color_0  = '#2b2b2b'
let g:terminal_color_1  = '#da4939'
let g:terminal_color_2  = '#a5c261'
let g:terminal_color_3  = '#ffc66d'
let g:terminal_color_4  = '#6d9cbe'
let g:terminal_color_5  = '#b6b3eb'
let g:terminal_color_6  = '#519f50'
let g:terminal_color_7  = '#e6e1dc'
let g:terminal_color_8  = '#5a647e'
let g:terminal_color_9  = '#da4939'
let g:terminal_color_10 = '#a5c261'
let g:terminal_color_11 = '#ffc66d'
let g:terminal_color_12 = '#6d9cbe'
let g:terminal_color_13 = '#b6b3eb'
let g:terminal_color_14 = '#519f50'
let g:terminal_color_15 = '#f9f7f3'
let g:terminal_color_background = g:terminal_color_0
let g:terminal_color_foreground = g:terminal_color_5

" Theme setup
let g:colors_name = 'railscasts'

" Highlighting function
" Optional variables are attributes and guisp
function <SID>highlight(group, guifg, guibg, ctermfg, ctermbg, attr, guisp)
  if a:guifg !=# ''
    execute 'highlight ' . a:group . ' guifg=#' . a:guifg
  endif

  if a:guibg !=# ''
    execute 'highlight ' . a:group . ' guibg=#' . a:guibg
  endif

  if a:ctermfg !=# ''
    execute 'highlight ' . a:group . ' ctermfg=' . a:ctermfg
  endif

  if a:ctermbg !=# ''
    execute 'highlight ' . a:group . ' ctermbg=' . a:ctermbg
  endif

  if a:attr !=# ''
    execute 'highlight ' . a:group . ' gui=' . a:attr . ' cterm=' . a:attr
  endif

  if a:guisp !=# ''
    execute 'highlight ' . a:group . ' guisp=#' . a:guisp
  endif
endfunction

" Vim editor colors
"                  (group,               guifg,       guibg,     ctermfg,     ctermbg,       attr,    guisp
call <SID>highlight('Normal',            s:gui05,   s:gui00,   s:cterm05,     s:gui00,         '',       '')
call <SID>highlight('Bold',                   '',        '',          '',          '',     'bold',       '')
call <SID>highlight('Debug',             s:gui08,        '',   s:cterm08,          '',         '',       '')
call <SID>highlight('Directory',         s:gui0D,        '',   s:cterm0D,          '',         '',       '')
call <SID>highlight('Error',              'none',    'none',      'none',      'none',     'none',   'none')
call <SID>highlight('ErrorMsg',          s:gui08,   s:gui00,   s:cterm08,   s:cterm00,         '',       '')
call <SID>highlight('Exception',         s:gui08,        '',   s:cterm08,          '',         '',       '')
call <SID>highlight('FoldColumn',        s:gui0C,   s:gui01,   s:cterm0C,   s:cterm01,         '',       '')
call <SID>highlight('Folded',            s:gui03,   s:gui01,   s:cterm03,   s:cterm01,         '',       '')
call <SID>highlight('IncSearch',         s:gui01,   s:gui09,   s:cterm01,   s:cterm09,     'none',       '')
call <SID>highlight('Italic',                 '',        '',          '',          '',   'italic',       '')
call <SID>highlight('Macro',             s:gui08,        '',   s:cterm08,          '',         '',       '')
call <SID>highlight('MatchParen',             '',   s:gui03,          '',   s:cterm03,         '',       '')
call <SID>highlight('ModeMsg',           s:gui0B,        '',   s:cterm0B,          '',         '',       '')
call <SID>highlight('MoreMsg',           s:gui0B,        '',   s:cterm0B,          '',         '',       '')
call <SID>highlight('Question',          s:gui0D,        '',   s:cterm0D,          '',         '',       '')
call <SID>highlight('Search',            s:gui01,   s:gui0A,   s:cterm01,   s:cterm0A,         '',       '')
call <SID>highlight('Substitute',        s:gui01,   s:gui0A,   s:cterm01,   s:cterm0A,     'none',       '')
call <SID>highlight('SpecialKey',        s:gui03,        '',   s:cterm03,          '',         '',       '')
call <SID>highlight('TooLong',           s:gui08,        '',   s:cterm08,          '',         '',       '')
call <SID>highlight('Underlined',        s:gui08,        '',   s:cterm08,          '',         '',       '')
call <SID>highlight('Visual',                 '',   s:gui02,          '',   s:cterm02,         '',       '')
call <SID>highlight('VisualNOS',         s:gui08,        '',   s:cterm08,          '',         '',       '')
call <SID>highlight('WarningMsg',        s:gui08,        '',   s:cterm08,          '',         '',       '')
call <SID>highlight('WildMenu',          s:gui08,   s:gui0A,   s:cterm08,          '',         '',       '')
call <SID>highlight('Title',             s:gui0D,        '',   s:cterm0D,          '',     'none',       '')
call <SID>highlight('Conceal',           s:gui0D,   s:gui00,   s:cterm0D,   s:cterm00,         '',       '')
call <SID>highlight('Cursor',            s:gui00,   s:gui05,   s:cterm00,   s:cterm05,         '',       '')
call <SID>highlight('NonText',           s:gui03,        '',   s:cterm03,          '',         '',       '')
call <SID>highlight('LineNr',            s:gui03,   s:gui01,   s:cterm03,   s:cterm01,         '',       '')
call <SID>highlight('SignColumn',             '',   s:gui01,          '',   s:cterm01,     'none',       '')
call <SID>highlight('StatusLine',        s:gui04,   s:gui02,   s:cterm04,   s:cterm02,     'none',       '')
call <SID>highlight('StatusLineNC',      s:gui03,   s:gui01,   s:cterm03,   s:cterm01,     'none',       '')
call <SID>highlight('VertSplit',         s:gui02,    'none',   s:cterm02,      'none',     'none',       '')
call <SID>highlight('ColorColumn',            '',   s:gui01,          '',   s:cterm01,     'none',       '')
call <SID>highlight('CursorColumn',           '',   s:gui01,          '',   s:cterm01,     'none',       '')
call <SID>highlight('CursorLine',             '',   s:gui01,          '',   s:cterm01,     'none',       '')
call <SID>highlight('CursorLineNr',      s:gui04,   s:gui01,   s:cterm04,   s:cterm01,         '',       '')
call <SID>highlight('QuickFixLine',           '',   s:gui01,          '',   s:cterm01,     'none',       '')
call <SID>highlight('PMenu',             s:gui05,   s:gui01,   s:cterm05,   s:cterm01,     'none',       '')
call <SID>highlight('PMenuSel',          s:gui01,   s:gui05,   s:cterm01,   s:cterm05,         '',       '')
call <SID>highlight('TabLine',           s:gui03,   s:gui01,   s:cterm03,   s:cterm01,     'none',       '')
call <SID>highlight('TabLineFill',       s:gui03,   s:gui01,   s:cterm03,   s:cterm01,     'none',       '')
call <SID>highlight('TabLineSel',        s:gui0B,   s:gui01,   s:cterm0B,   s:cterm01,     'none',       '')
call <SID>highlight('NvimInternalError', s:gui00,   s:gui08,   s:cterm00,   s:cterm08,     'none',       '')
call <SID>highlight('NormalFloat',       s:gui05,   s:gui00,   s:cterm05,   s:cterm00,         '',       '')
call <SID>highlight('FloatBorder',       s:gui05,   s:gui00,   s:cterm05,   s:cterm00,         '',       '')
call <SID>highlight('NormalNC',          s:gui05,   s:gui00,   s:cterm05,   s:cterm00,         '',       '')
call <SID>highlight('TermCursor',        s:gui00,   s:gui05,   s:cterm00,   s:cterm05,     'none',       '')
call <SID>highlight('TermCursorNC',      s:gui00,   s:gui05,   s:cterm00,   s:cterm05,         '',       '')
"                  (group,               guifg,       guibg,     ctermfg,     ctermbg,       attr,    guisp)

" Standard syntax highlighting
"                  (group,               guifg,      guibg,       ctermfg,       ctermbg,         attr,    guisp)
call <SID>highlight('Boolean',         s:gui09,         '',     s:cterm09,            '',           '',       '')
call <SID>highlight('Character',       s:gui08,         '',     s:cterm08,            '',           '',       '')
call <SID>highlight('Comment',         s:gui03,         '',     s:cterm03,            '',     'italic',       '')
call <SID>highlight('Conditional',     s:gui0E,         '',     s:cterm0E,            '',           '',       '')
call <SID>highlight('Constant',        s:gui09,         '',     s:cterm09,            '',           '',       '')
call <SID>highlight('Define',          s:gui0E,         '',     s:cterm0E,            '',       'none',       '')
call <SID>highlight('Delimiter',       s:gui0F,         '',     s:cterm0F,            '',           '',       '')
call <SID>highlight('Float',           s:gui09,         '',     s:cterm09,            '',           '',       '')
call <SID>highlight('Function',        s:gui0D,         '',     s:cterm0D,            '',           '',       '')
call <SID>highlight('Identifier',      s:gui08,         '',     s:cterm08,            '',       'none',       '')
call <SID>highlight('Include',         s:gui0D,         '',     s:cterm0D,            '',           '',       '')
call <SID>highlight('Keyword',         s:gui0E,         '',     s:cterm0E,            '',           '',       '')
call <SID>highlight('Label',           s:gui0A,         '',     s:cterm0A,            '',           '',       '')
call <SID>highlight('Number',          s:gui09,         '',     s:cterm09,            '',           '',       '')
call <SID>highlight('Operator',        s:gui05,         '',     s:cterm05,            '',       'none',       '')
call <SID>highlight('PreProc',         s:gui0A,         '',     s:cterm0A,            '',           '',       '')
call <SID>highlight('Repeat',          s:gui0A,         '',     s:cterm0A,            '',           '',       '')
call <SID>highlight('Special',         s:gui0C,         '',     s:cterm0C,            '',           '',       '')
call <SID>highlight('SpecialChar',     s:gui0F,         '',     s:cterm0F,            '',           '',       '')
call <SID>highlight('Statement',       s:gui08,         '',     s:cterm08,            '',           '',       '')
call <SID>highlight('StorageClass',    s:gui0A,         '',     s:cterm0A,            '',           '',       '')
call <SID>highlight('String',          s:gui0B,         '',     s:cterm0B,            '',           '',       '')
call <SID>highlight('Structure',       s:gui0E,         '',     s:cterm0E,            '',           '',       '')
call <SID>highlight('Tag',             s:gui0A,         '',     s:cterm0A,            '',           '',       '')
call <SID>highlight('Todo',            s:gui0A,    s:gui01,     s:cterm0A,     s:cterm01,           '',       '')
call <SID>highlight('Type',            s:gui0A,         '',     s:cterm0A,            '',       'none',       '')
call <SID>highlight('Typedef',         s:gui0A,         '',     s:cterm0A,            '',           '',       '')
"                  (group,               guifg,      guibg,       ctermfg,       ctermbg,         attr,    guisp)

" Diagnostics highlighting
call <SID>highlight('DiagnosticError',                  s:gui_error, '',   s:cterm_error, '',      'none',            '')
call <SID>highlight('DiagnosticWarn',                 s:gui_warning, '', s:cterm_warning, '',      'none',            '')
call <SID>highlight('DiagnosticInfo',                    s:gui_info, '',    s:cterm_info, '',      'none',            '')
call <SID>highlight('DiagnosticHint',                    s:gui_hint, '',    s:cterm_hint, '',      'none',            '')
call <SID>highlight('DiagnosticUnderlineError',                  '', '',              '', '', 'undercurl',   s:gui_error)
call <SID>highlight('DiagnosticUnderlineWarning',                '', '',              '', '', 'undercurl', s:gui_warning)
call <SID>highlight('DiagnosticUnderlineWarn',                   '', '',              '', '', 'undercurl', s:gui_warning)
call <SID>highlight('DiagnosticUnderlineInformation',            '', '',              '', '', 'undercurl',    s:gui_info)
call <SID>highlight('DiagnosticUnderlineHint',                   '', '',              '', '', 'undercurl',    s:gui_hint)

" LSP highlighting
call <SID>highlight('LspReferenceText',  '', '', '', '', 'underline', s:gui04)
call <SID>highlight('LspReferenceRead',  '', '', '', '', 'underline', s:gui04)
call <SID>highlight('LspReferenceWrite', '', '', '', '', 'underline', s:gui04)
highlight! link LspDiagnosticsDefaultError         DiagnosticError
highlight! link LspDiagnosticsDefaultWarning       DiagnosticWarn
highlight! link LspDiagnosticsDefaultInformation   DiagnosticInfo
highlight! link LspDiagnosticsDefaultHint          DiagnosticHint
highlight! link LspDiagnosticsUnderlineError       DiagnosticUnderlineError
highlight! link LspDiagnosticsUnderlineWarning     DiagnosticUnderlineWarning
highlight! link LspDiagnosticsUnderlineInformation DiagnosticUnderlineInformation
highlight! link LspDiagnosticsUnderlineHint        DiagnosticUnderlineHint

" Treesitter highlighting
"                  (group,                     guifg,   guibg,   ctermfg,   ctermbg,            attr,   guisp)
call <SID>highlight('TSAnnotation',          s:gui0F,      '', s:cterm0F,        '',          'none',      '')
call <SID>highlight('TSAttribute',           s:gui0A,      '', s:cterm0A,        '',          'none',      '')
call <SID>highlight('TSBoolean',             s:gui09,      '', s:cterm09,        '',          'none',      '')
call <SID>highlight('TSCharacter',           s:gui08,      '', s:cterm08,        '',          'none',      '')
call <SID>highlight('TSComment',             s:gui03,      '', s:cterm03,        '',        'italic',      '')
call <SID>highlight('TSConstructor',         s:gui0D,      '', s:cterm0D,        '',          'none',      '')
call <SID>highlight('TSConditional',         s:gui0E,      '', s:cterm0E,        '',          'none',      '')
call <SID>highlight('TSConstant',            s:gui09,      '', s:cterm09,        '',          'none',      '')
call <SID>highlight('TSConstBuiltin',        s:gui09,      '', s:cterm09,        '',        'italic',      '')
call <SID>highlight('TSConstMacro',          s:gui08,      '', s:cterm08,        '',          'none',      '')
call <SID>highlight('TSError',               s:gui08,      '', s:cterm08,        '',          'none',      '')
call <SID>highlight('TSException',           s:gui08,      '', s:cterm08,        '',          'none',      '')
call <SID>highlight('TSField',               s:gui05,      '', s:cterm05,        '',          'none',      '')
call <SID>highlight('TSFloat',               s:gui09,      '', s:cterm09,        '',          'none',      '')
call <SID>highlight('TSFunction',            s:gui0D,      '', s:cterm0D,        '',          'none',      '')
call <SID>highlight('TSFuncBuiltin',         s:gui0D,      '', s:cterm0D,        '',        'italic',      '')
call <SID>highlight('TSFuncMacro',           s:gui08,      '', s:cterm08,        '',          'none',      '')
call <SID>highlight('TSInclude',             s:gui0D,      '', s:cterm0D,        '',          'none',      '')
call <SID>highlight('TSKeyword',             s:gui0E,      '', s:cterm0E,        '',          'none',      '')
call <SID>highlight('TSKeywordFunction',     s:gui0E,      '', s:cterm0E,        '',          'none',      '')
call <SID>highlight('TSKeywordOperator',     s:gui0E,      '', s:cterm0E,        '',          'none',      '')
call <SID>highlight('TSLabel',               s:gui0A,      '', s:cterm0A,        '',          'none',      '')
call <SID>highlight('TSMethod',              s:gui0D,      '', s:cterm0D,        '',          'none',      '')
call <SID>highlight('TSNamespace',           s:gui08,      '', s:cterm08,        '',          'none',      '')
call <SID>highlight('TSNone',                s:gui05,      '', s:cterm05,        '',          'none',      '')
call <SID>highlight('TSNumber',              s:gui09,      '', s:cterm09,        '',          'none',      '')
call <SID>highlight('TSOperator',            s:gui05,      '', s:cterm05,        '',          'none',      '')
call <SID>highlight('TSParameter',           s:gui05,      '', s:cterm05,        '',          'none',      '')
call <SID>highlight('TSParameterReference',  s:gui05,      '', s:cterm05,        '',          'none',      '')
call <SID>highlight('TSProperty',            s:gui05,      '', s:cterm05,        '',          'none',      '')
call <SID>highlight('TSPunctDelimiter',      s:gui0F,      '', s:cterm0F,        '',          'none',      '')
call <SID>highlight('TSPunctBracket',        s:gui05,      '', s:cterm05,        '',          'none',      '')
call <SID>highlight('TSPunctSpecial',        s:gui05,      '', s:cterm05,        '',          'none',      '')
call <SID>highlight('TSRepeat',              s:gui0A,      '', s:cterm0A,        '',          'none',      '')
call <SID>highlight('TSString',              s:gui0B,      '', s:cterm0B,        '',          'none',      '')
call <SID>highlight('TSStringRegex',         s:gui0C,      '', s:cterm0C,        '',          'none',      '')
call <SID>highlight('TSStringEscape',        s:gui0C,      '', s:cterm0C,        '',          'none',      '')
call <SID>highlight('TSSymbol',              s:gui0B,      '', s:cterm0B,        '',          'none',      '')
call <SID>highlight('TSTag',                 s:gui0A,      '', s:cterm0A,        '',          'none',      '')
call <SID>highlight('TSTagDelimiter',        s:gui0F,      '', s:cterm0F,        '',          'none',      '')
call <SID>highlight('TSText',                s:gui05,      '', s:cterm05,        '',          'none',      '')
call <SID>highlight('TSStrong',                   '',      '',        '',        '',          'bold',      '')
call <SID>highlight('TSEmphasis',            s:gui09,      '', s:cterm09,        '',        'italic',      '')
call <SID>highlight('TSUnderline',           s:gui00,      '', s:cterm00,        '',     'underline',      '')
call <SID>highlight('TSStrike',              s:gui00,      '', s:cterm00,        '', 'strikethrough',      '')
call <SID>highlight('TSTitle',               s:gui0D,      '', s:cterm0D,        '',          'none',      '')
call <SID>highlight('TSLiteral',             s:gui09,      '', s:cterm09,        '',          'none',      '')
call <SID>highlight('TSURI',                 s:gui09,      '', s:cterm09,        '',     'underline',      '')
call <SID>highlight('TSType',                s:gui0A,      '', s:cterm0A,        '',          'none',      '')
call <SID>highlight('TSTypeBuiltin',         s:gui0A,      '', s:cterm0A,        '',        'italic',      '')
call <SID>highlight('TSVariable',            s:gui08,      '', s:cterm08,        '',          'none',      '')
call <SID>highlight('TSVariableBuiltin',     s:gui08,      '', s:cterm08,        '',        'italic',      '')
call <SID>highlight('TSDefinition',               '',      '',        '',        '',     'underline', s:gui04)
call <SID>highlight('TSDefinitionUsage',          '',      '',        '',        '',     'underline', s:gui04)
call <SID>highlight('TSCurrentScope',             '',      '',        '',        '',          'bold',      '')
call <SID>highlight('TreesitterContext',          '', s:gui01,        '', s:cterm01,        'italic',      '')
"                  (group,                     guifg,   guibg,   ctermfg,   ctermbg,            attr,   guisp)

" User highlights
call <SID>highlight('User1', s:gui08, s:gui02, s:cterm08, s:cterm02, 'none', '')
call <SID>highlight('User2', s:gui0E, s:gui02, s:cterm0E, s:cterm02, 'none', '')
call <SID>highlight('User3', s:gui05, s:gui02, s:cterm05, s:cterm02, 'none', '')
call <SID>highlight('User4', s:gui0C, s:gui02, s:cterm0C, s:cterm02, 'none', '')
call <SID>highlight('User5', s:gui01, s:gui02, s:cterm01, s:cterm02, 'none', '')
call <SID>highlight('User6', s:gui05, s:gui02, s:cterm05, s:cterm02, 'none', '')
call <SID>highlight('User7', s:gui05, s:gui02, s:cterm05, s:cterm02, 'none', '')
call <SID>highlight('User8', s:gui00, s:gui02, s:cterm00, s:cterm02, 'none', '')
call <SID>highlight('User9', s:gui00, s:gui02, s:cterm00, s:cterm02, 'none', '')

" Diff highlighting
call <SID>highlight('DiffAdd',          s:gui0B, s:gui01, s:cterm0B, s:cterm01, '', '')
call <SID>highlight('DiffChange',       s:gui03, s:gui01, s:cterm03, s:cterm01, '', '')
" call <SID>highlight('DiffChange',       s:gui0D, s:gui01, s:cterm0D, s:cterm01, '', '')
call <SID>highlight('DiffChangeDelete', s:gui0E, s:gui01, s:cterm0E, s:cterm01, '', '')
call <SID>highlight('DiffDelete',       s:gui08, s:gui01, s:cterm08, s:cterm01, '', '')
call <SID>highlight('DiffText',         s:gui0D, s:gui01, s:cterm0D, s:cterm01, '', '')
call <SID>highlight('DiffAdded',        s:gui0B, s:gui00, s:cterm0B, s:cterm00, '', '')
call <SID>highlight('DiffFile',         s:gui08, s:gui00, s:cterm08, s:cterm00, '', '')
call <SID>highlight('DiffNewFile',      s:gui0B, s:gui00, s:cterm0B, s:cterm00, '', '')
call <SID>highlight('DiffLine',         s:gui0D, s:gui00, s:cterm0D, s:cterm00, '', '')
call <SID>highlight('DiffRemoved',      s:gui08, s:gui00, s:cterm08, s:cterm00, '', '')

" Git highlighting
call <SID>highlight('gitcommitOverflow',       s:gui08, '', s:cterm08, '',     '', '')
call <SID>highlight('gitcommitSummary',        s:gui0B, '', s:cterm0B, '',     '', '')
call <SID>highlight('gitcommitComment',        s:gui03, '', s:cterm03, '',     '', '')
call <SID>highlight('gitcommitUntracked',      s:gui03, '', s:cterm03, '',     '', '')
call <SID>highlight('gitcommitDiscarded',      s:gui03, '', s:cterm03, '',     '', '')
call <SID>highlight('gitcommitSelected',       s:gui03, '', s:cterm03, '',     '', '')
call <SID>highlight('gitcommitHeader',         s:gui0E, '', s:cterm0E, '',     '', '')
call <SID>highlight('gitcommitSelectedType',   s:gui0D, '', s:cterm0D, '',     '', '')
call <SID>highlight('gitcommitUnmergedType',   s:gui0D, '', s:cterm0D, '',     '', '')
call <SID>highlight('gitcommitDiscardedType',  s:gui0D, '', s:cterm0D, '',     '', '')
call <SID>highlight('gitcommitBranch',         s:gui09, '', s:cterm09, '', 'bold', '')
call <SID>highlight('gitcommitUntrackedFile',  s:gui0A, '', s:cterm0A, '',     '', '')
call <SID>highlight('gitcommitUnmergedFile',   s:gui08, '', s:cterm08, '', 'bold', '')
call <SID>highlight('gitcommitDiscardedFile',  s:gui08, '', s:cterm08, '', 'bold', '')
call <SID>highlight('gitcommitSelectedFile',   s:gui0B, '', s:cterm0B, '', 'bold', '')

" GitGutter highlighting
call <SID>highlight('GitGutterAdd',           s:gui0B, s:gui01, s:cterm0B, s:cterm01, '', '')
call <SID>highlight('GitGutterChange',        s:gui0D, s:gui01, s:cterm0D, s:cterm01, '', '')
call <SID>highlight('GitGutterDelete',        s:gui08, s:gui01, s:cterm08, s:cterm01, '', '')
call <SID>highlight('GitGutterChangeDelete',  s:gui0E, s:gui01, s:cterm0E, s:cterm01, '', '')

" C highlighting
call <SID>highlight('cOperator',  s:gui0C, '', s:cterm0C, '', '', '')
call <SID>highlight('cPreCondit', s:gui0E, '', s:cterm0E, '', '', '')

" C# highlighting
call <SID>highlight('csClass',                 s:gui0A, '', s:cterm0A, '', '', '')
call <SID>highlight('csAttribute',             s:gui0A, '', s:cterm0A, '', '', '')
call <SID>highlight('csModifier',              s:gui0E, '', s:cterm0E, '', '', '')
call <SID>highlight('csType',                  s:gui08, '', s:cterm08, '', '', '')
call <SID>highlight('csUnspecifiedStatement',  s:gui0D, '', s:cterm0D, '', '', '')
call <SID>highlight('csContextualStatement',   s:gui0E, '', s:cterm0E, '', '', '')
call <SID>highlight('csNewDecleration',        s:gui08, '', s:cterm08, '', '', '')

" CSS highlighting
call <SID>highlight('cssBraces',      s:gui05, '', s:cterm05, '', '', '')
call <SID>highlight('cssClassName',   s:gui0E, '', s:cterm0E, '', '', '')
call <SID>highlight('cssColor',       s:gui0C, '', s:cterm0C, '', '', '')

" HTML highlighting
call <SID>highlight('htmlBold',    s:gui0A, '', s:cterm0A, '', '', '')
call <SID>highlight('htmlItalic',  s:gui0E, '', s:cterm0E, '', '', '')
call <SID>highlight('htmlEndTag',  s:gui05, '', s:cterm05, '', '', '')
call <SID>highlight('htmlTag',     s:gui05, '', s:cterm05, '', '', '')

" JavaScript highlighting
call <SID>highlight('javaScript',        s:gui05, '', s:cterm05, '', '', '')
call <SID>highlight('javaScriptBraces',  s:gui05, '', s:cterm05, '', '', '')
call <SID>highlight('javaScriptNumber',  s:gui09, '', s:cterm09, '', '', '')

" pangloss/vim-javascript highlighting
call <SID>highlight('jsOperator',          s:gui0D, '', s:cterm0D, '', '', '')
call <SID>highlight('jsStatement',         s:gui0E, '', s:cterm0E, '', '', '')
call <SID>highlight('jsReturn',            s:gui0E, '', s:cterm0E, '', '', '')
call <SID>highlight('jsThis',              s:gui08, '', s:cterm08, '', '', '')
call <SID>highlight('jsClassDefinition',   s:gui0A, '', s:cterm0A, '', '', '')
call <SID>highlight('jsFunction',          s:gui0E, '', s:cterm0E, '', '', '')
call <SID>highlight('jsFuncName',          s:gui0D, '', s:cterm0D, '', '', '')
call <SID>highlight('jsFuncCall',          s:gui0D, '', s:cterm0D, '', '', '')
call <SID>highlight('jsClassFuncName',     s:gui0D, '', s:cterm0D, '', '', '')
call <SID>highlight('jsClassMethodType',   s:gui0E, '', s:cterm0E, '', '', '')
call <SID>highlight('jsRegexpString',      s:gui0C, '', s:cterm0C, '', '', '')
call <SID>highlight('jsGlobalObjects',     s:gui0A, '', s:cterm0A, '', '', '')
call <SID>highlight('jsGlobalNodeObjects', s:gui0A, '', s:cterm0A, '', '', '')
call <SID>highlight('jsExceptions',        s:gui0A, '', s:cterm0A, '', '', '')
call <SID>highlight('jsBuiltins',          s:gui0A, '', s:cterm0A, '', '', '')

" Mail highlighting
call <SID>highlight('mailQuoted1',  s:gui0A, '', s:cterm0A, '', '', '')
call <SID>highlight('mailQuoted2',  s:gui0B, '', s:cterm0B, '', '', '')
call <SID>highlight('mailQuoted3',  s:gui0E, '', s:cterm0E, '', '', '')
call <SID>highlight('mailQuoted4',  s:gui0C, '', s:cterm0C, '', '', '')
call <SID>highlight('mailQuoted5',  s:gui0D, '', s:cterm0D, '', '', '')
call <SID>highlight('mailQuoted6',  s:gui0A, '', s:cterm0A, '', '', '')
call <SID>highlight('mailURL',      s:gui0D, '', s:cterm0D, '', '', '')
call <SID>highlight('mailEmail',    s:gui0D, '', s:cterm0D, '', '', '')

" Markdown highlighting
call <SID>highlight('markdownCode',              s:gui0B,      '', s:cterm0B,        '', '', '')
call <SID>highlight('markdownError',             s:gui05, s:gui00, s:cterm05, s:cterm00, '', '')
call <SID>highlight('markdownCodeBlock',         s:gui0B,      '', s:cterm0B,        '', '', '')
call <SID>highlight('markdownHeadingDelimiter',  s:gui0D,      '', s:cterm0D,        '', '', '')

" PHP highlighting
call <SID>highlight('phpMemberSelector',  s:gui05, '', s:cterm05, '', '', '')
call <SID>highlight('phpComparison',      s:gui05, '', s:cterm05, '', '', '')
call <SID>highlight('phpParent',          s:gui05, '', s:cterm05, '', '', '')
call <SID>highlight('phpMethodsVar',      s:gui0C, '', s:cterm0C, '', '', '')

" Python highlighting
call <SID>highlight('pythonOperator',  s:gui0E, '', s:cterm0E, '', '', '')
call <SID>highlight('pythonRepeat',    s:gui0E, '', s:cterm0E, '', '', '')
call <SID>highlight('pythonInclude',   s:gui0E, '', s:cterm0E, '', '', '')
call <SID>highlight('pythonStatement', s:gui0E, '', s:cterm0E, '', '', '')

" Ruby highlighting
call <SID>highlight('rubyAttribute',               s:gui0D, '', s:cterm0D, '', '', '')
call <SID>highlight('rubyConstant',                s:gui0A, '', s:cterm0A, '', '', '')
call <SID>highlight('rubyInterpolationDelimiter',  s:gui0F, '', s:cterm0F, '', '', '')
call <SID>highlight('rubyRegexp',                  s:gui0C, '', s:cterm0C, '', '', '')
call <SID>highlight('rubySymbol',                  s:gui0B, '', s:cterm0B, '', '', '')
call <SID>highlight('rubyStringDelimiter',         s:gui0B, '', s:cterm0B, '', '', '')

" SASS highlighting
call <SID>highlight('sassidChar',     s:gui08, '', s:cterm08, '', '', '')
call <SID>highlight('sassClassChar',  s:gui09, '', s:cterm09, '', '', '')
call <SID>highlight('sassInclude',    s:gui0E, '', s:cterm0E, '', '', '')
call <SID>highlight('sassMixing',     s:gui0E, '', s:cterm0E, '', '', '')
call <SID>highlight('sassMixinName',  s:gui0D, '', s:cterm0D, '', '', '')

" Spelling highlighting
call <SID>highlight('SpellBad',     '', '', '', '', 'undercurl', s:gui08)
call <SID>highlight('SpellLocal',   '', '', '', '', 'undercurl', s:gui0C)
call <SID>highlight('SpellCap',     '', '', '', '', 'undercurl', s:gui0D)
call <SID>highlight('SpellRare',    '', '', '', '', 'undercurl', s:gui0E)

" Java highlighting
call <SID>highlight('javaOperator',     s:gui0D, '', s:cterm0D, '', '', '')

" Ale
call <SID>highlight('ALEErrorSign',               s:gui08,      '', s:cterm08,        '',       '', '')
call <SID>highlight('ALEWarningSign',             s:gui0A,      '', s:cterm0A,        '',       '', '')
call <SID>highlight('ALEVirtualTextError',        s:gui08,      '', s:cterm08,        '', 'italic', '')
call <SID>highlight('ALEVirtualTextStyleError',   s:gui08,      '', s:cterm08,        '', 'italic', '')
call <SID>highlight('ALEVirtualTextWarning',      s:gui0A,      '', s:cterm0A,        '', 'italic', '')
call <SID>highlight('ALEVirtualTextStyleWarning', s:gui0A,      '', s:cterm0A,        '', 'italic', '')
call <SID>highlight('ALEVirtualTextInfo',         s:gui0D,      '', s:cterm0D,        '', 'italic', '')

call <SID>highlight('HighlightedyankRegion', s:gui00, s:gui0A, s:cterm00, s:cterm0A, '', '')

" Remove functions
delfunction <SID>highlight

" JSX tag colors
highlight link xmlEndTag xmlTag

" Fzf
let g:fzf_colors = {
      \   'fg':      ['fg', 'Normal'],
      \   'bg':      ['bg', 'Normal'],
      \   'hl':      ['fg', 'Comment'],
      \   'fg+':     ['fg', 'CursorLine','CursorColumn','Normal'],
      \   'bg+':     ['bg', 'CursorLine','CursorColumn'],
      \   'hl+':     ['fg', 'Statement'],
      \   'info':    ['fg', 'PreProc'],
      \   'border':  ['fg', 'Ignore'],
      \   'prompt':  ['fg', 'Conditional'],
      \   'pointer': ['fg', 'Exception'],
      \   'marker':  ['fg', 'Keyword'],
      \   'spinner': ['fg', 'Label'],
      \   'header':  ['fg', 'Comment']
      \ }

" Remove color variables
unlet s:gui00 s:gui01 s:gui02 s:gui03  s:gui04  s:gui05  s:gui06  s:gui07  s:gui08  s:gui09 s:gui0A  s:gui0B  s:gui0C  s:gui0D  s:gui0E  s:gui0F
unlet s:cterm00 s:cterm01 s:cterm02 s:cterm03 s:cterm04 s:cterm05 s:cterm06 s:cterm07 s:cterm08 s:cterm09 s:cterm0A s:cterm0B s:cterm0C s:cterm0D s:cterm0E s:cterm0F
