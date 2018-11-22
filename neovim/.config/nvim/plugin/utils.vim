" Execute commands without moving cursor,
" changing search pattern
"
" - First parameter is a function name to
"   call as a string
" - Second (optional) parameter is an
"   array of arguments to pass to the
"   function
function! s:Preserve(func, ...)
  let l:FuncRef = function(a:func)
  if a:0 > 0
    let l:args = a:1
  else
    let l:args = []
  endif

  let l:saved_search = @/
  let l:saved_view = winsaveview()

  let l:return_value = call(l:FuncRef, l:args)

  call winrestview(l:saved_view)
  let @/ = l:saved_search

  return l:return_value
endfunction

function! s:UnfuckWhitespace()
  " 1. Strip trailing whitespace
  %substitute/\s\+$//e
  " 2. Merge consecutive blank lines
  %substitute/\n\{3,}/\r\r/e
  " 3. Strip empty line from end of file
  %substitute/\n\+\%$//e
endfunction

function! s:ReindentBuffer()
  normal! gg=G
endfunction

function! s:YankBuffer()
  normal! ggyG
endfunction

function! s:NormalModeDigraph(char2)
  let l:char1 = matchstr(getline('.'), '.', byteidx(getline('.'), col('.') - 1))
  echo 'digraph: ' . l:char1 . a:char2
  return "r\<C-k>" . l:char1 . a:char2
endfunction

function! NormalizeWhitespace()
  return s:Preserve('<SID>UnfuckWhitespace')
endfunction

vnoremap <C-a> :call utils#Append()<CR>

nnoremap <LocalLeader>= :call <SID>Preserve("<SID>ReindentBuffer")<CR>
nnoremap <LocalLeader>y :call <SID>Preserve("<SID>YankBuffer")<CR>

command! -nargs=0 WhatSyntax call utils#WhatSyntax()
command! -bar ShowSyntax :echo 'Normal '.join(map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")'))

command! -nargs=+ -complete=command Page call utils#page(<q-args>)
