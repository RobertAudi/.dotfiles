" Plugin: vim-obsession
" Description: Continuously updated session files
" URL: https://github.com/tpope/vim-obsession

command! -nargs=0 ResumeSession source Session.vim
command! -nargs=0 SaveSession Obsession .
