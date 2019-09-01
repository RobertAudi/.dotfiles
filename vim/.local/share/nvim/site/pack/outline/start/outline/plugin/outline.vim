" Outline the contents of the buffer
command! -nargs=* Outline call s:Outline(<f-args>)

function! s:Outline(...) abort
  if a:0 > 0
    let l:pattern = join(a:000, '\|')
  elseif exists('b:outline_pattern')
    let l:pattern = b:outline_pattern
  elseif !exists('b:outlined')
    echoerr 'No b:outline_pattern for this buffer'
  endif

  if exists('b:outlined') " Un-outline it
    FoldEndFolding

    unlet b:outlined
  else
    execute 'FoldMatching ' . l:pattern . ' -1'

    let b:outlined = 1

    setlocal foldenable
  endif
endfunction

