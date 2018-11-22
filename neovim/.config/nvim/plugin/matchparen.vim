" Use MatchParen in favor of of showmatch
if exists('g:loaded_matchparen') && exists(':DoMatchParen')
  set noshowmatch
  silent! execute 'DoMatchParen'
else
  set showmatch
endif

" itchyny/vim-parenmatch
" ------------------------------------------------------------------------------
let g:parenmatch_highlight = 0
highlight! link ParenMatch Underlined
