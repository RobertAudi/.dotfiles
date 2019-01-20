" Variables {{{
" ==============================================================================

let g:x2a#lightline#ignored_filetypes = ['help', 'qf', 'man']
let g:x2a#lightline#ignored_plugin_filetypes = ['ctrlp', 'nerdtree', 'ctrlsf', 'fzf']

let g:x2a#lightline#special_filetypes =
      \ {
      \   'help': 'Help',
      \   'man':  'Man',
      \ }

let g:x2a#lightline#plugin_filetypes =
      \ {
      \   'ctrlp':    'CtrlP',
      \   'nerdtree': 'NERDTree',
      \   'ctrlsf':   'CtrlSF',
      \   'fzf':      'FZF',
      \ }

" ============================================================================== }}}

" Predicates {{{
" ==============================================================================

function! x2a#lightline#IgnoreFiletype()
  return index(g:x2a#lightline#ignored_filetypes, &filetype) >= 0
endfunction

function! x2a#lightline#IgnorePluginFiletype()
  return index(g:x2a#lightline#ignored_plugin_filetypes, &filetype) >= 0
endfunction

function! x2a#lightline#IsSpecialFiletype()
  return has_key(g:x2a#lightline#special_filetypes, &filetype)
endfunction

function! x2a#lightline#IsPluginFiletype()
  return has_key(g:x2a#lightline#plugin_filetypes, &filetype)
endfunction

" ============================================================================== }}}

function! x2a#lightline#LineInfo()
  if x2a#lightline#IgnoreFiletype() || x2a#lightline#IgnorePluginFiletype()
    return ''
  else
    return '%3l:%-2v'
  endif
endfunction

function! x2a#lightline#Percent()
  if x2a#lightline#IgnoreFiletype() || x2a#lightline#IgnorePluginFiletype()
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
  return  &filetype ==# 'ctrlp' && has_key(g:lightline, 'ctrlp_item') ? g:lightline.ctrlp_item :
        \ x2a#lightline#IgnorePluginFiletype() ? '' :
        \ ('' !=# x2a#lightline#Readonly() ? x2a#lightline#Readonly() . ' ' : '') .
        \ ('' !=# l:filename   ? l:filename         : '[No Name]') .
        \ ('' !=# x2a#lightline#Modified() ? ' ' . x2a#lightline#Modified() : '')
endfunction

function! x2a#lightline#GitBranch()
  let l:symbol = '±'
  let l:branch = gitbranch#name()
  if x2a#lightline#IgnoreFiletype() || x2a#lightline#IgnorePluginFiletype() || !strlen(l:branch)
    return ''
  else
    return l:symbol . ' ' . l:branch
  endif
endfunction

function! x2a#lightline#Filetype()
  if x2a#lightline#IsPluginFiletype() || x2a#lightline#IsSpecialFiletype() || winwidth(0) <= 60
    return ''
  else
    return strlen(&filetype) ? '[' . &filetype . ']' : 'no ft'
  endif
endfunction

function! x2a#lightline#Mode()
  return  x2a#lightline#IsPluginFiletype() ? g:x2a#lightline#plugin_filetypes[&filetype] :
        \ x2a#lightline#IsSpecialFiletype() ? g:x2a#lightline#special_filetypes[&filetype] :
        \ x2a#lightline#IgnoreFiletype() ? '' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! x2a#lightline#InactiveMode()
  if x2a#lightline#IsPluginFiletype() || x2a#lightline#IsSpecialFiletype()
    return x2a#lightline#Mode()
  else
    return ''
  endif
endfunction

" Modeline {{{
" vim: set foldmarker={{{,}}} foldlevel=0 foldmethod=marker : }}}
