if has('gui_vimr')
  finish
endif

function! x2a#private#terminal#paste(ret) abort
  set paste

  return a:ret
endfunction

function! x2a#private#terminal#check_focus() abort
  if exists('$TMUX') && exists('$TMUX_PANE')
    let l:pane_id = $TMUX_PANE
    let l:panes = split(system('tmux list-panes -F "#{pane_active} #{pane_id}"'), '\n')
    let l:active = filter(l:panes, 'match(v:val, "^1 ") == 0')

    if len(l:active) == 1
      let l:match = matchstr(l:active[0], '\v1 \zs\%\d+$')

      if l:match !=# ''
        let l:autocmd = l:match == l:pane_id ? 'FocusGained' : 'FocusLost'

        execute 'silent! doautocmd <nomodeline> ' . l:autocmd . ' %'
      endif
    endif
  endif
endfunction

function! x2a#private#terminal#handle_timer(timer) abort
  if exists('g:x2a#private#terminal#PendingFocusTimer')
    unlet g:x2a#private#terminal#PendingFocusTimer
  endif

  call x2a#private#terminal#check_focus()
endfunction

function! x2a#private#terminal#schedule_check() abort
  if exists('g:x2a#private#terminal#PendingFocusTimer')
    call timer_stop(g:x2a#private#terminal#PendingFocusTimer)
  endif

  let g:x2a#private#terminal#PendingFocusTimer = timer_start(50, 'x2a#private#terminal#handle_timer')
endfunction
