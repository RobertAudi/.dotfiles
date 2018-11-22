" tpope/vim-surround
" ------------------------------------------------------------------------------
" Toggle between single/double quotes
nmap <silent> [' cs'"
nmap <silent> ]' cs"'
nmap <silent> [" cs"'
nmap <silent> ]" cs'"

AutocmdFT ruby,rails,eruby let b:surround_{char2nr('#')} = "#{\r}"
AutocmdFT ruby,rails,eruby let b:surround_{char2nr('%')} = "<% \r %>"
AutocmdFT ruby,rails,eruby let b:surround_{char2nr('=')} = "<%= \r %>"

AutocmdFT markdown let b:surround_{char2nr('*')} = "*\r*"
AutocmdFT markdown let b:surround_{char2nr('i')} = "*\r*"
AutocmdFT markdown let b:surround_{char2nr('b')} = "**\r**"

AutocmdFT markdown vmap <buffer> <C-i> Si
AutocmdFT markdown vmap <buffer> <C-b> Sb
