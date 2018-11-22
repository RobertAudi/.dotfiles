" Commands {{{
" ------------------------------------------------------------------------------
" Save and make executable
command! -bang -nargs=? WX silent write<bang> <args> | Chmod +x

" Change the filetype of the current buffer
command! -complete=filetype -nargs=? FT call x2a#utils#setFileType(<f-args>)

if has("gui_mac") || has("gui_macvim") || has("mac")
  command! -nargs=0 RevealInFinder call x2a#macos#RevealInFinder(expand('%:p'))
  command! -nargs=? -complete=file TextMate silent! call x2a#TextMate#Open(<f-args>)
endif

call x2a#abolish#commands('e', 'E')
call x2a#abolish#commands('w', 'W')
call x2a#abolish#commands('q', 'Q')
call x2a#abolish#commands('wa', 'Wa', 'WA')
call x2a#abolish#commands('wq', 'Wq', 'WQ')
call x2a#abolish#commands('wqa', 'Wqa', 'WQa', 'WQA')
call x2a#abolish#commands('qa', 'Qa', 'QA')
call x2a#abolish#commands('tabc', 'Tabc')
call x2a#abolish#commands('tabnew', 'Tabnew', 'Tnew', 'TNew', 'tnew')

" Buffers
" ------------------------------------------------------------------------------
command! -nargs=0 ReindentBuffer silent! call x2a#utils#helpers#Preserve('x2a#buffers#Reindent')
command! -nargs=0 YankBuffer silent! call x2a#utils#helpers#Preserve('x2a#buffers#Yank')

" Copy (to the system clipboard) the path to current file
command! -nargs=0 CopyFilePath call x2a#buffers#CopyFullPath()
command! -nargs=0 CopyFullFilePath call x2a#buffers#CopyFullPath()
command! -nargs=0 CopyRelativeFilePath call x2a#buffers#CopyRelativePath()
command! -nargs=0 CopyRelativeFilePathWithLineNumber call x2a#buffers#CopyRelativePathWithLineNumber()

" Golden Ratio
command! -nargs=0 GoldenRatio execute 'vertical resize' &columns * 5 / 8

command! -bang -nargs=0 BufOnly silent! call x2a#buffers#BufOnly(<bang>0)
command! -bang -nargs=0 BufDeleteInactive silent! call x2a#buffers#BufDeleteInactive(<bang>0)
command! -bang -nargs=0 BufDeleteAll silent! call x2a#buffers#BufDeleteAll(<bang>0)

" Command ':Bclose' executes ':bd' to delete buffer in current window.
" The window will show the alternate buffer (Ctrl-^) if it exists,
" or the previous buffer (:bp), or a blank buffer if no previous.
" Command ':Bclose!' is the same, but executes ':bd!' (discard changes).
" An optional argument can specify which buffer to close (name or number).
command! -bang -complete=buffer -nargs=? Bclose call x2a#buffers#Bclose('<bang>', '<args>')

call x2a#abolish#commands('BufOnly',
      \ 'BOnly', 'BOnl', 'BOn', 'BO',
      \ 'Bonly', 'Bonl', 'Bon', 'Bo',
      \ 'bonly', 'bonl', 'bon', 'bo')
call x2a#abolish#commands('Bdelete',
      \ 'BDelete', 'BDel', 'BD')
call x2a#abolish#commands('BufDeleteInactive',
      \ 'BDin', 'BDi',
      \ 'Bdin', 'Bdi',
      \ 'bdin', 'bdi')
call x2a#abolish#commands('BufDeleteAll',
      \ 'BDall', 'BDal', 'BDa',
      \ 'Bdall', 'Bdal', 'Bda',
      \ 'bdall', 'bdal', 'bda')

" Diff
" ------------------------------------------------------------------------------
command! -n=? -bar DiffThese :call x2a#utils#DiffThese(<args>)
command! -n=0 -bar DiffLeft :call x2a#utils#DiffThese(1, 2)
command! -n=0 -bar DiffRight :call x2a#utils#DiffThese(2, 3)
command! -n=0 -bar DiffChanges :call x2a#utils#DiffThese(1, 3)
command! -n=0 -bar DiffAll :call x2a#utils#DiffThese(1, 2, 3, 4)
command! -n=1 -bar DiffWith :call x2a#utils#DiffThese(winnr(), <args>)
command! -n=0 -bar DiffOff diffoff!

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
command! DiffOrig vert new | set buftype=nofile | r # | 0d_ | diffthis | wincmd p | diffthis

" Drawing
" ------------------------------------------------------------------------------
command! -range=% BoxIn call x2a#drawing#BoxIn()

" Help
" ------------------------------------------------------------------------------
command! -bang -nargs=? -complete=help Help call x2a#hhhhelp#alternate('<bang>', <f-args>)

call x2a#abolish#commands('Help', 'H')

" Misc
" ------------------------------------------------------------------------------
command! -nargs=0 ReloadFiletype call x2a#utils#ReloadFiletype()
command! -nargs=+ -complete=command Page call x2a#utils#page(<q-args>)
command! -nargs=0 -range Append <line1>,<line2>call x2a#utils#Append()
command! -nargs=0 NormalizeWhitespace call x2a#utils#helpers#Preserve('x2a#utils#UnfuckWhitespace')
command! -nargs=0 WhatSyntax call x2a#utils#WhatSyntax()

" Unfuck my screen
" Source: https://bitbucket.org/sjl/dotfiles/src/26d3b19a08938930b576cedb18bc6fca706be6c5/vim/vimrc#vimrc-443
command! -nargs=0 UnfuckScreen syntax sync fromstart | :redraw!

if executable('lr')
  " :Lr <lr-args> to browse lr(1) results in a new window,
  "               press return to open file in new window.
  command! -nargs=* -complete=file Lr new
        \ | setlocal buftype=nofile noswapfile
        \ | silent execute "0r!lr -Q " <q-args>
        \ | 0 | resize | map <buffer> <C-M> $<C-W>F<C-W>_
endif

" ------------------------------------------------------------------------------ }}}
