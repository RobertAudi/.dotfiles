function! x2a#lightline#Filetype()
  let l:filetypes = ['help', 'qf', 'man']
  return index(l:filetypes, &filetype) >= 0
endfunction

function! x2a#lightline#Filename()
  let l:filename  = expand('%:t')
  let l:filenames = ['ControlP', 'NERD', '__CtrlSF']
  for l:f in l:filenames
    if l:filename =~? l:f
      return 1
    endif
  endfor
  return 0
endfunction

function! x2a#lightline#LineInfo()
  if x2a#lightline#Filetype() || x2a#lightline#Filename()
    return ''
  else
    return '%3l:%-2v'
  endif
endfunction

function! x2a#lightline#Percent()
  if x2a#lightline#Filetype() || x2a#lightline#Filename()
    return ''
  else
    return '%3p%%'
  endif
endfunction

function! x2a#lightline#Modified()
  if &readonly
    return ''
  elseif &filetype =~# 'help' || !&modifiable
    return "\ue0a2"
  elseif &modified
    return "\u25cb"
  else
    return ''
  endif
endfunction

function! x2a#lightline#Readonly()
  return &filetype !~? 'help' && &readonly ? "\ue0a2" : ''
endfunction

function! x2a#lightline#Filename()
  let l:filename = expand('%:t')
  return  l:filename ==? 'ControlP' && has_key(g:lightline, 'ctrlp_item') ? g:lightline.ctrlp_item :
        \ l:filename =~? 'NERD\|__CtrlSF' ? '' :
        \ ('' !=# x2a#lightline#Readonly() ? x2a#lightline#Readonly() . ' ' : '') .
        \ ('' !=# l:filename   ? l:filename         : '[No Name]') .
        \ ('' !=# x2a#lightline#Modified() ? ' ' . x2a#lightline#Modified() : '')
endfunction

function! x2a#lightline#GitBranch()
  let l:symbol = '±'
  let l:branch = gitbranch#name()
  if x2a#lightline#Filetype() || x2a#lightline#Filename() || !strlen(l:branch)
    return ''
  else
    return l:symbol . ' ' . l:branch
  endif
endfunction

function! x2a#lightline#Filetype()
  if x2a#lightline#Filename() || winwidth(0) <= 60
    return ''
  else
    return strlen(&filetype) ? '[' . &filetype . ']' : 'no ft'
  endif
endfunction

function! x2a#lightline#Mode()
  if x2a#lightline#Filetype()
    return ''
  endif

  let l:filename = expand('%:t')
  return  l:filename ==? 'ControlP'   ? 'CtrlP'    :
        \ l:filename ==? '__CtrlSF__' ? 'CtrlSF'   :
        \ l:filename =~? 'NERD_tree'  ? 'NERDTree' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! x2a#lightline#InactiveMode()
  return x2a#lightline#Filename() ? x2a#lightline#Mode() : ''
endfunction

