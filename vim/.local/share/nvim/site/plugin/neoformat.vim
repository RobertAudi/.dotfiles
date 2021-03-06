" Plugin: neoformat
" Description: A (Neo)vim plugin for formatting code
" URL: https://github.com/sbdchd/neoformat

" Have Neoformat only msg when there is an error
let g:neoformat_only_msg_on_error = 1

" Enable alignment
let g:neoformat_basic_format_align = 1

" Enable tab to spaces conversion
let g:neoformat_basic_format_retab = 1

" Enable trimmming of trailing whitespace
let g:neoformat_basic_format_trim = 1

nnoremap <silent> <Leader>= <Cmd>Neoformat<CR>
xnoremap <silent> <Leader>= <Cmd>Neoformat<CR>
