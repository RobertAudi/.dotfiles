" Plugin: vim-floaterm
" Description: Open the terminal in the floating window and toggle it quickly
" URL: https://github.com/voldikss/vim-floaterm

let g:floaterm_width = 150
let g:floaterm_height = 15
let g:floaterm_winblend = 5

noremap  <silent> <Leader>` :FloatermToggle<CR>i
noremap! <silent> <Leader>` <Esc>:FloatermToggle<CR>i
tnoremap <silent> <Leader>` <C-\><C-n>:FloatermToggle<CR>
