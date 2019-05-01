function! x2a#help#alternate(bang, ...) abort
  if a:0 == 0
    if x2a#utils#plugins#isInstalled('denite.nvim')
      Denite help
      return
    else
      throw 'E471: Argument required'
    endif
  endif

  let l:subject = a:1

  " Searching for the help window.
  let l:helptabnr = 0
  let l:helpwinnr = 0

  for l:tnr in range(1, tabpagenr('$'))
    for l:wnr in range(1, tabpagewinnr(l:tnr, '$'))
      let l:buftype = gettabwinvar(l:tnr, l:wnr, '&buftype')

      if l:buftype ==# 'help'
        let l:helptabnr = l:tnr
        let l:helpwinnr = l:wnr
        break
      endif
    endfor
  endfor

  if l:helptabnr == 0 && l:helptabnr == 0
    let l:width  = winwidth(0)
    let l:heignt = winheight(0)

    if l:width >= 140
      execute 'vert help ' . l:subject
    elseif l:heignt >= 40 || l:heignt >= l:width / 2
      execute 'help ' . l:subject
    else
      execute 'tab help ' . l:subject
    endif
  else
    execute 'normal! ' . l:helptabnr . 'gt'
    execute 'normal! ' . l:helptabnr . "\<C-w>w"
    execute 'help ' . l:subject
  endif

  normal! 0

  if a:bang
    call x2a#help#maps#disable_q_mappings()
  endif

  call x2a#vim#remove_timeout()
endfunction

function! x2a#help#GoToTableOfContent() abort
  try
    execute ':h ' . expand('%:t:r') . '-contents'
  catch /:E149:/
    normal! gg
    execute '/\v\*[A-z]+'
  endtry
endfunction
