" TODO: Check the difference between `&l:wrap` && `v:count == 0`

function! x2a#movements#line#Zero() abort
  return v:count == 0 ? "g0" :  "0"
endfunction

function! x2a#movements#line#gZero() abort
  return v:count == 0 ?  "0" : "g0"
endfunction

function! x2a#movements#line#Caret() abort
  return v:count == 0 ? "g^" :  "^"
endfunction

function! x2a#movements#line#gCaret() abort
  return v:count == 0 ?  "^" : "g^"
endfunction

function! x2a#movements#line#Dollar() abort
  return v:count == 0 ? "g$" :  "$"
endfunction

function! x2a#movements#line#gDollar() abort
  return v:count == 0 ?  "$" : "g$"
endfunction

function! x2a#movements#line#Down() abort
  return v:count == 0 ? "gj" :  "j"
endfunction

function! x2a#movements#line#gDown() abort
  return v:count == 0 ?  "j" : "gj"
endfunction

function! x2a#movements#line#Up() abort
  return v:count == 0 ? "gk" :  "k"
endfunction

function! x2a#movements#line#gUp() abort
  return v:count == 0 ?  "k" : "gk"
endfunction

function! x2a#movements#line#Home() abort
  if col('.') == matchend(getline('.'), '^\s*') + 1
    return '0'
  else
    return '^'
  endif
endfunction

function! x2a#movements#line#End() abort
  if col('.') == match(getline('.'), '\s*$')
    return '$'
  else
    return 'g_'
  endif
endfunction

function! x2a#movements#line#vEnd() abort
  if col('.') == match(getline('.'), '\s*$')
    return '$h'
  else
    return 'g_'
  endif
endfunction
