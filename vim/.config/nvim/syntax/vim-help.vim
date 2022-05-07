if exists('b:current_syntax') && b:current_syntax ==# 'vim-help'
  finish
endif

runtime! syntax/help.vim
runtime! syntax/help/help.vim

" Make concealed groups visible
" ------------------------------------------------------------------------------

let s:ctermfg = get(g:, 'base16_cterm0E', '05')
let s:guifg = get(g:, 'base16_gui0E', 'b6b3eb')

let s:groups = ['helpIgnore', 'helpBar', 'helpBacktick', 'helpStar', 'helpFold']

for s:group in s:groups
  execute 'highlight ' . s:group . ' ctermfg=' . s:ctermfg . ' guifg=#' . s:guifg
endfor

" ------------------------------------------------------------------------------

let b:current_syntax = 'vim-help'
