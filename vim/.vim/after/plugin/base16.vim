" Plugin: base16-vim
" Description: Base16 for Vim (colorsheme)
" URL: https://github.com/chriskempson/base16-vim

let base16colorspace = 256
colorscheme base16-railscasts

highlight clear SignColumn

highlight VertSplit    guifg=#393939 guibg=#393939 ctermfg=237 ctermbg=237
highlight CursorColumn guibg=#333435 ctermbg=237
highlight CursorLine   guibg=#333435 ctermbg=237

highlight IncSearch    ctermbg=3   ctermfg=1
highlight Search       ctermbg=1   ctermfg=3

highlight Visual       ctermbg=3   ctermfg=0
highlight Pmenu        ctermbg=240 ctermfg=12
highlight PmenuSel     ctermbg=3   ctermfg=1
