scriptencoding utf-8

function! x2a#TitleString#readOnlySign() abort
  let l:ftype = &filetype
  let l:filename = expand('%')
  if l:filename ==# '' && l:ftype ==# ''
    return ' ☃ '
  elseif l:ftype ==# 'help'
    return ' ℹ︎ '
  elseif l:ftype ==# 'nerdtree'
    return ' ❖ '
  elseif buflisted(bufnr('%')) && (&readonly || !&modifiable)
    return ' ✖︎ '
  else
    return ''
  endif
endfunction

function! x2a#TitleString#modifiedSign() abort
  return &modified ? ' ◉ ' : ''
endfunction

function! x2a#TitleString#workingDirectory() abort
  return substitute(getcwd(), $HOME, '~', '')
endfunction

function! x2a#TitleString#filename() abort
  let l:ftype = &filetype
  let l:filename = expand('%')

  if l:filename ==# ''
    return '[No Name]'
  elseif l:ftype ==# 'help'
    return 'Help'
  elseif l:ftype ==# 'nerdtree'
    return 'NERDTree'
  elseif l:ftype ==# 'ctrlsf'
    return 'CtrlSF'
  elseif expand('%:t') =~? 'ControlP'
    return 'ControlP'
  else
    return substitute(l:filename, getcwd(), '', '')
  endif
endfunction

function! x2a#TitleString#build() abort
  let l:readonly_sign = x2a#TitleString#readOnlySign()
  let l:modified_sign = x2a#TitleString#modifiedSign()
  let l:working_dir   = x2a#TitleString#workingDirectory()
  let l:filename      = x2a#TitleString#filename()
  return       '' . l:readonly_sign . ''
        \ .    '' . l:working_dir   . ''
        \ . ' - ' . l:filename      . ''
        \ .    '' . l:modified_sign . ''
endfunction
