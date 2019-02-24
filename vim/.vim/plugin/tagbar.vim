" Plugin: tagbar
" Description: Vim plugin that displays tags in a window, ordered by scope
" URL: https://github.com/majutsushi/tagbar

scriptencoding utf-8

let g:tagbar_width     = 30
let g:tagbar_autoclose = 0
let g:tagbar_autofocus = 0
let g:tagbar_compact   = 1
let g:tagbar_sort      = 0
let g:tagbar_iconchars = ['▸', '▾']
let g:tagbar_autoshowtag = 0

nnoremap _  :TagbarOpen fj<CR>
nnoremap g_ :TagbarOpen<CR>

augroup RAPluginsTagbar
  autocmd!

  " Make sure Tagbar has always the same size
  autocmd BufEnter,BufWinEnter __Tagbar__\.\d\+ execute 'vertical resize ' . g:tagbar_width
  autocmd BufLeave,BufWinLeave __Tagbar__\.\d\+ execute 'vertical resize ' . g:tagbar_width
augroup END
