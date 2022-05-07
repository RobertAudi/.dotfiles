" Return the OS name
function! x2a#utils#os#name() abort
  if !exists('s:os')
    if has('win64') || has('win32') || has('win16')
      let s:os = 'Windows'
    elseif has('mac') || has('macunix') || has('gui_mac') || has('gui_vimr')
      let s:os = 'Darwin'
    else
      let s:os = substitute(system('uname'), '\n', '', '')
    endif
  endif

  return s:os
endfunction

function! x2a#utils#os#is_mac() abort
  if !exists('s:is_mac')
    let s:is_mac = x2a#utils#os#name() ==# 'Darwin'
  endif

  return s:is_mac
endfunction
