" Description: Get the path to current file (relative to PWD)
"              with the line number ('my_folder/myfile:12')
function! x2a#file#GetRelativePathWithLineNumber() abort
  return expand('%') . ':' . line('.')
endfunction

" Description: Copy (to the system clipboard) the path to current file (relative to PWD)
"              with the line number ('my_folder/myfile:12')
function! x2a#file#CopyRelativePathWithLineNumber() abort
  let l:path = x2a#file#GetRelativePathWithLineNumber()
  call setreg('+', l:path)
  echo 'Copied file path to system clipboard: ' . l:path
endfunction

" Description: Rename the current file
" Credits:     Tim Pope <http://tpo.pe/>
" URL:         https://github.com/tpope/vim-eunuch
function! x2a#file#Rename(name, bang) abort
  let l:src = expand('%:p')
  let l:dst = fnamemodify(expand('%:h') . '/' . a:name, ':p')

  if isdirectory(l:dst) || l:dst[-1:-1] =~# '[\\/]'
    let l:dst .= (l:dst[-1:-1] =~# '[\\/]' ? '' : '\/') . fnamemodify(l:src, ':t')
  endif

  let l:parentdir = fnamemodify(l:dst, ':h')
  if !isdirectory(l:parentdir) && filewritable(l:parentdir) !=# 2
    call mkdir(l:parentdir, 'p')
  endif

  if a:bang && filereadable(l:dst)
    execute 'keepalt saveas ' . fnameescape(l:dst)
  elseif rename(l:src, l:dst)
    echoerr 'Failed to rename "' . l:src . '" to "' . l:dst . '"'
  else
    setlocal modified

    execute 'keepalt saveas! ' . fnameescape(l:dst)

    if l:src !=# expand('%:p')
      execute 'bwipeout ' . fnameescape(l:src)
    endif

    filetype detect
  endif

  filetype detect
endfunction

" Description: Change the permissions of the current file
" Credits:     Tim Pope <http://tpo.pe/>
" URL:         https://github.com/tpope/vim-eunuch
" Variables: {{{
" ------------------------------------------------------------------------------
let s:permlookup = [
      \   '---',
      \   '--x',
      \   '-w-',
      \   '-wx',
      \   'r--',
      \   'r-x',
      \   'rw-',
      \   'rwx'
      \ ]
" ------------------------------------------------------------------------------ }}}
function! x2a#file#Chmod(bang, perm, ...) abort
  let l:file = expand(a:0 ? join(a:000, ' ') : '%')

  if !a:bang
    let l:perm = ''

    if a:perm =~# '^\0*[0-7]\{3\}$'
      let l:perm = substitute(a:perm[-3:-1], '.', '\=s:permlookup[submatch(0)]', 'g')
    elseif a:perm ==# '+x'
      let l:perm = substitute(getfperm(l:file), '\(..\).', '\1x', 'g')
    elseif a:perm ==# '-x'
      let l:perm = substitute(getfperm(l:file), '\(..\).', '\1-', 'g')
    endif

    if len(l:perm) && !setfperm(l:file, l:perm)
      return
    endif
  endif

  if !executable('chmod')
    throw 'Command not found: chmod'
  endif

  let l:out = get(split(system('chmod ' . (a:bang ? '-R ' : '') . a:perm . ' ' . shellescape(l:file)), "\n"), 0, '')

  if v:shell_error
    let l:errormsg = empty(l:out) ? 'Could not change file permissions' : l:out
    call x2a#utils#echo#Error(l:errormsg)
  endif
endfunction
