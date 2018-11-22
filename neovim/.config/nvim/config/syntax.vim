" Syntax {{{
" ------------------------------------------------------------------------------
highlight clear SignColumn

highlight VertSplit    guifg=#393939 guibg=#393939 ctermfg=237 ctermbg=237
highlight CursorColumn guibg=#333435 ctermbg=237
highlight CursorLine   guibg=#333435 ctermbg=237

highlight IncSearch    ctermbg=3   ctermfg=1
highlight Search       ctermbg=1   ctermfg=3

highlight Visual       ctermbg=3   ctermfg=0
highlight Pmenu        ctermbg=240 ctermfg=12
highlight PmenuSel     ctermbg=3   ctermfg=1

highlight! IncSearch cterm=NONE ctermfg=Black ctermbg=154 gui=NONE guifg=#000000 guibg=#c0cd38
highlight! link txtBold Identifier

" Set "TODO" & "FIXME" strings to be bold and standout as hell.
highlight! Todo term=standout ctermfg=196 ctermbg=226 guifg=#ff4500 guibg=#eeee00

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" Show deleted plugins after a :PlugClean[!]
highlight! link PlugDeleted plugName
" ------------------------------------------------------------------------------ }}}
