" Plugin: vim-ini-fold
" Description: Provide foldexpr for ini-like files
" Author: Matthias Vogelgesang <github.com/matze>
" License: MIT license
" URL: https://github.com/matze/vim-ini-fold

function! IniFold#foldexpr(lnum) abort
  let l:line = getline(a:lnum)

  if l:line =~ '^\s*\[[^]]*\]'
    return '>1'
  endif

  return '='
endfunction

function! IniFold#activate() abort
  setlocal foldmethod=expr
  setlocal foldexpr=IniFold#foldexpr(v:lnum)

  if exists('b:undo_ftplugin')
    let b:undo_ftplugin .= " | setlocal foldexpr< foldmethod<"
  else
    let b:undo_ftplugin = "setlocal foldexpr< foldmethod<"
  endif
endfunction

function! IniFold#deactivate() abort
  setlocal foldmethod< foldexpr<
endfunction
