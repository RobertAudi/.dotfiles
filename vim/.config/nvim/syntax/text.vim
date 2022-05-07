" Vim syntax-highlighting for text
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax clear

" Lists
" + | * | - | 1. | IV) | a)
" + | * | - | 2. | XI) | b)
syntax case ignore
syntax match txtList /^\s*\%(\%([-*+]\|\d\+\.\?\)\s*)\?\|\%(\a\|[ivxlcdm]\+\)\s*[.)]\)\ze\s/

" Notes and TODOs
syntax case match
syntax keyword txtNote    NOTE EXAMPLE   contained
syntax keyword txtTodo    TODO FIXME XXX contained
syntax match   txtComment /#.*$/ contains=txtNote,txtTodo

" Titles and sections
syntax match txtH1Title /\%(\%(^\s*\n\|\%^\).*\)\@<=\a[^[:punct:]]\{-}\ze\%({{{\d\+\)\?\n\%(^\s*$\)\@=/
syntax match txtH1Title /\a.\{-}\ze\%({{{\d\+\)\?\n\%(^\s*=\{3,}\s*$\)\@=/
syntax match txtH2Title /\a.\{-}\ze\%({{{\d\+\)\?\n\%(^\s*-\{3,}\s*$\)\@=/

" Section delimiters ( --- or ,,, or ... )
syntax match txtSectionDelimiter '^\s*[_=*-,."]\{3,}\s*$'
syntax match txtSectionDelimiter /^\s*[[:punct:]]\{4,}\s*$/

" URLs and emails
syntax match txtLink "["'`({[<]\?\zs\S\+\.\%(co\.uk\|bg\|es\|fr\|ru\|us\|com\|edu\|gov\|org\|net\|live\)"

" Very generic match allowing URLs like ldaps://...
syntax match txtLink "\<\a\+:///\?\S\+"

" scheme://username:password@domain:port/path?query_string#fragment_id
"                            protocol               user:pass          sub/domain .com, .co.uk         port       qs
"                     ======================------------------------=============================----------------===
syntax match txtLink "\<\%(https\?\|ftp\)://\%(\w\+\%(:\w\+\)\?@\)\?\a\%(-\|\w\)*\%(\.\w\{2,}\)\+\%(:\d\{1,5}\)\?\S*"

"                                             user      @          domain
"                                      =================-===========================
syntax match txtEmail "\<\%(mailto:\)\?[-_.%[:alnum:]]\+@[-.[:alnum:]]\+\.\a\{2,4}\>"

" Date and Time
" Year/01-12/01-31
syntax match txtDate "[[:digit:]]\{1,4}\([-/.]\)\%(0\?[1-9]\|1[0-2]\)\1\%([12][[:digit:]]\|0\?[1-9]\|3[01]\)"

" 01-31/01-12/Year
syntax match txtDate "\%([12][[:digit:]]\|0\?[1-9]\|3[01]\)\([-/.]\)\%(0\?[1-9]\|1[0-2]\)\1[[:digit:]]\{1,4}"

" Time: (03:24:44 Pm)
syntax match txtTime "\%(0\?[[:digit:]]\|1[[:digit:]]\|2[0-3]\)\%(:[0-5][[:digit:]]\)\{1,2}\%([[:space:]]*[ap]m\)\?"

" Misc
syntax match   txtMonospace '\v(^|\s)\zs`[^`]{-1,}([^)]{-}\r?\n){-}[^`]{-}`\ze($|[[:blank:][:punct:]])'hs=s+1,he=e-1
syntax match   txtQuote '^\(>\($\| \)\)\+'
syntax match   txtQuote '\v(^|\s)\zs"[^"]{-1,}([^)]{-}\r?\n){-}[^"]{-}"\ze($|[[:blank:][:punct:]])'hs=s+1,he=e-1
syntax match   txtQuote "\v(^|\s)\zs'[^']{-1,}([^)]{-}\r?\n){-}[^']{-}'\ze($|[[:blank:][:punct:]])"hs=s+1,he=e-1
syntax match   txtSpecial '[©®™]\|(\%(C\|R\|TM\))'
syntax match   txtSpecial '\v<([1-9]%([0-9]*([,.][0-9]+)?|[0-9]{0,2}%(%( [0-9]{3,3})*%([,.][0-9]+)?|%([.][0-9]{3,3})*%(,[0-9]+)?|%(,[0-9]{3,3})*%([.][0-9]+)?))|0[,.][0-9]+)\s*(%(%(US)?\$|R\$?|%u20ac|\%)|%(USD?|Dollars?|BRL|Rea%(l|is)|EUR|Eur%(o|os)?|[Cc](en)?ts?)>)'
syntax match   txtSpecial '\v(%(%u20ac|\$)|<%(R\$|US[D$]?|BRL|EUR))\s*([1-9]%([0-9]*%([,.][0-9]+)?|[0-9]{0,2}%(%( [0-9]{3,3})*%([,.][0-9]+)?|%([.][0-9]{3,3})*%(,[0-9]+)?|%(,[0-9]{3,3})*%([.][0-9]+)?))|0[,.][0-9]+)>'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" color definitions (using Vim defaults)
highlight link txtList             Identifier
highlight link txtNote             PreProc
highlight link txtTodo             Todo
highlight link txtComment          Comment
highlight link txtH1Title          Title
highlight link txtH2Title          Title
highlight link txtSectionDelimiter PreProc
highlight link txtLink             Underlined
highlight link txtEmail            Underlined
highlight link txtDate             Constant
highlight link txtTime             Constant
highlight link txtMonospace        Special
highlight link txtQuote            Delimiter
highlight link txtSpecial          Special

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let b:current_syntax = 'text'
