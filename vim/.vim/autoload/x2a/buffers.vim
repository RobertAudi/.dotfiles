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

" Description: Delete buffer while keeping window layout (don't close buffer's windows).
" Last Change: 2008-11-18
" URL: http://vim.wikia.com/wiki/VimTip165
" License: CC-BY-SA
function! x2a#buffers#Bclose(bang, buffer) abort
  if empty(a:buffer)
    let l:btarget = bufnr('%')
  elseif a:buffer =~? '^\d\+$'
    let l:btarget = bufnr(str2nr(a:buffer))
  else
    let l:btarget = bufnr(a:buffer)
  endif

  if l:btarget < 0
    call x2a#utils#helpers#Warn('No matching buffer for ' . a:buffer)
    return
  endif

  if empty(a:bang) && getbufvar(l:btarget, '&modified')
    call x2a#utils#helpers#Warn('No write since last change for buffer ' . l:btarget . ' (use :Bclose!)')
    return
  endif

  " Numbers of windows that view target buffer which we will delete.
  let l:wnums = filter(range(1, winnr('$')), 'winbufnr(v:val) == l:btarget')

  if exists('g:bclose_multiple') && !g:bclose_multiple && len(l:wnums) > 1
    call x2a#utils#helpers#Warn('Buffer is in multiple windows (use ":let g:bclose_multiple = 1")')
    return
  endif

  let l:wcurrent = winnr()
  for l:w in l:wnums
    execute l:w . 'wincmd w'

    let l:prevbuf = bufnr('#')
    if l:prevbuf > 0 && buflisted(l:prevbuf) && l:prevbuf != l:w
      buffer #
    else
      bprevious
    endif

    if l:btarget == bufnr('%')
      " Numbers of listed buffers which are not the target to be deleted.
      let l:blisted = filter(range(1, bufnr('$')), 'buflisted(v:val) && v:val != l:btarget')

      " Listed, not target, and not displayed.
      let l:bhidden = filter(copy(l:blisted), 'bufwinnr(v:val) < 0')

      " Take the first buffer, if any (could be more intelligent).
      let l:bjump = (l:bhidden + l:blisted + [-1])[0]

      if l:bjump > 0
        execute 'buffer ' . l:bjump
      else
        execute 'enew' . a:bang
      endif
    endif
  endfor

  execute 'bdelete' . a:bang . ' ' . l:btarget
  execute l:wcurrent . 'wincmd w'
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

" Description: Copy (to the system clipboard) the full path to current file
function! x2a#buffers#CopyFullPath() abort
  let l:path = expand("%:p")
  let @+=l:path
  echo 'Copied file path to system clipboard: ' . l:path
endfunction

" Description: Copy (to the system clipboard) the path to current file (relative to PWD)
function! x2a#buffers#CopyRelativePath() abort
  let l:path = expand("%")
  let @+=l:path
  echo 'Copied file path to system clipboard: ' . l:path
endfunction

" Description: Copy (to the system clipboard) the path to current file (relative to PWD)
"              with the line number ('my_folder/myfile:12')
function! x2a#buffers#CopyRelativePathWithLineNumber() abort
  let l:path = expand("%") . ':' . line(".")
  let @+=l:path
  echo 'Copied file path to system clipboard: ' . l:path
endfunction

" vim: set foldlevel=0 foldmethod=syntax :
