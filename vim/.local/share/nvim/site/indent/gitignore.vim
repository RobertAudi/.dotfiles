" Vim indent file
" Language:   .gitignore
" Maintainer: gisphm <phmfk@hotmail.com>
" URL:        https://github.com/gisphm/vim-gitignore

if exists('b:did_indent')
  finish
endif
let b:did_indent = 1

let s:save_cpo = &cpo
set cpo&vim

setlocal indentexpr=GetGitignoreIndent()
setlocal nolisp
setlocal noautoindent

" Only define the function once
if exists('*GetGitignoreIndent')
  finish
endif

function! s:is_li_start(line)
  return  a:line !~? '^ *\([*-]\)\%( *\1\)\{2}\%( \|\1\)*$' &&
        \ a:line =~? '^\s*[*+-] \+'
endfunction

function! s:is_blank_line(line)
  return a:line =~# '^$'
endfunction

function! s:prevnonblank(lnum)
  let l:i = a:lnum

  while l:i > 1 && s:is_blank_line(getline(l:i))
    let l:i -= 1
  endwhile

  return l:i
endfunction

function GetGitignoreIndent()
  let l:list_ind = 4

  " Find a non-blank line above the current line.
  let l:lnum = prevnonblank(v:lnum - 1)

  " At the start of the file use zero indent.
  if l:lnum == 0
    return 0
  endif

  let l:ind   = indent(l:lnum)
  let l:line  = getline(l:lnum) " Last line
  let l:cline = getline(v:lnum) " Current line

  if s:is_li_start(l:cline)
    " Current line is the first line of a list item, do not change indent
    return indent(v:lnum)
  elseif s:is_li_start(l:line)
    " Last line is the first line of a list item, increase indent
    return l:ind + l:list_ind
  else
    return l:ind
  endif
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
