function! s:exec(cmd) abort
  let l:eventignore_keep = &eventignore
  let l:lazyredraw_keep  = &lazyredraw

  set eventignore=all
  set lazyredraw

  try
    execute a:cmd
  catch /.*/
    call x2a#utils#echo#Error(v:exception)
  endtry

  let &eventignore = l:eventignore_keep
  let &lazyredraw  = l:lazyredraw_keep
endfunction

function! x2a#buffers#CountModifiedBuffers() abort
  return len(filter(getbufinfo(), 'getbufvar(v:val.bufnr, "&modified")'))
endfunction

function! x2a#buffers#Count() abort
  return len(filter(getbufinfo(), 'v:val.listed && empty(getbufvar(v:val.bufnr, "&buftype")) && !empty(v:val.name)'))
endfunction

function! x2a#buffers#BufOnly(bang) abort
  if getbufvar('%', '&filetype') ==# 'nerdtree'
    silent! NERDTreeClose

    call x2a#buffers#BufDeleteAll(a:bang)

    silent! NERDTreeToggle

    return
  endif

  let l:bdelete = 'bdelete'
  if a:bang
    let l:bdelete .= '!'
  endif

  let l:currentWindow = winnr()
  let l:currentBuffer = bufnr('%')
  let l:buffers = filter(getbufinfo(), 'v:val.listed || v:val.loaded')
  let l:reopenNERDTree = exists('g:NERDTree') && g:NERDTree.IsOpen()
  let l:deletedCount = 0

  let l:eventignore_keep = &eventignore
  let l:lazyredraw_keep  = &lazyredraw

  set eventignore=all
  set lazyredraw

  " Close all tabs
  silent! tabonly

  " Close NERDTree in the current tab
  silent! NERDTreeClose

  for l:buffer in l:buffers
    if l:buffer.bufnr == l:currentBuffer
      continue
    endif

    if getbufvar(l:buffer.bufnr, '&filetype') ==# 'nerdtree'
      silent! NERDTreeClose

      continue
    endif

    if l:buffer.changed && !a:bang
      let l:message = 'No write since last change for buffer ' . l:buffer.bufnr . ' (add ! to override)'

      call x2a#utils#echo#Warning(l:message)

      continue
    endif

    silent execute l:bdelete . ' ' . l:buffer.bufnr

    let l:deletedCount += 1
  endfor

  silent! only

  if l:reopenNERDTree
    execute 'keepjumps keepalt NERDTreeToggle | keepjumps keepalt ' . l:currentWindow . 'wincmd w'
  endif

  let &eventignore = l:eventignore_keep
  let &lazyredraw  = l:lazyredraw_keep

  let l:message = l:deletedCount . ' buffer' . (l:deletedCount > 1 ? 's' : '') . ' deleted'

  call x2a#utils#echo#Message(l:message)
endfunction

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

    if l:buffer_filetype ==# 'nerdtree' || l:buffer_filetype ==# 'vista'
      silent! bwipeout!

      continue
    elseif l:buffer.changed && !a:bang
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

function! x2a#buffers#BufDeleteAll(bang) abort
  let l:bdelete = 'bdelete'
  if a:bang
    let l:bdelete .= '!'
  endif

  let l:buffers = filter(getbufinfo(), 'v:val.listed || v:val.loaded')

  let l:NERDTree_bufnr = exists('t:NERDTreeBufName') ? bufnr(t:NERDTreeBufName) : ''
  let l:reopenNERDTree = exists('g:NERDTree') && g:NERDTree.ExistsForTab()
  let l:deletedCount = 0

  " Close all tabs
  silent! tabonly

  " Close NERDTree in the current tab
  silent! NERDTreeClose

  for l:buffer in l:buffers
    let l:buffer_filetype = getbufvar(l:buffer.bufnr, '&filetype')

    if l:buffer_filetype ==# 'nerdtree' && l:reopenNERDTree && l:buffer.bufnr == l:NERDTree_bufnr
      continue
    elseif l:buffer_filetype ==# 'vista'
      silent! Vista!

      continue
    elseif l:buffer.changed && !a:bang
      let l:message = 'No write since last change for buffer ' . l:buffer.bufnr . ' (add ! to override)'

      call x2a#utils#echo#Warning(l:message)

      continue
    else
      silent execute l:bdelete . ' ' . l:buffer.bufnr
    endif

    let l:deletedCount += 1
  endfor

  if l:reopenNERDTree
    execute 'keepjumps keepalt NERDTreeToggle | keepjumps keepalt wincmd w'
  endif

  let l:message = l:deletedCount . ' buffer' . (l:deletedCount > 1 ? 's' : '') . ' deleted'

  if exists('*lightline#update')
    silent! call lightline#update()
  endif

  call x2a#utils#echo#Message(l:message)
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
