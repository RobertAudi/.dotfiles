" dyng/ctrlsf.vim
" ------------------------------------------------------------------------------
let g:ctrlsf_position     = 'bottom'
let g:ctrlsf_default_root = 'project'
let g:ctrlsf_winsize      = '40%'
let g:ctrlsf_extra_backend_args =
      \ {
      \    'ag': '--hidden',
      \    'rg': '--hidden'
      \ }

nmap <C-f> <Plug>CtrlSFPrompt
xmap <C-f> <Plug>CtrlSFVwordExec
