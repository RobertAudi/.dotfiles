function! x2a#picker#Buffer#list() abort
  let l:buffers = filter(getbufinfo(), 'v:val.listed && v:val.bufnr != bufnr("%")')
  let l:bufnames = map(l:buffers, 'bufname(v:val.bufnr)')

  return 'echo "' . join(l:bufnames, "\n") . '"'
endfunction

function! x2a#picker#Buffer#Edit() abort
  call picker#Buffer()
endfunction

function! x2a#picker#Buffer#Vsplit() abort
  call picker#File(x2a#picker#Buffer#list(), 'vertical sbuffer')
endfunction

function! x2a#picker#Buffer#Split() abort
  call picker#File(x2a#picker#Buffer#list(), 'sbuffer')
endfunction

function! x2a#picker#Buffer#Tabedit() abort
  call picker#File(x2a#picker#Buffer#list(), 'tab sbuffer')
endfunction
