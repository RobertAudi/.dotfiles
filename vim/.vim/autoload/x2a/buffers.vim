function! x2a#buffers#BufOnly(bang) abort
  let l:currentBuffer = bufnr('%')
  let l:lastBuffer = bufnr('$')

  let l:bdelete = 'bdelete'
  if a:bang
    let l:bdelete .= '!'
  endif

  let l:deletedCount = 0
  let l:n = 1
  while l:n <= l:lastBuffer
    if l:n != l:currentBuffer && buflisted(l:n)
      if getbufvar(l:n, '&modified') && !a:bang
        echohl ErrorMsg
        echomsg 'No write since last change for buffer '
              \ . l:n . ' (add ! to override)'
        echohl None
      else
        silent execute l:bdelete . ' ' . l:n
        let l:deletedCount += 1
      endif
    endif
    let l:n += 1
  endwhile

  if l:deletedCount == 1
    echomsg l:deletedCount . ' buffer deleted'
  elseif l:deletedCount > 1
    echomsg l:deletedCount . ' buffers deleted'
  endif
endfunction

function! x2a#buffers#BufDeleteInactive(bang) abort
  let l:bdelete = 'bdelete'
  if a:bang
    let l:bdelete .= '!'
  endif

  " Get a list of all buffers in all tabs
  let l:tablist = []
  for l:n in range(tabpagenr('$'))
    call extend(l:tablist, tabpagebuflist(l:n + 1))
  endfor

  " Below originally inspired by Hara Krishna Dara and Keith Roberts
  " http://tech.groups.yahoo.com/group/vim/message/56425
  let l:deletedCount = 0
  for l:n in range(1, bufnr('$'))
    if !bufexists(l:n)
      continue
    endif

    if getbufvar(l:n, '&modified') && !a:bang
      echohl ErrorMsg
      echomsg 'No write since last change for buffer '
            \ . l:n . ' (add ! to override)'
      echohl None
    elseif index(l:tablist, l:n) == -1
      silent execute l:bdelete . ' ' . l:n

      if !buflisted(l:n)
        let l:deletedCount += 1
      endif
    endif
  endfor

  if l:deletedCount == 1
    echomsg l:deletedCount . ' buffer deleted'
  elseif l:deletedCount > 1
    echomsg l:deletedCount . ' buffers deleted'
  endif
endfunction

function! x2a#buffers#BufDeleteAll(bang) abort
  let l:bdelete = 'bdelete'
  if a:bang
    let l:bdelete .= '!'
  endif

  " Below originally inspired by Hara Krishna Dara and Keith Roberts
  " http://tech.groups.yahoo.com/group/vim/message/56425
  let l:deletedCount = 0
  for l:n in range(1, bufnr('$'))
    if getbufvar(l:n, '&filetype') ==# 'nerdtree'
      silent! execute 'NERDTreeClose'
      continue
    elseif getbufvar(l:n, '&modified') && !a:bang
      echohl ErrorMsg
      echomsg 'No write since last change for buffer '
            \ . l:n . ' (add ! to override)'
      echohl None
      continue
    else
      silent! execute l:bdelete . ' ' . l:n
    endif

    let l:deletedCount += 1
  endfor

  if l:deletedCount == 1
    echomsg l:deletedCount . ' buffer deleted'
  elseif l:deletedCount > 1
    echomsg l:deletedCount . ' buffers deleted'
  endif
endfunction

" Description: Select the entire file
function! x2a#buffers#Select() abort
  keepjumps normal! ggVG
endfunction

" Description: Reindent the entire file
function! x2a#buffers#Reindent() abort
  keepjumps normal! gg=G
endfunction

" Description: Copy the entire file
function! x2a#buffers#Yank() abort
  keepjumps normal! ggyG
endfunction
