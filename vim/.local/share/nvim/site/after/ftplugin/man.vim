set timeoutlen=0

setlocal nocursorline
setlocal readonly
setlocal nomodifiable
setlocal nolist
setlocal wrap
setlocal keywordprg=:man

if getbufvar('%', '&timeoutlen') != 0
  set timeoutlen=0
endif

nmap <buffer> <silent> <CR> <C-]>

nmap     <buffer> <silent> <CR>      <Cmd>nohlsearch<Bar>echo<CR>
nnoremap <buffer> <silent> <Space>   <Cmd>nohlsearch<Bar>echo<CR>
nnoremap <buffer> <silent> <S-Space> <Cmd>nohlsearch<Bar>echo<CR>

noremap <buffer> <silent> d <C-d>
noremap <buffer> <silent> u <C-u>

map <buffer> <silent> <Space>   <C-d>
map <buffer> <silent> <S-Space> <C-u>

nnoremap <buffer> <silent> q <Cmd>bwipeout<CR>
nnoremap <buffer> <silent> Q <Cmd>bwipeout<CR>
