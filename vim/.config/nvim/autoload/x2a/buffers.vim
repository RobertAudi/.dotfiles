function! x2a#buffers#BufDeleteInactive(bang) abort
  let l:bdelete  = 'bdelete'
  let l:bwipeout = 'bwipeout'

  if a:bang
    let l:bdelete  .= '!'
    let l:bwipeout .= '!'
  endif

  let l:buffers = filter(getbufinfo(), '(v:val.listed || v:val.loaded) && empty(v:val.windows)')
  let l:deletedCount = 0

  for l:buffer in l:buffers
    let l:buffer_filetype = getbufvar(l:buffer.bufnr, '&filetype')

    if l:buffer_filetype ==# 'NvimTree'
      continue
    elseif l:buffer_filetype ==# 'aerial' || !l:buffer.listed
      silent! bwipeout!

      continue
    elseif l:buffer.changed && l:buffer.listed && !a:bang
      let l:message = 'No write since last change for buffer ' . l:buffer.bufnr . ' (add ! to override)'

      call x2a#utils#echo#Warning(l:message)

      continue
    endif

    let l:buftype = getbufvar(l:buffer.bufnr, '&buftype')
    let l:buffer_is_empty = nvim_buf_line_count(l:buffer.bufnr) == 1 && empty(getbufline(l:buffer.bufnr, '$'))

    if l:buftype ==# 'nofile' || !l:buffer.listed || l:buffer_is_empty
      let l:command = l:bwipeout
    else
      let l:command = l:bdelete
    endif

    silent execute l:command . ' ' . l:buffer.bufnr

    if ((empty(l:buftype) && !empty(l:buffer.name)) || l:buftype ==# 'nofile') && !l:buffer_is_empty
      let l:deletedCount += 1
    endif
  endfor

  let l:message = l:deletedCount . ' buffer' . (l:deletedCount > 1 ? 's' : '') . ' deleted'

  call x2a#utils#echo#Message(l:message)
endfunction
