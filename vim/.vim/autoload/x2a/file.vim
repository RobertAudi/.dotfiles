" Description: Copy (to the system clipboard) the full path to current file
function! x2a#file#CopyFullPath() abort
  let l:path = expand('%:p')
  let @+=l:path
  echo 'Copied file path to system clipboard: ' . l:path
endfunction

" Description: Copy (to the system clipboard) the path to current file (relative to PWD)
function! x2a#file#CopyRelativePath() abort
  let l:path = expand('%')
  let @+=l:path
  echo 'Copied file path to system clipboard: ' . l:path
endfunction

" Description: Copy (to the system clipboard) the path to current file (relative to PWD)
"              with the line number ('my_folder/myfile:12')
function! x2a#file#CopyRelativePathWithLineNumber() abort
  let l:path = expand('%') . ':' . line('.')
  let @+=l:path
  echo 'Copied file path to system clipboard: ' . l:path
endfunction
