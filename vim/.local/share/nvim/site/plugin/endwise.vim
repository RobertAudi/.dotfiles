" Plugin: vim-endwise
" Description: Wisely add "end" in ruby, endfunction/endif/more in vim script, etc
" URL: https://github.com/tpope/vim-endwise

" This is shit but the mapping in plugin/coc.vim breaks endwise
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR><Plug>DiscretionaryEnd"
