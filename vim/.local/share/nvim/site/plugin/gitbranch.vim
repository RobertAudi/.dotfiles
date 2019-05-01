" Plugin: vim-gitbranch
" Description: Provides the branch name of the current git repository
" URL: https://github.com/itchyny/vim-gitbranch

" Show git branch with ctrl-g info
nnoremap <C-g> <Cmd>call x2a#gitbranch#ctrl_g(v:count)<CR>
