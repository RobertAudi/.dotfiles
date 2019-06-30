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

let g:x2a#lightline#ignored_special_filetypes =
      \ [
      \   'help',
      \   'qf',
      \   'man'
      \ ]

let g:x2a#lightline#ignored_plugin_filetypes =
      \ [
      \   'fzf',
      \   'nerdtree',
      \   'ctrlsf',
      \   'vista',
      \ ]

let g:x2a#lightline#special_filetypes =
      \ {
      \   'help': 'Help',
      \   'qf':   'Quickfix',
      \   'man':  'Man',
      \ }

let g:x2a#lightline#plugin_filetypes =
      \ {
      \   'fzf':      'FZF',
      \   'nerdtree': 'NERDTree',
      \   'ctrlsf':   'CtrlSF',
      \   'vista':    'Vista',
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
      \   'method':       'x2a#lightline#NearestMethodOrFunction'
      \ }

let g:lightline.component_expand = {
      \   'lineinfo': 'x2a#lightline#LineInfo',
      \   'percent':  'x2a#lightline#Percent',
      \ }

let g:lightline.component_type = {
      \ }

let g:lightline.active = {
      \   'left':  [['mode', 'paste'], ['gitbranch', 'filename', 'filetype'], ['method']],
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

" Modeline {{{
" vim: set foldmarker={{{,}}} foldlevel=0 foldmethod=marker : }}}
