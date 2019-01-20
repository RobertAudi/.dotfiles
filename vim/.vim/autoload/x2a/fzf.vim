function! x2a#fzf#has_fast_command() abort
  return executable('fd') || executable('rg') || executable('ag')
endfunction

function! x2a#fzf#files_command() abort
  if executable('fd')
    return x2a#fzf#files_command#fd()
  elseif executable('rg')
    return x2a#fzf#files_command#rg()
  elseif executable('ag')
    return x2a#fzf#files_command#ag()
  else
    throw 'No fast files command found'
  endif
endfunction
