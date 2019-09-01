" genutils: Useful buffer, file and window related functions.
" Author: Hari Krishna Dara (hari_vim at yahoo dot com)
" Last Change: 15-Sep-2009 @ 19:25
" Requires: Vim-7.0
" Version: 2.5.1
" Licence: This program is free software; you can redistribute it and/or
"          modify it under the terms of the GNU General Public License.
"          See http://www.gnu.org/copyleft/gpl.txt

function! genutils#SaveHardPosition(id) abort
  let b:sp_col_{a:id} = virtcol('.')
  let b:sp_lin_{a:id} = line('.')

  " Avoid accounting for wrapped lines.
  let l:_wrap = &l:wrap

  try
    setlocal nowrap

    let b:sp_winline_{a:id} = winline()
  finally
    let &l:wrap = l:_wrap
  endtry
endfunction

function! genutils#RestoreHardPosition(id) abort
  " This doesn't take virtual column.
  "call cursor(b:sp_lin_{a:id}, b:sp_col_{a:id})

  " Vim7 generates E16 if line number is invalid.
  " TODO: Why is this leaving cursor on the last-but-one line when the condition meets?
  execute ((line('$') < b:sp_lin_{a:id}) ? line('$') : b:sp_lin_{a:id})

  "execute b:sp_lin_{a:id}

  execute ((line('$') < b:sp_lin_{a:id}) ? line('$') : b:sp_lin_{a:id})

  "execute b:sp_lin_{a:id}

  execute 'normal!' b:sp_col_{a:id} . '|'

  call genutils#MoveCurLineToWinLine(b:sp_winline_{a:id})
endfunction

function! genutils#MoveCurLineToWinLine(n) abort
  normal! zt

  if a:n == 1
    return
  endif

  let l:_wrap = &l:wrap

  setlocal nowrap

  let l:n = a:n

  if l:n >= winheight(0)
    let l:n = winheight(0)
  endif

  let l:n = l:n - 1

  execute 'normal! ' . l:n . "\<C-Y>"

  let &l:wrap = l:_wrap
endfunction

function! genutils#CmpByNumber(line1, line2, ...) abort
  let l:direction = (a:0 ? a:1 :1)
  let l:num1 = a:line1 + 0
  let l:num2 = a:line2 + 0

  if l:num1 < l:num2
    return -l:direction
  elseif l:num1 > l:num2
    return l:direction
  else
    return 0
  endif
endfunction
