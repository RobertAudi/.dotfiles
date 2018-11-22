" janko-m/vim-test
" ------------------------------------------------------------------------------
if empty($TMUX)
  let g:test#preserve_screen = 1
  let test#strategy = 'iterm'
else
  let g:test#preserve_screen = 0
  let test#strategy = 'vimux'
endif

let test#ruby#bundle_exec = 1
let test#ruby#use_binstubs = 0
let test#ruby#rspec#options = '--format documentation'

nmap <silent> ,R :TestNearest<CR>
nmap <silent> ,r :TestFile<CR>
