" ---------------------------------------------------------------------------- "
" Description: Automatically insert a leading slash in VimL                    "
" Author: Alisue (@lambdalisue) <hashnote.net>                                 "
" Source: https://github.com/lambdalisue/vim-backslash                         "
" License: MIT                                                                 "
" ---------------------------------------------------------------------------- "

function! s:is_continuous() abort
  return getline('.') =~# '^\s*\\\s*'
endfunction

function! x2a#vim#backslash#smart_o() abort
  let l:lnum = line('.')
  let l:line = getline(l:lnum)
  let l:leading = matchstr(l:line, '^\s*\\\s*')
  call append(l:lnum, l:leading)
  call setpos('.', [0, l:lnum + 1, 0, 0])
  startinsert!
endfunction

function! x2a#vim#backslash#smart_CR_i() abort
  let l:lnum = line('.')
  let l:line = getline(l:lnum)
  if l:line =~# '^\s*\\\s*$'
    let l:indent = get(g:, 'vim_indent_cont', shiftwidth() * 3)
    let l:leading = matchstr(l:line, printf('^\s*\ze\s\{%d}\\', l:indent))
    call setline('.', l:leading)
    call setpos('.', [0, l:lnum, 0, 0])
    startinsert!
    return
  else
    let l:leading = matchstr(l:line, '^\s*\\\s*')
    let l:prefix = l:line[:col('.') - 1]
    let l:suffix = l:line[col('.'):]
    call setline('.', l:prefix)
    call append(l:lnum, l:leading . l:suffix)
    call setpos('.', [0, l:lnum + 1, len(l:leading) + 1, 0])
    execute len(l:suffix) ? 'startinsert' : 'startinsert!'
    return
  endif
endfunction

function! x2a#vim#backslash#map_o() abort
  if <SID>is_continuous()
    return ":\<C-u>call x2a#vim#backslash#smart_o()\<Enter>"
  else
    return 'o'
  endif
endfunction

function! x2a#vim#backslash#map_CR_i() abort
  if <SID>is_continuous()
    return "\<Esc>:\<C-u>call x2a#vim#backslash#smart_CR_i()\<Enter>"
  else
    return "\<Enter>"
  endif
endfunction
