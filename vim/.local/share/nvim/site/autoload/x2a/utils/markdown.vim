" ---
" Stolen from https://github.com/gabrielelana/vim-markdown
"   https://github.com/gabrielelana/vim-markdown/blob/08e0731ce2c0b541ea335c782c59bb2e870730d4/ftplugin/markdown.vim#L97-L115
" ---
function! x2a#utils#markdown#JumpToHeader(forward, visual) abort
  let l:cnt = v:count1
  let l:save = @/
  let l:pattern = '\v^#{1,6}.*$|^.+\n%(\-+|\=+)$'
  if a:visual
    normal! gv
  endif
  if a:forward
    let l:motion = '/' . l:pattern
  else
    let l:motion = '?' . l:pattern
  endif
  while l:cnt > 0
    silent! execute l:motion
    let l:cnt = l:cnt - 1
  endwhile
  call histdel('/', -1)
  let @/ = l:save
endfunction

