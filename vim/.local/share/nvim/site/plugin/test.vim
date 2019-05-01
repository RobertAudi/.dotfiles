" Plugin: vim-test
" Description: Run your tests at the speed of thought
" URL: https://github.com/janko-m/vim-test

if empty($TMUX)
  let g:test#preserve_screen = 1
  let test#strategy = 'neovim'
else
  let g:test#preserve_screen = 0
  let test#strategy = 'vimux'
endif

let test#ruby#bundle_exec = 1
let test#ruby#use_binstubs = 0

let test#ruby#rspec#options = '--format documentation'

nmap <silent> <leader>R <Cmd>TestNearest<CR>
nmap <silent> <leader>r <Cmd>TestFile<CR>
