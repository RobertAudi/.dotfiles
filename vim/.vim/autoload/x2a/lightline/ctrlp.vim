function! x2a#lightline#ctrlp#CtrlPMark() abort
  if &filetype ==# 'ctrlp' && has_key(g:lightline, 'ctrlp_item')
    call lightline#link('iR'[g:lightline.ctrlp_regex])
    return lightline#concatenate([
          \   g:lightline.ctrlp_prev,
          \   g:lightline.ctrlp_item,
          \   g:lightline.ctrlp_next
          \ ], 0)
  else
    return ''
  endif
endfunction
