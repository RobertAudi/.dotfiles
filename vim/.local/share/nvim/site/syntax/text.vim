" MARKDOWN CODE
syntax match txtMonospace "``\?\([^`]\)*`\?`"
highlight def link txtMonospace String

" + | * | - | 1. | IV) | a)
" + | * | - | 2. | XI) | b)
syntax case ignore
syntax match txtList /^\s*\%(\%([-*+]\|\d\+\.\?\)\s*)\?\|\%(\a\|[ivxlcdm]\+\)\s*[.)]\)\ze\s/
syntax case match
highlight link txtList Identifier

" Notes and TODOs
syntax case ignore
" syntax match txtNote /\%(^\s*\n\|\%^\)\@<=\s*[^[:digit:]].*:\ze\%(\s*{{{\d\+\)\?\s*$/
syntax match txtNote /\%(note\|ex\%(ample\)\?\):/
syntax case match
highlight link txtNote PreProc

syntax match txtTodo /@\?todo\s*:\?/
highlight link txtTodo Todo

syntax match txtComments /#.*$/
highlight link txtComments Comment

" Titles and sections
syntax match txtH1Title /\%(\%(^\s*\n\|\%^\).*\)\@<=\a[^[:punct:]]\{-}\ze\%({{{\d\+\)\?\n\%(^\s*$\)\@=/
syntax match txtH1Title /\a.\{-}\ze\%({{{\d\+\)\?\n\%(^\s*=\{3,}\s*$\)\@=/
syntax match txtH2Title /\a.\{-}\ze\%({{{\d\+\)\?\n\%(^\s*-\{3,}\s*$\)\@=/
highlight link txtH1Title Title
highlight link txtH2Title Title

" Section delimiters ( --- or ,,, or ... )
syntax match txtSectionDelimiter /^\s*[[:punct:]]\{3,}\s*$/
highlight link txtSectionDelimiter PreProc

" URLs and emails
syntax match txtLink "["'`({[<]\?\zs\S\+\.\%(co\.uk\|bg\|es\|fr\|ru\|us\|com\|edu\|gov\|org\|net\|live\)"
" Very generic match allowing URLs like ldaps://...
syntax match txtLink "\<\a\+:///\?\S\+"

" scheme://username:password@domain:port/path?query_string#fragment_id
"                            protocol               user:pass          sub/domain .com, .co.uk         port       qs
"                     ======================------------------------=============================----------------===
syntax match txtLink "\<\%(https\?\|ftp\)://\%(\w\+\%(:\w\+\)\?@\)\?\a\%(-\|\w\)*\%(\.\w\{2,}\)\+\%(:\d\{1,5}\)\?\S*"
highlight link txtLink Underlined

"                                             user      @          domain
"                                      =================-===========================
syntax match txtEmail "\<\%(mailto:\)\?[-_.%[:alnum:]]\+@[-.[:alnum:]]\+\.\a\{2,4}\>"
highlight link txtEmail Underlined

" Date and Time
" Year/01-12/01-31
syntax match txtDate "[[:digit:]]\{1,4}\([-/.]\)\%(0\?[1-9]\|1[0-2]\)\1\%([12][[:digit:]]\|0\?[1-9]\|3[01]\)"
" 01-31/01-12/Year
syntax match txtDate "\%([12][[:digit:]]\|0\?[1-9]\|3[01]\)\([-/.]\)\%(0\?[1-9]\|1[0-2]\)\1[[:digit:]]\{1,4}"
highlight link txtDate Constant

" Time: (03:24:44 Pm)
syntax match txtTime "\%(0\?[[:digit:]]\|1[[:digit:]]\|2[0-3]\)\%(:[0-5][[:digit:]]\)\{1,2}\%([[:space:]]*[ap]m\)\?"
highlight link txtTime Constant
