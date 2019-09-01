" Plugin: jumpy.vim
" Description: Filetype-specific mappings for [[ and ]]
" URL: https://github.com/arp242/jumpy.vim

" Function declaration/expression
"
" At any indentation level, and only named ones, for obvious reasons.
call jumpy#map('\v^\s*%(function\s*\w|%(var|let) \w*\s+\=\s+%(function\(|\(.{-}\)\s*\=\>\s*))')
