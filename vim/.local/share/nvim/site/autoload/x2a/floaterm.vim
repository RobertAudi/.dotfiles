function! x2a#floaterm#hide() abort
  if getbufvar('%', '&filetype') !=# 'floaterm'
        \ || !exists('g:floaterm.index.border_bufnr')
        \ || !bufexists(g:floaterm.index.border_bufnr)
        \ || g:floaterm.index.border_bufnr == 0
    return
  endif

  silent! execute 'wincmd q'
  silent! execute 'bwipeout ' . g:floaterm.index.border_bufnr
endfunction
