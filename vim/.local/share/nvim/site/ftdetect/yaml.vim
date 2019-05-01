autocmd BufRead,BufNewFile yarn.lock   setfiletype yaml
autocmd BufRead,BufNewFile *gemrc      setfiletype yaml
autocmd BufRead,BufNewFile Procfile*   setfiletype yaml
autocmd BufRead,BufNewFile .env,.env.* setlocal filetype=yaml
