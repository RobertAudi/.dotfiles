"=============================================================================
" FILE: autoload/is.vim
" AUTHOR: haya14busa
" License: MIT license
"=============================================================================

if has_key(g:plugs, 'is.vim')
  finish
endif

scriptencoding utf-8

" Make sure move cursor by search related action __after__ calling this
" function because the first move event just set nested autocmd which
" does :nohlsearch
" @expr
function! is#auto_nohlsearch(after_n_moves) abort
  call s:auto_nohlsearch(a:after_n_moves)
  return ''
endfunction

noremap  <silent><expr> <Plug>(_is-nohlsearch) is#auto_nohlsearch(1)
noremap! <silent><expr> <Plug>(_is-nohlsearch) is#auto_nohlsearch(1)
nnoremap <silent>       <Plug>(_is-nohlsearch) :<C-u>nohlsearch<CR>
xnoremap <silent>       <Plug>(_is-nohlsearch) :<C-u>nohlsearch<CR>gv

function! s:auto_nohlsearch(after_n_moves) abort
  " NOTE: :h autocmd-searchpat
  "   You cannot implement this feature without feedkeys() because of
  "   :h autocmd-searchpat
  augroup plugin-is-auto-nohlsearch-internal
    autocmd!
    autocmd InsertEnter * :call <SID>attach_on_insert_leave() |
    \                     autocmd! plugin-is-auto-nohlsearch-internal
    execute join([
    \   'autocmd CursorMoved *'
    \ , repeat('autocmd plugin-is-auto-nohlsearch-internal CursorMoved * ', a:after_n_moves - 1)
    \ , 'call feedkeys("\<Plug>(_is-nohlsearch)", "m")'
    \ , '| autocmd! plugin-is-auto-nohlsearch-internal'
    \ ], ' ')
  augroup END
endfunction

function! s:attach_on_insert_leave() abort
  augroup plugin-is-auto-nohlsearch-internal-on-insert-leave
    autocmd!
    autocmd InsertLeave * :call is#auto_nohlsearch(1)
    \ | autocmd! plugin-is-auto-nohlsearch-internal-on-insert-leave
  augroup END
endfunction

" vim: expandtab softtabstop=2 shiftwidth=2 foldmethod=marker
