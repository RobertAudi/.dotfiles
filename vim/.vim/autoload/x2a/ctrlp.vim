function! x2a#ctrlp#has_fast_user_command() abort
  return executable('fd') || executable('rg') || executable('ag')
endfunction

function! x2a#ctrlp#user_command() abort
  if executable('fd')
    return x2a#ctrlp#user_command#fd()
  elseif executable('rg')
    return x2a#ctrlp#user_command#rg()
  elseif executable('ag')
    return x2a#ctrlp#user_command#ag()
  else
    return ['.git/', 'cd %s && git ls-files']
  endif
endfunction
