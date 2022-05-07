" 30% of the screen for the netrw window, 70% for the file window
let g:netrw_winsize = -30

" hide banner
let g:netrw_banner = 0

" ignore case on sorting
let g:netrw_sort_options = 'i'

" buffer setting
let g:netrw_bufsettings = 'nomodifiable nomodified readonly nobuflisted nowrap'

" keep current directory immune from the browsing directory.
let g:netrw_keepdir = 1

" set tree style listing
let g:netrw_liststyle = 3

" open file in a previous buffer (right window)
let g:netrw_browse_split = 4

" hide swp, DS_Store files
let g:netrw_list_hide = '.*\.swp$,\.DS_Store'

" display directories first
let g:netrw_sort_sequence = '[\/]$'

" Do not store netrw history in a location `.netrwhist` file.
let g:netrw_dirhistmax = 0
