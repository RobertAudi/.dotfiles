highlight IncSearch cterm=NONE ctermfg=Black ctermbg=154 gui=NONE guifg=#000000 guibg=#c0cd38
highlight! link txtBold Identifier

" Set "TODO" & "FIXME" strings to be bold and standout as hell.
highlight Todo term=standout ctermfg=196 ctermbg=226 guifg=#ff4500 guibg=#eeee00

" Show deleted plugins after a :PlugClean[!]
highlight! link plugDeleted plugName
