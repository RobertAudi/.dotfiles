function! x2a#git#permalink(raw, line1, count) abort
  if !empty(getbufvar(bufnr('%'), '&buftype'))
    call x2a#utils#helpers#Warn('Buffer is not a file')
    return
  endif

  if !executable('git-permalink')
    throw 'Command not found: git-permalink'
  endif

  let l:line1 = a:count > 0 ? a:line1 : 0
  let l:line2 = a:count > 0 ? a:count : 0

  let l:cmd = 'git-permalink'

  if a:raw
    let l:cmd .= ' --raw'
  endif

  let l:cmd .= ' ' . shellescape(expand('%'))

  if l:line1
    let l:cmd .= ' ' . l:line1

    if l:line2
      let l:cmd .= ',' . l:line2
    endif
  endif

  let l:result = substitute(system(l:cmd), '\v\n$', '', '')

  if !v:shell_error
    return l:result
  else
    call x2a#utils#helpers#Warn(l:result)
  endif
endfunction

function! x2a#git#browse(raw, line1, count) abort
  let l:permalink = x2a#git#permalink(a:raw, a:line1, a:count)

  if empty(l:permalink)
    return
  endif

  let l:browser = $BROWSER

  if empty(l:browser)
    if executable('open')
      let l:browser = 'open'
    else
      call x2a#utils#helpers#Warn('Unable to resolve web browser or URL handler')
      return
    endif
  endif

  if !executable(l:browser)
    call x2a#utils#helpers#Warn('Web browser or URL handler not executable: ' . l:browser)
    return
  endif

  echomsg l:permalink

  silent call system(l:browser . ' ' . string(l:permalink))
endfunction

function! x2a#git#copy_permalink(raw, line1, count) abort
  let l:permalink = x2a#git#permalink(a:raw, a:line1, a:count)

  if empty(l:permalink)
    return
  endif

  if has('clipboard')
    let @+ = l:permalink
  else
    call x2a#utils#helpers#Warn('clipboard feature not available in Vim')
  endif

  echomsg l:permalink
endfunction
