" Autocommands {{{
" ------------------------------------------------------------------------------

" More eager than 'autoread'.
Autocmd WinEnter * checktime

" Update diff.
Autocmd InsertLeave * if &l:diff | diffupdate | endif

" Don't track changes, keep .viminfo information or swap files for files in
" temporary directories. This is because they're used as scratch spaces for
" tools like sudoedit(8) and pass(1) and hence could present a security problem
Autocmd BufNewFile,BufReadPre   /tmp/*,$TMPDIR/*,$TMP/*,$TEMP/* setlocal viminfo=
Autocmd BufWritePre             /tmp/*,$TMPDIR/*,$TMP/*,$TEMP/* setlocal noundofile

if !strlen($SUDO_USER)
  Autocmd BufNewFile,BufReadPre /tmp/*,$TMPDIR/*,$TMP/*,$TEMP/* setlocal noswapfile
endif

" Open new tabs at the end
Autocmd BufNew *
      \ if &showtabline && winnr('$') == 1
      \ | tabmove |
      \ endif

" Back to normal mode when Vim loses focus
Autocmd FocusLost,TabLeave *
      \ if mode() !=# "c"
      \ | call feedkeys("\<C-\>\<C-n>", 'n') |
      \ endif

" Only show cursorline in the current
" window and in normal mode.
Autocmd WinLeave * setlocal nocursorline
Autocmd WinEnter *
      \ if !exists('b:NERDTree')
      \ | setlocal cursorline |
      \ endif

" Regenerate ctags on save
Autocmd BufWritePost *
      \ if exists('b:git_dir') && executable(b:git_dir . '/hooks/ctags')
      \ | call system('"' . b:git_dir . '/hooks/ctags" &') |
      \ endif

" Set timeoutlen to 0 for help and man buffers only
" The conditionnal is required because timeoutlen is
" a global option (can't be set locally)
Autocmd BufEnter *
      \ if index(['help', 'man'], &filetype) >= 0
      \ | set timeoutlen=0 |
      \ else
      \ | set timeoutlen=1000 |
      \ endif


" ------------------------------------------------------------------------------ }}}
