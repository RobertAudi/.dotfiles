if !x2a#utils#os#is_mac()
  finish
endif

function! x2a#macos#markdown#PreviewInMarked(filepath) abort
  let l:filepath = shellescape(a:filepath)

  if executable('marked')
    let l:cmd = 'marked ' . l:filepath
  else
    let l:cmd = 'open -a "Marked 2.app" ' . l:filepath
  endif

  silent! call system(l:cmd)
endfunction
