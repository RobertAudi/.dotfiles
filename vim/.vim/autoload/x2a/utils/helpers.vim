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

" Display a warning message.
function! x2a#utils#helpers#Warn(msg) abort
  echohl WarningMsg
  echomsg a:msg
  echohl NONE
endfunction

" Display an error message.
function! x2a#utils#helpers#Error(msg) abort
  echohl ErrorMsg
  echomsg a:msg
  echohl NONE
  let v:errmsg = a:msg
endfunction
