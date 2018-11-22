" Commands {{{
" ------------------------------------------------------------------------------
" Save and make executable
command! -bang -nargs=? WX silent write<bang> <args> | Chmod +x

" Change the filetype of the current buffer
command! -complete=filetype -nargs=1 FT silent setlocal filetype=<args>

if has("gui_mac") || has("mac") || has('gui_vimr')
  command! -nargs=0 RevealInFinder call macos#RevealInFinder(expand('%:p'))
endif

call abolish#commands('e', 'E')
call abolish#commands('w', 'W')
call abolish#commands('q', 'Q')
call abolish#commands('wa', 'Wa', 'WA')
call abolish#commands('wq', 'Wq', 'WQ')
call abolish#commands('wqa', 'Wqa', 'WQa', 'WQA')
call abolish#commands('qa', 'Qa', 'QA')
call abolish#commands('tabc', 'Tabc')
call abolish#commands('tabnew', 'Tabnew', 'Tnew', 'TNew', 'tnew')

" Buffers
" ------------------------------------------------------------------------------
command! -bang -nargs=0 BufOnly silent! call buffers#BufOnly(<bang>0)
command! -bang -nargs=0 BufDeleteInactive silent! call buffers#BufDeleteInactive(<bang>0)
command! -bang -nargs=0 BufDeleteAll silent! call buffers#BufDeleteAll(<bang>0)

call abolish#commands('BufOnly',
      \ 'BOnly', 'BOnl', 'BOn', 'BO',
      \ 'Bonly', 'Bonl', 'Bon', 'Bo',
      \ 'bonly', 'bonl', 'bon', 'bo')
call abolish#commands('Bdelete',
      \ 'BDelete', 'BDel', 'BD')
call abolish#commands('BufDeleteInactive',
      \ 'BDin', 'BDi',
      \ 'Bdin', 'Bdi',
      \ 'bdin', 'bdi')
call abolish#commands('BufDeleteAll',
      \ 'BDall', 'BDal', 'BDa',
      \ 'Bdall', 'Bdal', 'Bda',
      \ 'bdall', 'bdal', 'bda')

" Diff
" ------------------------------------------------------------------------------
command! -n=? -bar DiffThese :call utils#DiffThese(<args>)
command! -n=0 -bar DiffLeft :call utils#DiffThese(1, 2)
command! -n=0 -bar DiffRight :call utils#DiffThese(2, 3)
command! -n=0 -bar DiffChanges :call utils#DiffThese(1, 3)
command! -n=0 -bar DiffAll :call utils#DiffThese(1, 2, 3, 4)
command! -n=1 -bar DiffWith :call utils#DiffThese(winnr(), <args>)
command! -n=0 -bar DiffOff diffoff!

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
command! DiffOrig vert new | set buftype=nofile | r # | 0d_ | diffthis | wincmd p | diffthis

" Drawing
" ------------------------------------------------------------------------------
command! -range=% BoxIn call drawing#BoxIn()

" Help
" ------------------------------------------------------------------------------
command! -bang -nargs=? -complete=help Help call hhhhelp#alternate('<bang>', <f-args>)

call abolish#commands('Help', 'H')

" Misc
" ------------------------------------------------------------------------------
if executable('lr')
  " :Lr <lr-args> to browse lr(1) results in a new window,
  "               press return to open file in new window.
  command! -nargs=* -complete=file Lr new
        \ | setlocal buftype=nofile noswapfile
        \ | silent execute "0r!lr -Q " <q-args>
        \ | 0 | resize | map <buffer> <C-M> $<C-W>F<C-W>_
endif

" ------------------------------------------------------------------------------ }}}
