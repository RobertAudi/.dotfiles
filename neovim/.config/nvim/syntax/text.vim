" ACRONYMS {{{1
syntax match txtAcronym /\%([^-_A-Za-z0-9]\|^\)\zs\%(\u\|\d\)\{2,}\ze\%([^-_A-Za-z0-9]\|$\)/
highlight link txtAcronym Type

" Lists and numbers {{{1
syntax match txtNumber /\d\+/
highlight link txtNumber Constant

" * | - | 1. | IV) | a)
" * | - | 2. | XI) | b)
syntax case ignore
syntax match txtList /^\s*\%(\%([-*]\|\d\+\.\?\)\s*)\?\|\%(\a\|[ivxlcdm]\+\)\s*[.)]\)\ze\s/
syntax case match
highlight link txtList Constant

" Files {{{1
" Basename
syntax case match
syntax match txtBaseFileName "\%(\f\+\.\a\+\)\>"
syntax match txtBaseFileName "\%(\*\.\a\+\)\>"
syntax match txtBaseFileName "\%(README\|INSTALL\)\%(\.txt\)\?"
syntax case ignore
highlight link txtBaseFileName Identifier
" Unix absolute file path
syntax match txtFile "\%(\s\|^\)\zs\~\?/\f\+"

" Windows absolute file path
syntax match txtFile "[[:alpha:]]:\\\%(\k\+\\\)\+\k\+\%(\.[[:alpha:]]\+\)\?\>"
highlight link txtFile Identifier

" Strings and parens {{{1
" Note: skips don't or girl's between ''s
syntax region txtString start=/\z("\|'\%([st]\s\)\@!\)/ skip=/\\\z1/ end=/\z1/
" syntax region txtString start=/'\%(\%(ll\|[vr]e\|[stm]\)\%(\s\|$\)\)\@!/ skip=/\\'/ end=/'/
highlight link txtString Constant
syntax region txtStringCode start=/\z(`\)/ skip=/\\\z1/ end=/\z1/
highlight link txtStringCode txtCode

" Parens
syntax region txtParens matchgroup=Constant start=/\[/ end=/\]/ transparent
syntax region txtParens matchgroup=Constant start=/{/  end=/}/  transparent
syntax region txtParens matchgroup=Constant start=/(/  end=/)/  transparent

" Notes and TODOs {{{1
syntax case ignore
syntax match txtNote /\%(^\s*\n\|\%^\)\@<=\s*[^[:digit:]].*:\ze\%(\s*{{{\d\+\)\?\s*$/
syntax match txtNote /\%(note\|ex\%(ample\)\?\):/
syntax case match
highlight link txtNote PreProc

syntax match txtTodo /@\?todo\s*:\?/
highlight link txtTodo Todo

" Programming {{{1
" syntax keyword txtPLanguage sh bash c c++ perl python ruby php lisp haskell

syntax keyword txtEditor Vi[m] Emacs
highlight link txtEditor Special

syntax match txtOS "\%(Linux\|UNIX\|Mac OS \S\+\|Windows [78]\|OS/2\)"
highlight link txtOS Special

syntax match txtVariable /\$\w\+/
highlight link txtVariable PreProc

syntax match txtCode /\<\%(cd\|git\|c\?ssh\|wget\|dig\|su\s-\)\s\+\S\+/
syntax match txtCode /\<\%(vim\|touch\|rm\)\s\+\f\+/
syntax match txtCode /\<\%(cp\|scp\|yum\)\%(\s\+\S\+\)\{2}/
syntax match txtCode /||\|&&/
syntax match txtCode /curl.\{-}http\S\+/
syntax match txtCode :/etc/init.d/\S\+\s\S\+:
syntax match txtCode /puppet agent --test\%(\s--tags\s\S\+\)\?/
syntax match txtCode /\s\zs--\?\a\S*/
syntax match txtCode /\w\+\%(::\w\+\)\+/
syntax match txtCode /mysql\%(dump\)\?\|clush\|chkconfig\|slappasswd\|tcpdump\|\<ldap\a*/
syntax match txtCode /rake.\{-}migrate\|cap\s\+deploy/
syntax match txtCode /ruby.\{-}\.rb\|perl.\{-}\.pl\|mysql.\{-}\.sql/
highlight link txtCode Special

syntax match txtComments /#.*$/
highlight link txtComments Comment

syntax match txtExtra /\%({{{\|}}}\)\d\+\|^#.*\%$/
highlight txtExtra guifg=#605958 guibg=NONE

" Titles and sections {{{1
syntax match txtH1Title /\%(\%(^\s*\n\|\%^\).*\)\@<=\a[^[:punct:]]\{-}\ze\%({{{\d\+\)\?\n\%(^\s*$\)\@=/
syntax match txtH1Title /\a.\{-}\ze\%({{{\d\+\)\?\n\%(^\s*=\{3,}\s*$\)\@=/
syntax match txtH2Title /\a.\{-}\ze\%({{{\d\+\)\?\n\%(^\s*-\{3,}\s*$\)\@=/
highlight link txtH1Title Statement
highlight link txtH2Title Statement

" Section delimiters ( --- or ,,, or ... )
syntax match txtSectionDelimiter /^\s*[[:punct:]]\{3,}\s*$/
highlight link txtSectionDelimiter PreProc

" URLs and emails {{{1
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

" Date and Time {{{1
" Year/01-12/01-31
syntax match txtDate "[[:digit:]]\{1,4}\([-/.]\)\%(0\?[1-9]\|1[0-2]\)\1\%([12][[:digit:]]\|0\?[1-9]\|3[01]\)"
" 01-31/01-12/Year
syntax match txtDate "\%([12][[:digit:]]\|0\?[1-9]\|3[01]\)\([-/.]\)\%(0\?[1-9]\|1[0-2]\)\1[[:digit:]]\{1,4}"
highlight link txtDate Constant

" Time: (03:24:44 Pm)
syntax match txtTime "\%(0\?[[:digit:]]\|1[[:digit:]]\|2[0-3]\)\%(:[0-5][[:digit:]]\)\{1,2}\%([[:space:]]*[ap]m\)\?"
highlight link txtTime Constant

" Special abbreviations: e.g., ie {{{1
syntax match txtAbbrev "\s\zs\%(e\.\?g\.\?\|i\.\?e\.\?\)\ze\s"
highlight link txtAbbrev Type
