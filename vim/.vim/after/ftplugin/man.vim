set timeoutlen=0

setlocal nocursorline
setlocal readonly
setlocal nomodifiable
setlocal nolist
setlocal wrap
setlocal keywordprg=:help

nmap <buffer> <silent> <CR> <C-]>

nmap     <buffer> <silent> <CR>      :nohlsearch<Bar>echo<CR>
nnoremap <buffer> <silent> <Space>   :nohlsearch<Bar>echo<CR>
nnoremap <buffer> <silent> <S-Space> :nohlsearch<Bar>echo<CR>

noremap <buffer> <silent> d <C-d>
noremap <buffer> <silent> u <C-u>

map <buffer> <silent> <Space>   <C-d>
map <buffer> <silent> <S-Space> <C-u>

nnoremap <buffer> <silent> q :quit<CR>
nnoremap <buffer> <silent> Q :quit<CR>
