scriptencoding utf-8

" Don't show the current mode
" Let lightline take care of that
set noshowmode

let g:lightline = {}
let g:lightline.colorscheme = 'eighties'

let g:readmode_mode_map = { 'mode': 'passive' }

let g:lightline.component_function = {
      \   'gitbranch':    'x2a#lightline#GitBranch',
      \   'readonly':     'x2a#lightline#Readonly',
      \   'modified':     'x2a#lightline#Modified',
      \   'filename':     'x2a#lightline#Filename',
      \   'filetype':     'x2a#lightline#Filetype',
      \   'mode':         'x2a#lightline#Mode',
      \   'inactivemode': 'x2a#lightline#InactiveMode',
      \   'ctrlpmark':    'x2a#lightline#ctrlp#CtrlPMark',
      \ }

let g:lightline.component_expand = {
      \   'lineinfo': 'x2a#lightline#LineInfo',
      \   'percent':  'x2a#lightline#Percent',
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

" ----------------------------------------------------------------------

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

function! s:fzf_statusline()
  return lightline#statusline(0)
endfunction

autocmd! User FzfStatusLine call <SID>fzf_statusline()
