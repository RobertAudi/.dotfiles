" Plugin: janko-m/vim-test
" Description: Run your tests at the speed of thought
" URL: https://github.com/janko-m/vim-test

let g:test#custom_strategies = { 'toggleterm': function('x2a#test#ToggleTermStrategy') }
let g:test#strategy = 'toggleterm'
let g:test#preserve_screen = 0
let g:test#ruby#bundle_exec = 1
let g:test#ruby#use_binstubs = 0

nmap <silent> <Leader>R <Cmd>TestNearest<CR>
nmap <silent> <Leader>r <Cmd>TestFile<CR>
