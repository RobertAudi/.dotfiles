" Plugin: vim-test
" Description: Run your tests at the speed of thought
" URL: https://github.com/janko-m/vim-test

if has('gui_vimr')
  let g:test#strategy = empty($TMUX) ? 'neovim' : 'vimux'
else
  let g:test#strategy = {
        \   'nearest': 'neovim',
        \   'file':    empty($TMUX) ? 'neovim' : 'vimux',
        \   'suite':   empty($TMUX) ? 'neovim' : 'vimux',
        \ }
endif

if empty($TMUX)
  let g:test#preserve_screen = 1
else
  let g:test#preserve_screen = 0
endif


let g:test#ruby#bundle_exec = 1
let g:test#ruby#use_binstubs = 0

nmap <silent> <Leader>R <Cmd>TestNearest<CR>
nmap <silent> <Leader>r <Cmd>TestFile<CR>
nnoremap \R :TestNearest<Space>
