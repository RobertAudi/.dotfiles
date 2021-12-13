" Plugin: vim-floaterm
" Description: Open built-in terminal in the floating window
" URL: https://github.com/voldikss/vim-floaterm

let g:floaterm_position = 'center'
let g:floaterm_type = 'floating'

" Close window if the job exits normally,
" otherwise stay it with messages like [Process exited 101]
let g:floaterm_autoclose = 1

noremap  <silent> <M-t> <Cmd>FloatermToggle<CR>
noremap! <silent> <M-t> <Esc>:FloatermToggle<CR>
tnoremap <silent> <M-t> <Cmd>FloatermToggle<CR>

augroup RAPluginsFloaterm
  autocmd!

  " Hide the floating terminal when moving to another buffer/window
  " e.g.: by using the mouse to switch to another file, window, tab, etc.
  autocmd BufLeave *
        \ if &filetype ==# 'floaterm'
        \ |  call x2a#floaterm#hide() |
        \ endif
augroup END
