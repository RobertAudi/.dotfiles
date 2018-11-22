" Universal opposite of J
function! breakhere#BreakHere() abort
  s/^\(\s*\)\(.\{-}\)\(\s*\)\(\%#\)\(\s*\)\(.*\)/\1\2\r\1\4\6
  call histdel('/', -1)
endfunction
