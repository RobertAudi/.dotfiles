function! x2a#TextMate#mate(...) abort
  call system("mate " . join(a:000, ' '))
endfunction

function! x2a#TextMate#OpenCurrentFile() abort
  let l:position = getcurpos()
  let l:line = l:position[1]
  let l:column = max([1, l:position[2] - l:position[3] - 1])
  let l:linearg = "--line " . l:line . ":" . l:column
  let l:file = expand('%:p:S')

  call x2a#TextMate#mate(l:linearg, l:file)
endfunction

function! x2a#TextMate#Open(...) abort
  let l:file = get(a:000, 0, '%')

  if l:file ==# '.'
    call x2a#TextMate#mate(fnamemodify(getcwd(), ':p:S'))
  elseif l:file ==# '%'
    call x2a#TextMate#OpenCurrentFile()
  elseif l:file ==# '#'
    call x2a#TextMate#mate(expand('#:p:S'))
  else
    let l:file = fnamemodify(l:file, ':p')

    if isdirectory(l:file) || filereadable(l:file)
      call x2a#TextMate#mate(shellescape(l:file))
    else
      call x2a#utils#helpers#Warn('File is not readable or does not exist: ' . l:file)
    endif
  endif
endfunction
