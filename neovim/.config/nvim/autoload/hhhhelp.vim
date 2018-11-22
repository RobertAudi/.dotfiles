function! hhhhelp#alternate(...) abort
  let bang = a:1
  let  arg = a:2
  " Searching for the help window.
  let helptabnr = 0
  let helpwinnr = 0
  for tnr in range(1, tabpagenr('$'))
    for wnr in range(1, tabpagewinnr(tnr, '$'))
      let buftype = gettabwinvar(tnr, wnr, '&buftype')
      if buftype ==# 'help'
        let helptabnr = tnr
        let helpwinnr = wnr
        break
      endif
    endfor
  endfor

  if helptabnr == 0 && helpwinnr == 0
    let width  = winwidth(0)
    let height = winheight(0)
    if width >= 140
      execute 'vert help' . bang . ' ' . arg
    elseif height >= 40 || height >= width/2
      execute 'help' . bang . ' ' . arg
    else
      execute 'tab help' . bang . ' ' . arg
    endif
  else
    execute 'normal! ' . helptabnr . 'gt'
    execute 'normal! ' . helpwinnr . "\<C-w>w"
    execute 'help' . bang . ' ' . arg
  endif
  normal! 0
endfunction

function! hhhhelp#GoToTableOfContent() abort
  try
    execute ':h ' . expand('%:t:r') . '-contents'
  catch /:E149:/
    normal! gg
    execute '/\v\*[A-z]+'
  endtry
endfunction
