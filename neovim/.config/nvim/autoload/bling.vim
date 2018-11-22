function! bling#blink(times, delay) abort
  let s:blink = { 'ticks': 2 * a:times, 'delay': a:delay }

  function! s:blink.tick(_) abort
    let self.ticks -= 1
    let active = self == s:blink && self.ticks > 0

    if !self.clear() && active && &hlsearch
      let pattern = '\%#' . getreg('/')
      if &ignorecase == 1 || &smartcase == 1
        let pattern = pattern . '\c'
      endif

      let w:blink_id = matchadd('BlingHighlight', pattern)
    endif
    if active
      call timer_start(self.delay, self.tick)
    endif
  endfunction

  function! s:blink.clear() abort
    if exists('w:blink_id')
      call matchdelete(w:blink_id)
      unlet w:blink_id
      return 1
    endif
  endfunction

  call s:blink.clear()
  call s:blink.tick(0)
  return ''
endfunction
