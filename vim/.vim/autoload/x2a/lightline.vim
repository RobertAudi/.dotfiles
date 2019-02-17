function! x2a#lightline#LineInfo() abort
  if x2a#lightline#predicates#IgnoreFiletype(&filetype)
    return ''
  else
    return '%3l:%-2v'
  endif
endfunction

function! x2a#lightline#Percent() abort
  if x2a#lightline#predicates#IgnoreFiletype(&filetype)
    return ''
  else
    return '%3p%%'
  endif
endfunction

function! x2a#lightline#Modified() abort
  let l:ignore_filetype = x2a#lightline#predicates#IgnoreFiletype(&filetype)

  if l:ignore_filetype || &readonly || !&modifiable
    return ''
  elseif &modified
    return g:x2a#lightline#modified_symbol
  else
    return ''
  endif
endfunction

function! x2a#lightline#Readonly() abort
  if x2a#lightline#predicates#IgnoreFiletype(&filetype)
    return ''
  elseif &readonly || !&modifiable
    return g:x2a#lightline#lock_symbol
  else
    return ''
  endif
endfunction

function! x2a#lightline#Filename() abort
  let l:filename = expand('%:t')
  let l:readonly = x2a#lightline#Readonly()
  let l:modified = x2a#lightline#Modified()


  return  &filetype ==# 'ctrlp' && has_key(g:lightline, 'ctrlp_item') ? g:lightline.ctrlp_item :
        \ x2a#lightline#predicates#IgnorePluginFiletype(&filetype) ? '' :
        \ ('' !=# l:readonly ? l:readonly . ' ' : '') .
        \ ('' !=# l:filename ? l:filename : '[No Name]') .
        \ ('' !=# l:modified ? ' ' . l:modified : '')
endfunction

function! x2a#lightline#GitBranch() abort
  let l:branch = gitbranch#name()

  if x2a#lightline#predicates#IgnoreFiletype(&filetype) || !strlen(l:branch)
    return ''
  else
    return g:x2a#lightline#git_symbol . ' ' . l:branch
  endif
endfunction

function! x2a#lightline#Filetype() abort
  if x2a#lightline#predicates#IsPluginFiletype(&filetype) || x2a#lightline#predicates#IsSpecialFiletype(&filetype) || winwidth(0) <= 60
    return ''
  else
    return strlen(&filetype) ? '[' . &filetype . ']' : 'no ft'
  endif
endfunction

function! x2a#lightline#Mode() abort
  return  x2a#lightline#predicates#IsPluginFiletype(&filetype) ? g:x2a#lightline#plugin_filetypes[&filetype] :
        \ x2a#lightline#predicates#IsSpecialFiletype(&filetype) ? g:x2a#lightline#special_filetypes[&filetype] :
        \ x2a#lightline#predicates#IgnoreSpecialFiletype(&filetype) ? '' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! x2a#lightline#InactiveMode() abort
  if x2a#lightline#predicates#IsPluginFiletype(&filetype) || x2a#lightline#predicates#IsSpecialFiletype(&filetype)
    return x2a#lightline#Mode()
  else
    return ''
  endif
endfunction
