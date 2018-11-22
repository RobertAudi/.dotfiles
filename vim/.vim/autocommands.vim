augroup RAVimAutocommands
  autocmd!

  " Disable all the fucking beeps, bells and flashes, ALL THE FUCKING TIME!
  autocmd VimEnter,GUIEnter * set visualbell t_vb=

  " Set "TODO" & "FIXME" strings to be bold and standout as hell.
  autocmd VimEnter,ColorScheme *
        \ highlight Todo
        \ term=standout
        \ ctermfg=196 ctermbg=226
        \ guifg=#ff4500 guibg=#eeee00

  " Update the 'scrolloff' according to the height of the window
  " Source: https://github.com/uplus/vimrc/blob/80b6dc96d08bf00ed59e545448ea031aee194230/autocmds.vim#L8
  autocmd VimEnter,WinEnter,VimResized * let &scrolloff = float2nr(winheight('') * 0.1)

  " Only show cursorline in the current
  " window and in normal mode.
  autocmd WinLeave * setlocal nocursorline
  autocmd WinEnter *
        \ if !exists('b:NERDTree')
        \ | setlocal cursorline |
        \ endif

  " More eager than 'autoread'.
  autocmd WinEnter * checktime

  " Update diff.
  autocmd InsertLeave * if &l:diff | diffupdate | endif

  " Don't track changes, keep .viminfo information or swap files for files in
  " temporary directories. This is because they're used as scratch spaces for
  " tools like sudoedit(8) and pass(1) and hence could present a security problem
  autocmd BufNewFile,BufReadPre   /tmp/*,$TMPDIR/*,$TMP/*,$TEMP/* setlocal viminfo=
  autocmd BufWritePre             /tmp/*,$TMPDIR/*,$TMP/*,$TEMP/* setlocal noundofile

  if empty($SUDO_USER) || $USER ==# $SUDO_USER
    autocmd BufNewFile,BufReadPre /tmp/*,$TMPDIR/*,$TMP/*,$TEMP/* setlocal noswapfile
  endif

  " Open new tabs at the end
  autocmd BufNew *
        \ if &showtabline && winnr('$') == 1
        \ | tabmove |
        \ endif

  " Set timeoutlen to 0 for help and man buffers only
  " The conditionnal is required because timeoutlen is
  " a global option (can't be set locally)
  autocmd BufEnter *
        \ if index(['help', 'man'], &filetype) >= 0
        \ | set timeoutlen=0 |
        \ else
        \ | let &timeoutlen = get(g:, 'default_timeoutlen', 1000) |
        \ endif

  " Back to normal mode when Vim loses focus
  autocmd FocusLost,TabLeave *
        \ if mode() !=# "c"
        \ | call feedkeys("\<C-\>\<C-n>", 'n') |
        \ endif
augroup END
