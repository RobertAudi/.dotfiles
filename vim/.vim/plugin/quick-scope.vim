" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" Disable plugin on long lines
let g:qs_max_chars = 120

augroup qs_colors
  autocmd!
  autocmd VimEnter,ColorScheme * highlight QuickScopePrimary   guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
  autocmd VimEnter,ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81  cterm=underline
  autocmd BufEnter ControlP,NERD_tree_\d\+ let b:qs_local_disable = 1
augroup END
