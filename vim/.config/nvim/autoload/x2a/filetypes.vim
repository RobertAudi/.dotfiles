function! x2a#filetypes#SetFileType(bang, filetype) abort
  if a:bang
    execute 'setlocal filetype=' . a:filetype
  else
    execute 'setfiletype ' . a:filetype
  endif
endfunction

" URL:    https://github.com/kballard/.vim
" Source: https://github.com/kballard/.vim/blob/8ad9711b7c4781bead66f25b942ca1d8997efa48/vimrc#L1984-L1990
function! x2a#filetypes#ReloadFiletype() abort
  let l:old_filetype = &filetype
  setfiletype none

  " ensure all the syntax items are cleared out
  syntax clear
  let &l:filetype = l:old_filetype
endfunction
