" Execute commands without moving cursor,
" changing search pattern
"
" - First parameter is a function name to
"   call as a string
" - Second (optional) parameter is an
"   array of arguments to pass to the
"   function
function! x2a#utils#helpers#Preserve(func, ...) abort
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

" Author: Andrew Radev
" URL: https://github.com/AndrewRadev/Vimfiles
" Source: https://github.com/AndrewRadev/Vimfiles/blob/b02e9ed925c9eeecc4629ac1cc8b235d432f64f6/startup/commands.vim#L153,157
function! x2a#utils#helpers#redraw() abort
  syntax sync fromstart

  nohlsearch

  redraw!
endfunction
