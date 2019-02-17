" File: VimCloser.vim
" Author: Jordan W (@jordwalke)
" Description: Make Vim close tabs the way every other editor does - by switching to the next tab to the left.
" Last Modified: December 03, 2016

let s:prevtabnum = tabpagenr('$')
let s:prevtabnumfocused = tabpagenr()

function! s:TabFocusPrevious()
  if tabpagenr() > 1 && s:prevtabnumfocused != s:prevtabnum && tabpagenr('$') < s:prevtabnum
    tabprevious
  endif

  let s:prevtabnum = tabpagenr('$')
  let s:prevtabnumfocused = tabpagenr()
endfunction

augroup RAPluginsVimCloser
  autocmd!
  autocmd TabEnter * call <SID>TabFocusPrevious()
augroup END
