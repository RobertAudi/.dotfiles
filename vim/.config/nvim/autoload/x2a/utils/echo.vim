function! s:echo(message, highlight) abort
  execute 'echohl ' . a:highlight
  echomsg a:message
  echohl NONE
endfunction

" Display a regular message.
function! x2a#utils#echo#Message(message) abort
  call s:echo(a:message, 'MoreMsg')
endfunction

" Display a warning message.
function! x2a#utils#echo#Warning(message) abort
  call s:echo('WARN: ' . a:message, 'WarningMsg')
endfunction

" Display an error message.
function! x2a#utils#echo#Error(message) abort
  call s:echo(a:message, 'ErrorMsg')
  let v:errmsg = a:message
endfunction

" Display a fatal error message.
function! x2a#utils#echo#FatalError(message) abort
  echohl ErrorMsg
  echoerr a:message
  echohl NONE
  let v:errmsg = a:message
endfunction
