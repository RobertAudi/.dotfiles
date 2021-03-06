" Plugin: ctrlsf.vim
" Description: An ack.vim alternative mimics Ctrl-Shift-F on Sublime Text 2
" URL: https://github.com/dyng/ctrlsf.vim

let g:ctrlsf_position       = 'bottom'
let g:ctrlsf_default_root   = 'project'
let g:ctrlsf_winsize        = '30%'
let g:ctrlsf_search_mode    = 'async'
let g:ctrlsf_case_sensitive = 'smart'
let g:ctrlsf_ignore_dir     = ['.git', '.gem', 'bower_components', 'node_modules']

let g:ctrlsf_auto_close =
      \ {
      \    'normal' : 1,
      \    'compact': 0
      \ }

let g:ctrlsf_auto_focus =
      \ {
      \    'at': 'start',
      \    'duration_less_than': 1000
      \ }

let g:ctrlsf_extra_backend_args =
      \ {
      \    'ag': '--hidden',
      \    'rg': '--hidden'
      \ }

nmap <C-f> <Plug>CtrlSFPrompt
xmap <C-f> <Plug>CtrlSFVwordExec

if has('gui_vimr')
  nmap <D-f> <C-f>
  xmap <D-f> <C-f>
  imap <D-f> <Esc><C-f>
endif
