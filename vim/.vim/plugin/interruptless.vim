" Plugin: vim-interruptless
" Description: Makes vim interrupt you less
" Author: Bruno Sutic
" License: MIT license
" URL: https://github.com/vim-utils/vim-interruptless

if exists('g:loaded_interruptless') && g:loaded_interruptless
  finish
endif
let g:loaded_interruptless = 1

let s:save_cpoptions = &cpoptions
set cpoptions&vim

function! s:file_changed()
  let v:fcs_choice = 'just do nothing'
  let filename = expand('<afile>')
  " how to detect file created event?
  if v:fcs_reason ==# 'conflict'
    echohl WarningMsg
    echo 'Warning: File "'.filename.'" has changed and the buffer was changed in Vim as well'
    echohl None
  endif
endfunction

augroup RAPluginsInterruptless
  autocmd!
  autocmd FileChangedShell * call <SID>file_changed()
augroup END

let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions
