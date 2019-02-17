" Universal opposite of J
" Split line at cursor, carefully avoiding moving the cursor or
" disturbing search, marks, jumps, etc.
function! x2a#breakhere#BreakHere() abort
  " remember how we left things
  let l:view = winsaveview()

  " input the linebreak itself
  execute "keepjumps normal! i\<CR>\<Esc>"

  " hop back up a (visual) line and trim trailing whitespace
  execute 'keepjumps normal! gk'
  silent! substitute/\v +$//
  call histdel('/', -1)

  " leave view and search how we found them
  call winrestview(l:view)
endfunction
