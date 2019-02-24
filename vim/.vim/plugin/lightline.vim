" Plugin: lightline.vim
" Description: A light and configurable statusline/tabline plugin for Vim
" URL: https://github.com/itchyny/lightline.vim

scriptencoding utf-8

" Don't show the current mode
" Let lightline take care of that
set noshowmode

" Variables {{{
" ------------------------------------------------------------------------------

let g:x2a#lightline#help_symbol     = get(g:, 'x2a#help_symbol',     "\u2139") " ℹ︎
let g:x2a#lightline#lock_symbol     = get(g:, 'x2a#lock_symbol',     "\ue0a2") " 
let g:x2a#lightline#modified_symbol = get(g:, 'x2a#modified_symbol', "\u25cb") " ○
let g:x2a#lightline#git_symbol      = get(g:, 'x2a#git_symbol',      "\u00b1") " ±

let g:x2a#lightline#separator = ''
let g:x2a#lightline#subseparator = get(g:, 'x2a#vertical_separator', "\u007c") " |

let g:x2a#lightline#ignored_special_filetypes = ['help', 'qf', 'man']
let g:x2a#lightline#ignored_plugin_filetypes = ['ctrlp', 'nerdtree', 'ctrlsf', 'tagbar']

let g:x2a#lightline#special_filetypes =
      \ {
      \   'help': 'Help',
      \   'qf':   'Quickfix',
      \   'man':  'Man',
      \ }

let g:x2a#lightline#plugin_filetypes =
      \ {
      \   'ctrlp':    'CtrlP',
      \   'nerdtree': 'NERDTree',
      \   'ctrlsf':   'CtrlSF',
      \   'tagbar':   'Tagbar',
      \ }

" ------------------------------------------------------------------------------ }}}

let g:lightline = {}
let g:lightline.colorscheme = 'eighties'

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
      \   'left':  [['mode', 'paste'], ['gitbranch', 'filename', 'filetype'], ['ctrlpmark']],
      \   'right': [['lineinfo'], ['percent']]
      \ }

let g:lightline.inactive = {
      \   'left':  [['inactivemode'], ['filename']],
      \   'right': []
      \ }

let g:lightline.tab = {
      \   'active':   ['tabnum', 'readonly', 'filename', 'modified'],
      \   'inactive': ['tabnum', 'readonly', 'filename', 'modified']
      \ }

let g:lightline.tab_component_function = {
      \   'filename': 'x2a#lightline#tab#Filename',
      \   'modified': 'x2a#lightline#tab#Modified',
      \   'readonly': 'x2a#lightline#tab#Readonly',
      \   'tabnum':   'x2a#lightline#tab#TabNumber'
      \ }

let g:lightline.tabline = {
      \   'left':  [['tabs']],
      \   'right': []
      \ }

let g:lightline.separator = {
      \   'left':  g:x2a#lightline#separator,
      \   'right': g:x2a#lightline#separator
      \ }

let g:lightline.subseparator = {
      \   'left':  g:x2a#lightline#subseparator,
      \   'right': g:x2a#lightline#subseparator
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

let g:tagbar_status_func = 'TagbarStatusFunc'

function! TagbarStatusFunc(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
  return lightline#statusline(0)
endfunction

" Modeline {{{
" vim: set foldmarker={{{,}}} foldlevel=0 foldmethod=marker : }}}
