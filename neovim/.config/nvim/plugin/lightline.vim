scriptencoding utf-8

" itchyny/lightline.vim {{{
" ------------------------------------------------------------------------------
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
      \ }

let g:lightline.component_expand = {
      \   'lineinfo': 'RALineInfo',
      \   'percent':  'RAPercent',
      \ }

let g:lightline.component_type = {
      \ }

let g:lightline.active = {
      \   'left':  [['readmode', 'mode', 'paste'], ['gitbranch', 'filename', 'filetype']],
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
  return  l:filename =~? 'NERD\|__CtrlSF' ? '' :
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
  return  l:filename ==? '__CtrlSF__' ? 'CtrlSF'   :
        \ l:filename =~? 'NERD_tree'  ? 'NERDTree' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! RAInactiveMode()
  return RAFuckingFilename() ? RAMode() : ''
endfunction
" ---------------------------------------------------------------------- }}}
