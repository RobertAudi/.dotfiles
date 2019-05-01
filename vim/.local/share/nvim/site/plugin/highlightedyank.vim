" Plugin: vim-highlightedyank
" Description: Make the yanked region apparent!
" URL: https://github.com/machakann/vim-highlightedyank

let g:highlightedyank_highlight_duration = 175

augroup RAPluginsHighlightedYank
  autocmd!

  autocmd ColorScheme * highlight HighlightedyankRegion ctermfg=01 ctermbg=08 guifg=#272935 guibg=#da4938 cterm=reverse gui=reverse
augroup END
