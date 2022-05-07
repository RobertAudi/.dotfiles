" Terminal {{{
" ------------------------------------------------------------------------------

" Make use of Xterm "bracketed paste mode". See:
"  - http://www.xfree86.org/current/ctlseqs.html#Bracketed%20Paste%20Mode
"  - http://stackoverflow.com/questions/5585129
if &term =~# 'screen\|tmux\|xterm'
  " Enable bracketed paste mode on entering Vim.
  let &t_ti .= "\e[?2004h"

  " Disable bracketed paste mode on leaving Vim.
  let &t_te = "\e[?2004l" . &t_te

  set pastetoggle=<f23>

  execute "set <f22>=\<Esc>[200~"
  execute "set <f23>=\<Esc>[201~"

  inoremap <expr> <f22> x2a#private#terminal#paste('')
  nnoremap <expr> <f22> x2a#private#terminal#paste('i')
  vnoremap <expr> <f22> x2a#private#terminal#paste('c')
  cnoremap        <f22> <Nop>
  cnoremap        <f23> <Nop>
endif

augroup RAPluginsTerminal
  autocmd!

  " We may not get FocusGained/FocusLost events, or we may get them late,
  " when they are due to pane creation/destruction.
  autocmd VimResized * call x2a#private#terminal#schedule_check()
augroup END

" ------------------------------------------------------------------------------ }}}
