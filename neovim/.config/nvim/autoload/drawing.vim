scriptencoding utf-8

" Stolen from https://github.com/sdothum/dotfiles
" https://github.com/sdothum/dotfiles/blob/3ce105e7c3e43da57b2ab215702ddb08135f85f7/vim/.vim/config/drawing.vim
" ▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂

" let drawing#delimiters = {
"       \   'underscore': '▁',
"       \   'fat_underscore': '▂',
"       \   'superdash': '▔',
"       \   'dot': '.'
"       \ }

let drawing#delimiters = {
      \   'underscore': '_',
      \   'fat_underscore': '=',
      \   'superdash': '-',
      \   'dot': '.'
      \ }

let s:linewidth = 80

" ▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔

function! drawing#Underline(delimiter) abort
  if matchstr(getline(line('.')), '\S') ># ''
    normal! ^
    let l:col = virtcol('.')
    execute 'normal yypVr' . a:delimiter
    if l:col > 1                      " blank to margin
      execute 'normal ' . l:col . 'r '
    endif
    " prefix lua/haskell comment to avoid potential delimiter conflict
    if &filetype ==# 'lua' || &filetype ==# 'haskell'
      normal! ^iMark
    endif
    " comment line
    execute "normal :Commentary\<CR>"
    if &filetype ==# 'lua' || &filetype ==# 'haskell'
      normal! /Mark
      " remove prefix+1 to treat as common 2 byte comment leader
      normal! 4x$x
    endif
    " place delimiter immediately after comment header (no space)
    " if &filetype != 'lua' && &filetype != 'haskell' && a:delimiter != '='
    "   execute 'normal ^f r' . a:delimiter
    " endif
    " adjust delimiter length by comment leader
    if l:col == 1
      normal! $xx
    else
      normal! 0x$x
    endif
    normal! ^
  endif
endfunction

function! drawing#Line(delimiter) abort
  if matchstr(getline(line('.')), '\S') ==# '' " insert dummy mark line if on blank line
    let l:mark = 1
    normal! $RMark
  else
    let l:mark = 0
  endif
  call drawing#Underline(a:delimiter)
  if l:mark > 0                       " remove temporary mark
    normal! kdd
  endif
  normal! $
  if virtcol('.') < s:linewidth       " for mirrored left/right margin spacing
    " let l:col = s:linewidth - virtcol('.') - l:col + 1
    let l:col   = s:linewidth - virtcol('.')
    execute 'normal ' . l:col . 'a' . a:delimiter
  endif
  normal! ^
endfunction

function! drawing#AppendTrailer(delimiter) abort
  if matchstr(getline(line('.')), '\S') ># ''
    " remove existing trailer
    if matchstr(getline(line('.')), '\s[' . a:delimiter . ']\+$') ># ''
      " normal $bhD
      normal! $bmD
      silent! delmarks D
    endif
    normal! $
    let l:col = s:linewidth - virtcol('.') - 1
    if l:col > 0
      set formatoptions-=c            " suppress potential comment line wrapping
      execute 'normal a '
      execute 'normal ' . l:col . 'a' . a:delimiter
      set formatoptions+=c
    endif
    normal! ^
  endif
endfunction

" prompted trailer
function! drawing#InputTrailer() abort
  let l:delimiter = input('Line character: ')
  if l:delimiter ># ''
    call drawing#AppendTrailer(l:delimiter[0])
  endif
endfunction

function! drawing#RightJustify() abort
  if matchstr(getline(line('.')), '\S') ># ''
    if matchstr(getline(line('.')), '^ *') ># '' " remove existing leader
      " execute 'normal 0vwhd'
      execute 'normal 0vwmd'
    endif
    normal! $
    let l:col = s:linewidth - virtcol('.') - 1
    if l:col > 0
      set formatoptions-=c            " suppress potential comment line wrapping
      normal! ^
      execute 'normal ' . l:col . 'i '
      execute 'normal a '
      set formatoptions+=c
    endif
  endif
endfunction

function! drawing#InsertLeader(delimiter) abort
  if matchstr(getline(line('.')), '\S') ># ''
    " remove existing leader
    if matchstr(getline(line('.')), '\S\s\+[' . a:delimiter . ']\+\s') ># ''
      " execute 'normal ^wdf '
      execute 'normal ^wdt x'
    endif
    call drawing#AppendTrailer(a:delimiter)
    " cut trailer and insert as leader!
    " normal $bhD^whP
    normal! $bmD^wmP
    silent! delmarks DP
    normal! ^
  endif
endfunction

" prompted leader
function! drawing#InputLeader() abort
  let l:delimiter = input('Line character: ')
  if l:delimiter ># ''
    if l:delimiter ==# ' '
      call drawing#RightJustify()
    else
      call drawing#InsertLeader(l:delimiter[0])
    endif
  endif
endfunction

" Stolen from: https://github.com/godlygeek/vim-files
"   https://github.com/godlygeek/vim-files/blob/26aafb044895f778710bbc507310f5598019fa96/.vimrc#L389-L416
function! drawing#BoxIn() abort
  let l:mode = visualmode()
  if l:mode ==# ''
    return
  endif

  let l:old_virtualedit = &virtualedit
  let &virtualedit = 'all'

  execute "normal! ix\<BS>\<Esc>"

  if line("'<") > line("'>")
    undojoin | execute "normal! gvo\<Esc>"
  endif

  if l:mode !=? "\<C-v>"
    let l:len = max(map(range(line("'<"), line("'>")), "virtcol([v:val, '$'])"))
    undojoin | execute "normal! gv\<C-v>o0o0" . (l:len - 2 ? string(l:len - 2) : '') . "l\<Esc>"
  endif

  let l:diff = virtcol("'>") - virtcol("'<")
  if l:diff < 0
    let l:diff = -l:diff
  endif

  let l:horizm = '+' . repeat('-', l:diff + 1) . '+'
  if l:mode ==? "\<C-v>"
    undojoin | execute 'normal! `<O' . l:horizm . "\<Esc>"
  else
    undojoin | execute line("'<") . "put! ='" . l:horizm . "'" | normal! `<k
  endif

  undojoin | execute "normal! yygvA|\<Esc>gvI|\<Esc>`>p"

  let &virtualedit = l:old_virtualedit
endfunction

" Stolen from https://github.com/pgdouyon/dotfiles
" https://github.com/pgdouyon/dotfiles/blob/936e0cc627a36fb1091ef884e3a62ed4e6fd4e2a/config/nvim/init.vim#L358-L374
function! drawing#SectionBox(border) abort
  " remove indentation
  call setline('.', substitute(getline('.'), '\v^\s*', '', ''))
  execute "normal! O\<Esc>70a" . a:border
  execute "normal! jo\<Esc>70a" . a:border

  " use vim-commentary mapping
  normal! 2k
  normal! 3gcc
  normal! 3jO

  startinsert!
endfunction
