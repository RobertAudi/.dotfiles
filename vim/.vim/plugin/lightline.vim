scriptencoding utf-8

" Don't show the current mode
" Let lightline take care of that
set noshowmode

let g:lightline = {}
let g:lightline.colorscheme = 'eighties'

let g:readmode_mode_map = { 'mode': 'passive' }

let g:lightline.component_function = {
      \   'gitbranch':    'RAGitBranch',
      \   'readonly':     'RAReadonly',
      \   'modified':     'RAModified',
      \   'filename':     'RAFilename',
      \   'filetype':     'RAFiletype',
      \   'mode':         'RAMode',
      \   'inactivemode': 'RAInactiveMode',
      \   'ctrlpmark':    'RACtrlPMark',
      \ }

let g:lightline.component_expand = {
      \   'lineinfo': 'RALineInfo',
      \   'percent':  'RAPercent',
      \ }

let g:lightline.component_type = {
      \ }

let g:lightline.active = {
      \   'left':  [['readmode', 'mode', 'paste'], ['gitbranch', 'filename', 'filetype'], ['ctrlpmark']],
      \   'right': [['lineinfo'], ['percent']]
      \ }

let g:lightline.inactive = {
      \   'left':  [['inactivemode'], ['filename']],
      \   'right': []
      \ }

let g:lightline.tabline = {
      \   'left':  [['tabs']],
      \   'right': []
      \ }

let g:lightline.subseparator = {
      \   'left':  '|',
      \   'right': '|'
      \ }

" ---------------------------------------------------------------------- {{{

function! RAFuckingFiletype()
  let l:filetypes = ['help', 'qf', 'man']
  return index(l:filetypes, &filetype) >= 0
endfunction

function! RAFuckingFilename()
  let l:filename  = expand('%:t')
  let l:filenames = ['ControlP', 'NERD', '__CtrlSF']
  for l:f in l:filenames
    if l:filename =~? l:f
      return 1
    endif
  endfor
  return 0
endfunction

function! RALineInfo()
  if RAFuckingFiletype() || RAFuckingFilename()
    return ''
  else
    return '%3l:%-2v'
  endif
endfunction

function! RAPercent()
  if RAFuckingFiletype() || RAFuckingFilename()
    return ''
  else
    return '%3p%%'
  endif
endfunction

function! RAModified()
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

function! RAReadonly()
  return &filetype !~? 'help' && &readonly ? "\ue0a2" : ''
endfunction

function! RAFilename()
  let l:filename = expand('%:t')
  return  l:filename ==? 'ControlP' && has_key(g:lightline, 'ctrlp_item') ? g:lightline.ctrlp_item :
        \ l:filename =~? 'NERD\|__CtrlSF' ? '' :
        \ ('' !=# RAReadonly() ? RAReadonly() . ' ' : '') .
        \ ('' !=# l:filename   ? l:filename         : '[No Name]') .
        \ ('' !=# RAModified() ? ' ' . RAModified() : '')
endfunction

function! RAGitBranch()
  let l:symbol = '±'
  let l:branch = gitbranch#name()
  if RAFuckingFiletype() || RAFuckingFilename() || !strlen(l:branch)
    return ''
  else
    return l:symbol . ' ' . l:branch
  endif
endfunction

function! RAFiletype()
  if RAFuckingFilename() || winwidth(0) <= 60
    return ''
  else
    return strlen(&filetype) ? '[' . &filetype . ']' : 'no ft'
  endif
endfunction

function! RAMode()
  if RAFuckingFiletype()
    return ''
  endif

  let l:filename = expand('%:t')
  return  l:filename ==? 'ControlP'   ? 'CtrlP'    :
        \ l:filename ==? '__CtrlSF__' ? 'CtrlSF'   :
        \ l:filename =~? 'NERD_tree'  ? 'NERDTree' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! RAInactiveMode()
  return RAFuckingFilename() ? RAMode() : ''
endfunction

function! RACtrlPMark()
  if expand('%:t') =~? 'ControlP' && has_key(g:lightline, 'ctrlp_item')
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

" ---------------------------------------------------------------------- }}}

let g:ctrlp_status_func = {
  \   'main': 'CtrlPStatusFunc_1',
  \   'prog': 'CtrlPStatusFunc_2'
  \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_regex = a:regex
  let g:lightline.ctrlp_prev  = a:prev
  let g:lightline.ctrlp_item  = a:item
  let g:lightline.ctrlp_next  = a:next
  return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
  return lightline#statusline(0)
endfunction
