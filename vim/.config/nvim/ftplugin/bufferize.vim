if getbufvar('%', '&timeoutlen') != 0
  set timeoutlen=0
endif

nnoremap <buffer> q <Cmd>quit<CR>
nnoremap <buffer> Q <Cmd>bwipeout!<CR>

nnoremap <buffer> <silent> <Space>   <Cmd>nohlsearch<Bar>echo<CR>
nnoremap <buffer> <silent> <S-Space> <Cmd>nohlsearch<Bar>echo<CR>

noremap <buffer> <silent> d <C-d>:call x2a#movements#window#CenterCursorAesthetically()<CR>
noremap <buffer> <silent> u <C-u>:call x2a#movements#window#CenterCursorAesthetically()<CR>

map <buffer> <silent> <Space>   <C-d>:call x2a#movements#window#CenterCursorAesthetically()<CR>
map <buffer> <silent> <S-Space> <C-u>:call x2a#movements#window#CenterCursorAesthetically()<CR>
