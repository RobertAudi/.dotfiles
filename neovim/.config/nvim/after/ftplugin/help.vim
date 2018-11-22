setlocal iskeyword+=:
setlocal iskeyword+=#
setlocal iskeyword+=-

setlocal nocursorline
setlocal readonly
setlocal nomodifiable
setlocal nolist
setlocal wrap
setlocal keywordprg=:help

" jump to the subject (topic) under the cursor.
nnoremap <buffer> <silent> <CR>      :nohlsearch<Bar>:echo<CR><C-]>

" return from the last jump.
nnoremap <buffer> <silent> <BS>      :nohlsearch<Bar>:echo<CR><C-T>

nnoremap <buffer> <silent> <Space>   :nohlsearch<Bar>:echo<CR>
nnoremap <buffer> <silent> <S-Space> :nohlsearch<Bar>:echo<CR>

noremap <buffer> <silent> d <C-d>
noremap <buffer> <silent> u <C-u>

map <buffer> <silent> <Space>   <C-d>
map <buffer> <silent> <S-Space> <C-u>

nnoremap <buffer> q :quit<CR>
nnoremap <buffer> Q :quit<CR>

" o to find the next option, or O to find the previous option.
nnoremap <buffer> o /'\l\{2,\}'<CR>:nohlsearch<CR>
nnoremap <buffer> O ?'\l\{2,\}'<CR>:nohlsearch<CR>

" s to find the next subject, or S to find the previous subject.
nnoremap <buffer> s /\|\zs\S\+\ze\|<CR>:nohlsearch<CR>
nnoremap <buffer> S ?\|\zs\S\+\ze\|<CR>:nohlsearch<CR>

" Go to the table of contents.
nnoremap <buffer> <silent> c :call hhhhelp#GoToTableOfContent()<CR>
