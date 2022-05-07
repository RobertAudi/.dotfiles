" Plugin: jumpy.vim
" Requires: foldutil.vim
" Description: Filetype-specific mappings for [[ and ]]
" Author: Martin Tournoij <martin@arp242.net>
" License: MIT license
" URL: https://github.com/arp242/jumpy.vim

if exists('g:loaded_jumpy')
  finish
endif

let g:loaded_jumpy = v:true

" Make sure line-continuations won't cause any problem. This will be restored
"   at the end
let s:save_cpo = &cpo
set cpo&vim

augroup JumpyAutomap
  autocmd!

  autocmd FileType *
        \ if exists('b:jumpy_pattern')
        \ | call jumpy#map(b:jumpy_pattern) |
        \ endif
augroup END

" Outline the contents of the buffer
command! -nargs=* JumpyOutline call jumpy#outline(<f-args>)

" Restore cpo.
let &cpo = s:save_cpo
unlet s:save_cpo
