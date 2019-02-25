function! x2a#help#maps#enable() abort
  " jump to the subject (topic) under the cursor.
  nnoremap <buffer> <silent> <CR> :nohlsearch<Bar>echo<CR><C-]>:call x2a#movements#window#CenterCursorAesthetically()<CR>

  " return from the last jump.
  nnoremap <buffer> <silent> <BS> :nohlsearch<Bar>echo<CR><C-T>:call x2a#movements#window#CenterCursorAesthetically()<CR>

  nnoremap <buffer> <silent> <Space>   :nohlsearch<Bar>echo<CR>
  nnoremap <buffer> <silent> <S-Space> :nohlsearch<Bar>echo<CR>

  noremap <buffer> <silent> d <C-d>:call x2a#movements#window#CenterCursorAesthetically()<CR>
  noremap <buffer> <silent> u <C-u>:call x2a#movements#window#CenterCursorAesthetically()<CR>

  map <buffer> <silent> <Space>   <C-d>:call x2a#movements#window#CenterCursorAesthetically()<CR>
  map <buffer> <silent> <S-Space> <C-u>:call x2a#movements#window#CenterCursorAesthetically()<CR>

  nnoremap <buffer> q :quit<CR>
  nnoremap <buffer> Q :quit<CR>

  " Go to the table of contents.
  nnoremap <buffer> <silent> c :call x2a#help#GoToTableOfContent()<CR>
endfunction

function! x2a#help#maps#disable() abort
  silent! nunmap <buffer> <CR>
  silent! nunmap <buffer> <BS>
  silent! unmap  <buffer> d
  silent! unmap  <buffer> u
  silent! nunmap <buffer> q
  silent! nunmap <buffer> Q
  silent! nunmap <buffer> c
  silent! unmap  <buffer> <Space>
  silent! unmap  <buffer> <S-Space>
endfunction
