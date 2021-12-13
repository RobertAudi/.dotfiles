function! x2a#TitleString#helpSign() abort
  if &filetype ==# 'help' || &filetype ==# 'man'
    return ' ' . g:x2a#TitleString#help_symbol . ' '
  else
    return ''
  endif
endfunction

function! x2a#TitleString#modifiedSign() abort
  return &modified ? ' ' . g:x2a#TitleString#modified_symbol . ' ' : ''
endfunction

function! x2a#TitleString#workingDirectory() abort
  return fnamemodify(getcwd(), ':t')
endfunction

function! x2a#TitleString#filename() abort
  let l:ftype = &filetype
  let l:filename = expand('%')

  if l:filename ==# ''
    return '[No Name]'
  elseif l:ftype ==# 'help'
    return 'Help'
  elseif l:ftype ==# 'NvimTree'
    return 'NvimTree'
  elseif l:ftype ==# 'ctrlsf'
    return 'CtrlSF'
  elseif l:ftype ==# 'fzf'
    return 'FZF'
  else
    return substitute(l:filename, getcwd(), '', '')
  endif
endfunction

function! x2a#TitleString#build() abort
  let l:help_sign = x2a#TitleString#helpSign()
  let l:modified_sign = x2a#TitleString#modifiedSign()
  let l:working_dir   = x2a#TitleString#workingDirectory()
  let l:filename      = x2a#TitleString#filename()

  return    l:help_sign
        \ . l:modified_sign
        \ . l:filename
        \ . ' ' . g:x2a#TitleString#separator . ' '
        \ . l:working_dir
endfunction
