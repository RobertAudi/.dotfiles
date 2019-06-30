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

nmap <silent> <Leader>R <Cmd>TestNearest<CR>
nmap <silent> <Leader>r <Cmd>TestFile<CR>
nnoremap \R :TestNearest<Space>
