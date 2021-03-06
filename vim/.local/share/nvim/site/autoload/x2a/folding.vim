function! s:resolve_lnum(lnum) abort
  return type(a:lnum) == type(0) ? a:lnum : line(a:lnum)
endfunction

function! x2a#folding#can_open_fold(lnum) abort
  return foldclosed(s:resolve_lnum(a:lnum)) > -1
endfunction

function! x2a#folding#can_close_fold(lnum) abort
  let l:lnum = s:resolve_lnum(a:lnum)
  let l:foldlevel = foldlevel(l:lnum)

  return l:foldlevel > 0 && foldclosed(l:lnum) == -1 &&
        \ (foldlevel(l:lnum - 1) < l:foldlevel || foldlevel(l:lnum + 1) < l:foldlevel)
endfunction

function! x2a#folding#can_toggle_fold(lnum) abort
  return  x2a#folding#can_open_fold(a:lnum) || x2a#folding#can_close_fold(a:lnum)
endfunction

function! x2a#folding#focus_fold(lnum) abort
  let l:lnum = s:resolve_lnum(a:lnum)
  let l:foldlevel = foldlevel(l:lnum)

  if l:foldlevel == 0
    return
  endif

  let l:keys = 'zM'
  let l:currentfoldlevel = 1

  while l:currentfoldlevel <= l:foldlevel
    let l:keys .= 'zo'
    let l:currentfoldlevel = l:currentfoldlevel + 1
  endwhile

  execute 'normal! ' . l:keys

  call x2a#movements#window#CenterCursorAesthetically()
endfunction
