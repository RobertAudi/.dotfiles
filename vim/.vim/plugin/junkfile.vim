" Plugin: junkfile.vim
" Description: Create temporary file for memo, testing, etc.
" URL: https://github.com/RobertAudi/junkfile.vim

let g:junkfile#directory = expand($HOME . '/.tmp/vim/junk')

augroup RAPluginsJunkfile
  autocmd!

  execute 'autocmd BufRead,BufNewFile ' . g:junkfile#directory . '/* let b:ctrlp_working_path_mode = "w"'
augroup END
