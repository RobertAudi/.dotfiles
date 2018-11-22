let g:ctrlp_extensions = ['modified']
let g:ctrlp_switch_buffer = 'et'

" Configure CtrlP for the path to search in on invocation:
" > The directory of the current file, unless it is a subdirectory of the cwd
let g:ctrlp_working_path_mode = 'a'

let g:ctrlp_match_window      = 'max:15,results:150'
let g:ctrlp_prompt_mappings   = {
      \   'PrtSelectMove("j")':   ['<C-j>', '<C-n>'],
      \   'PrtSelectMove("k")':   ['<C-k>', '<C-p>'],
      \   'PrtHistory(-1)':       ['<Down>'],
      \   'PrtHistory(1)':        ['<Up>'],
      \   'AcceptSelection("e")': ['<CR>'],
      \   'AcceptSelection("v")': ['<C-v>'],
      \   'PrtClearCache()':      ['<C-r>'],
      \   'PrtDeleteEnt()':       [''],
      \   'CreateNewFile()':      [''],
      \   'MarkToOpen()':         [''],
      \   'OpenMulti()':          [''],
      \   'PrtExit()':            ['<Esc>', '<C-c>', '<C-g>'],
      \ }

let g:ctrlp_custom_ignore = {
      \ 'dir':  '\v[\/](\.(git|hg|svn|gem)|(node_modules|bower_components|public\/assets|doc|.yardoc|tmp|log))$',
      \ 'file': '\.exe$\|\.so$\|\.dll$|\.min\.js\|.storyboard\|.xib\|.a',
      \ }

let g:ctrlp_user_command = x2a#ctrlp#user_command()
if x2a#ctrlp#has_fast_user_command()
  let g:ctrlp_user_caching = 0
  let g:ctrlp_clear_cache_on_exit = 1
else
  let g:ctrlp_use_caching = 1
  let g:ctrlp_clear_cache_on_exit = 0
endif

let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }

nnoremap <silent> <C-b> :CtrlPBuffer<CR>

if has('gui_running') && has('gui_macvim')
  nnoremap <D-p> :CtrlP<CR>
  inoremap <D-p> <Esc>:CtrlP<CR>
  nnoremap <D-b> :CtrlPBuffer<CR>
  inoremap <D-b> <Esc>:CtrlPBuffer<CR>
endif
