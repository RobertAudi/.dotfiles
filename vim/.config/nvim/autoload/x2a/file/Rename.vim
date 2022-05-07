" Description: Completion function for the :Rename command
" Credits:     Tim Pope <http://tpo.pe/>
" URL:         https://github.com/tpope/vim-eunuch
function! x2a#file#Rename#complete(ArgLead, CmdLine, CursorPos) abort
  let l:prefix = expand('%:p:h') . '/'
  let l:files = split(glob(l:prefix . a:ArgLead . '*'), "\n")

  call map(l:files, 'v:val[strlen(l:prefix) : -1] . (isdirectory(v:val) ? "/" : "")')

  return join(l:files + ['../'], "\n")
endfunction
