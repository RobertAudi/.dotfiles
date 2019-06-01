" gitignore filetype detect
" Language:     gitignore
" Maintainer:   wenxuangm@gmail.com
" Repository:   https://github.com/wfxr/vim-gitignore


autocmd BufRead,BufNewFile */.config/git/ignore setlocal filetype=gitignore
autocmd BufNewFile,BufRead *gitignore set filetype=gitignore
autocmd BufNewFile,BufRead .git/info/exclude set filetype=gitignore
