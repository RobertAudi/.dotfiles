if !has('gui_vimr')
  finish
endif

" Do not exit visual mode when shifting
vnoremap <silent> <D-]> >gv
vnoremap <silent> <D-[> <gv

nnoremap <silent> <D-]> >>
nnoremap <silent> <D-[> <<

" Map Command-Shift-] and Command-Shift-[
" to switch to the next/previous tab.
nnoremap <S-D-{> <Cmd>tabprevious<CR>
xnoremap <S-D-{> <Cmd>tabprevious<CR>
inoremap <S-D-{> <Cmd>tabprevious<CR>
nnoremap <S-D-}> <Cmd>tabnext<CR>
xnoremap <S-D-}> <Cmd>tabnext<CR>
inoremap <S-D-}> <Cmd>tabnext<CR>

" Switch to tab 1 to 9 by number
for s:tabnr in range(1, 9)
  execute 'nnoremap <D-' . s:tabnr . '> <Cmd>' . s:tabnr . 'tabnext<CR>'
  execute 'xnoremap <D-' . s:tabnr . '> <Cmd>' . s:tabnr . 'tabnext<CR>'
  execute 'inoremap <D-' . s:tabnr . '> <Cmd>' . s:tabnr . 'tabnext<CR>'
endfor
