function! s:AestheticCenter() abort
  let l:center = round(winheight(0) / 2.0)
  let l:offset = winheight(0) * 0.1
  let l:final = l:center - l:offset
  let l:rounded_final = float2nr(l:final) + 1
  let l:rounded_offset = float2nr(l:offset)
  let l:delta = float2nr(l:center) - l:rounded_final

  return { 'line': l:rounded_final, 'offset': l:rounded_offset, 'delta': l:delta }
endfunction

" Description: Use aesthetic middle of screen for 'zz'
" URL:    https://github.com/raymond-w-ko/dot
" Source: https://github.com/raymond-w-ko/dot/blob/f8afd2346e58b4f2982170f865c9b1db0ba57d94/.vimrc#L490-L504
function! x2a#movements#window#CenterCursorAesthetically() abort
  let l:center = s:AestheticCenter()

  normal! zz

  if l:center.delta > 0
    execute 'normal! ' . l:center.delta . "\<C-e>"
  endif
endfunction

" Description: Scroll to top/center/bottom
" Credits: Modified version of mapping from @Shougo
" Source:  https://github.com/Shougo/shougo-s-github/blob/67a4baec2626d081f34c80eedef2fb1c687dfba3/vim/rc/mappings.rc.vim#L271-L273
function! x2a#movements#window#CycleCursorPosition() abort
  let l:center = s:AestheticCenter()

  if winline() == l:center.line
    normal! zt
  elseif winline() == (&scrolloff + 1)
    normal! zb
  else
    call x2a#movements#window#CenterCursorAesthetically()
  endif
endfunction
