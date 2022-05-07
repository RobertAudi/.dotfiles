function! x2a#colorswatch#generate(...) abort
  noautocmd keepalt keepjumps new

  let l:source_name = get(a:000, 0, g:x2a#colorswatch#source_name)
  let l:formatter_name = get(a:000, 1, g:x2a#colorswatch#formatter_name)

  if l:source_name ==? 'all'
    let l:source_name = 'original'
  endif

  let l:lines = colorswatch#format(colorswatch#source(l:source_name), l:formatter_name)

  if empty(l:lines)
    bwipeout
    return
  endif

  let b:matchup_matchparen_enabled = 0
  let b:better_whitespace_enabled = 0
  let w:highlighted_troll_stopper = 0

  setlocal nocursorline
  setlocal bufhidden=wipe
  setlocal nobuflisted
  setlocal buftype=nofile
  setlocal nolist
  setlocal nowrap
  setlocal keywordprg=

  call append(0, l:lines)

  silent execute '$delete'
  call cursor(1, 1)

  nnoremap <buffer> q <Cmd>bwipeout<CR>

  setlocal nomodified
  setlocal nomodifiable
  setlocal readonly
endfunction
