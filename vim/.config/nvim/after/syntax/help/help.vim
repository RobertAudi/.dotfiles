" Author: Charles E. Campbell
" Description: My improvements to <help.vim> which Bram doesn't want

let b:loaded_aftersyntaxhelp= 'v1f'

" Clusters:
" ---------------------------------------------------------------------
syntax cluster helpSectionGroup    contains=helpBox1,helpBox2,helpBox3,helpBox4,helpBox5,helpCharacter,helpComment,helpConditional,helpConstant,helpDebug,helpDefine,helpDelimiter,helpError,helpExample,helpExample,helpExampleItem,helpException,helpFloat,helpFold,helpFunction,helpHeader,helpHeadline,helpHyperTextEntry,helpHyperTextJump,helpIdentifier,helpInclude,helpKeyword,helpLabel,helpLeadBlank,helpMacro,helpNormal,helpNormal,helpNote,helpNote,helpNotVi,helpNumber,helpOperator,helpOption,helpPreCondit,helpPreProc,helpRepeat,helpSectionDelim,helpSectionTitle,helpSpecial,helpSpecial,helpSpecialChar,helpSpecialComment,helpStatement,helpStorageClass,helpString,helpStructure,helpTag,helpTitle,helpTodo,helpType,helpTypedef,helpUnderlined,helpURL,helpVim

" Extra Syntax:
" ---------------------------------------------------------------------
syntax clear helpSectionDelim
syntax match helpSectionDelim             "^=\{3,}.*===$" skipnl nextgroup=helpSection
syntax region helpSection         fold transparent contained      start="^\*\=\d\+\.[0-9 \t]" matchgroup=helpSectionDelim end="^=\+$"     contains=@helpSectionGroup skipnl nextgroup=helpSection
syntax match helpSectionTitle             "^[0-9]\+\.[^|]*\*[#-)!+-~]\+\*\ze\%(\s*{{{\d\)\=$"                                             contains=helpHyperTextEntry,helpSectionNmbr,helpTitleEnd
syntax match helpSectionTitle             "^\s*\zs\u[A-Z0-9,'() :]*\s*\%({{{\d\+\)\=\%(\s*{{{\d\)\=$"                                     contains=helpSecTitleBlank,helpSecTitleGap,helpFold
syntax match helpSectionTitle             "^\s*\zs\u[A-Z0-9,'() :]*\(\s*\*[#-)!+-~]\+\*\)\+\%(\s*{{{\d\)\=$"                              contains=helpHyperTextEntry,helpBlank,helpSecTitleBlank,helpSecTitleGap,helpFold

" Note: :he netrw-mb was showing a line beginning with "The " as a helpTitleEnd.
" syntax match helpSectionTitle            '^\s*\u\a\+[A-Z0-9,'() :]\{-}\ze\s*[-:]\%(\s*{{{\d\)\='                                         contains=helpSecTitleBlank,helpSecTitleGap,helpFold
syntax match helpTitleEnd      contained  "\s\+\ze\*"
syntax match helpSecTitleBlank contained  "\s\+"  contains=helpLeadBlank
syntax match helpSecTitleGap   contained  "\s\+\ze\*"
syntax match helpSectionNmbr   contained  "^[0-9]\+\.[0-9]*"
syntax match helpBox1                     "[-+]\{3,}|\="
syntax match helpBox2                     "\s|[| ]"
syntax match helpBox2                     "||"
syntax match helpBox3                     "[/\\+]===\+[/\\+|]\="
syntax match helpBox4                     "===\+[/\\+|]\{1,2}"
syntax match helpBox5                     "[- \t=][|+]\{1,2}$"
syntax match helpNormal                   "-N-"
syntax match helpDate          contained  "\s*\u\l\l \d\{2}, \d\{4}$"               contains=helpSecTitleBlank
syntax match helpFold          contained  "{{{\d\+"
syntax match helpTitle                    "\%1l\u.*$"                               contains=helpDate
syntax match helpExample                  "++[-=]*"                                 nextgroup=helpExample
syntax match helpExampleItem              "^\s*\zsExamples\=\ze:"                   nextgroup=helpExampleDelim
syntax match helpExampleItem              "^\s*\zsExample\ze \d\+:"       skipwhite nextgroup=helpExampleNum
syntax match helpExampleItem              "^\s*\zsEx\.\ze \d\+:"          skipwhite nextgroup=helpExampleNum
syntax match helpExampleNum    contained  "\d\+"                          skipwhite nextgroup=helpExampleDelim
syntax match helpExampleDelim  contained  ":"
syntax clear helpNote
syntax match helpNote                     "\cnote:"

syntax match helpLabel "^\%(Function:\|^Description:\|Related:\)"

" From a suggestion by osse in #vim
syntax match doNotWant "{not in Vi}" conceal

if expand('%:p') =~# '\<BASIS\>'
  " Extra basis syntax:
  syntax region helpBasis                  matchgroup=Ignore start='\~' matchgroup=Ignore end='\~'
  syntax match helpBasisKeyword            '^\%2l\h\w*\'\=\s*\ze[(]'
  highlight link helpBasis                     helpBasisKeyword
  highlight link helpBasisKeyword              PreProc
endif

" Extra Highlighting:
" ---------------------------------------------------------------------
highlight link helpBox1          helpBox
highlight link helpBox2          helpBox
highlight link helpBox3          helpBox
highlight link helpBox4          helpBox
highlight link helpBox5          helpBox
highlight link helpSectionTitle  helpHeader
highlight link helpSecTitleBlank helpSectionTitle
highlight link helpSectionNmbr   Statement
highlight link helpBox           Delimiter
highlight link helpFold          Ignore
highlight link helpTitle         PreProc
highlight link helpDate          Delimiter
highlight link helpExampleNum    Number
highlight link helpExampleDelim  Delimiter
highlight link helpExampleItem   Statement
highlight link helpLabel         Statement
setlocal foldmethod=syntax
