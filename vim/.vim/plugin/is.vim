"=============================================================================
" FILE: plugin/is.vim
" AUTHOR: haya14busa
" License: MIT license
"=============================================================================

if has_key(g:plugs, 'is.vim')
  finish
endif

scriptencoding utf-8
if expand('%:p') ==# expand('<sfile>:p')
  unlet! g:loaded_is
endif
if exists('g:loaded_is')
  finish
endif
let g:loaded_is = 1

" Execute :nohlsearch after one cursor move or other autocmd events.
noremap <expr> <Plug>(is-nohl-1) is#auto_nohlsearch(1)
noremap <expr> <Plug>(is-nohl-2) is#auto_nohlsearch(2)
map            <Plug>(is-nohl) <Plug>(is-nohl-2)
noremap <expr> <Plug>(is-nohl-3) is#auto_nohlsearch(3)

" To avoid recursive mapping.
noremap <Plug>(_is-n)  n
noremap <Plug>(_is-N)  N
noremap <Plug>(_is-*)  *
noremap <Plug>(_is-#)  #
noremap <Plug>(_is-g*) g*
noremap <Plug>(_is-g#) g#

map n  <Plug>(is-nohl)<Plug>(_is-n)
map N  <Plug>(is-nohl)<Plug>(_is-N)
map *  <Plug>(is-nohl)<Plug>(_is-*)
map #  <Plug>(is-nohl)<Plug>(_is-#)
map g* <Plug>(is-nohl)<Plug>(_is-g*)
map g# <Plug>(is-nohl)<Plug>(_is-g#)

if exists('##CmdlineLeave')
  augroup plugin-is
    autocmd!
    autocmd CmdlineLeave [/\?] :call is#auto_nohlsearch(2)
  augroup END
endif

" vim: expandtab softtabstop=2 shiftwidth=2 foldmethod=marker
