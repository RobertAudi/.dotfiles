function! x2a#filetypes#setFileType(bang, ...) abort
  if a:0
    if a:bang
      execute 'setlocal filetype=' . a:1
    else
      execute 'setfiletype ' . a:1
    endif
  else
    if x2a#utils#plugins#isInstalled('denite.nvim')
      Denite filetype
    else
      throw 'E471: Argument required'
    endif
  endif
endfunction
