" if a:0 is greater than 1, an error will be thrown.
"
" if a:1 is a string, it is used as the session name.
"
" a:1 can also be a dictionary with the following keys:
"
"   name:  Name of the session file. The '.vim' file extension
"          can be omitted.
"          Default: Session.vim
"
"   directory: Location where the session file will be created.
"              Default: $XDG_DATA_HOME/nvim/sessions/%CWD%
"              %CWD% is the full path to the current working directory.
"              Example:
"              cwd: /Users/neo/Developer/vim/my-project
"              directory: $XDG_DATA_HOME/nvim/sessions/Developer/vim/my-project
"              Note: When the 'directory' key is specified, %CWD% is not interpreted.
"
" if a:1 is of another type, an error will be thrown.
function! s:parseopts(...) abort
  if a:0
    if a:0 > 1
      throw 'Argument Error: expected 1 argument but received ' . string(a:0)
    endif

    if type(a:1) is v:t_dict
      let l:opts = a:1
    elseif type(a:1) is v:t_string
      let l:opts = { 'name': a:1 }
    else
      throw 'Argument Error: Dictionary or String expected, got this value instead: ' . string(a:1)
    endif
  else
    let l:opts = {}
  endif

  if !has_key(l:opts, 'name') && !has_key(l:opts, 'directory') && strlen(v:this_session)
    let l:file = v:this_session
    let l:directory = fnamemodify(l:file, ':p:h')
    let l:name = fnamemodify(l:file, ':t')
  else
    let l:directory = get(l:opts, 'directory', x2a#sessions#directory())
    let l:name = get(l:opts, 'name', 'Session.vim')
    let l:name = substitute(l:name, '\%(\.vim\)\?$', '.vim', '')
    let l:file = l:directory . '/' . l:name
  endif

  return [l:opts, l:name, l:directory, l:file]
endfunction

function! s:restore_drawers() abort
  let l:nerdtree_tabs = []
  let l:tagbar_tabs = []
  let l:buffers = []

  for l:tabpage in range(1, tabpagenr('$'))
    for l:buffer in tabpagebuflist(l:tabpage)
      let l:bufname = bufname(l:buffer)

      if l:bufname =~# 'NERD_tree'
        call add(l:nerdtree_tabs, l:tabpage)
        call add(l:buffers, l:buffer)
      elseif l:bufname =~# '__Tagbar__'
        call add(l:tagbar_tabs, l:tabpage)
        call add(l:buffers, l:buffer)
      endif
    endfor
  endfor

  if !empty(l:buffers)
    silent execute 'bwipeout ' . join(uniq(l:buffers), ' ')
  endif

  let l:active_tabpage = tabpagenr()

  if !empty(l:nerdtree_tabs) && exists(':NERDTree')
    for l:nerdtree_tab in l:nerdtree_tabs
      silent execute l:nerdtree_tab . 'tabdo NERDTree | wincmd p'
    endfor

    silent execute l:active_tabpage . 'tabnext'
  endif

  if index(l:tagbar_tabs, l:active_tabpage) >= 0 && exists(':TagbarOpen')
    silent execute 'TagbarOpen'
  endif
endfunction

function! x2a#sessions#directory(...) abort
  if a:0
    if filereadable(a:1)
      let l:path = fnamemodify(a:1, ':p:h')
    elseif isdirectory(a:1)
      let l:path = fnamemodify(a:1, ':p')
    else
      throw 'Argument Error: file or directory does not exist or is not readable: ' . string(a:1)
    endif
  else
    let l:path = getcwd(-1)
  endif

  let l:path = resolve(l:path)

  if l:path !~# '^' . $HOME
    throw 'Argument Error: file or directory is not inside ' . $HOME . ' ($HOME): ' . l:path
  endif

  let l:sessions_directory = get(g:, 'x2a#sessions_directory', $XDG_DATA_HOME . '/nvim/sessions')
  let l:directory = substitute(l:path, '^' . $HOME . '\/\?', l:sessions_directory . '/', '')

  return l:directory
endfunction

" Returns true if there is an active session at the moment.
function! x2a#sessions#active() abort
  return !empty(v:this_session)
endfunction

" Returns the name of the current session, if there's an active session.
function! x2a#sessions#current() abort
  return x2a#sessions#active() ? fnamemodify(v:this_session, ':t') : ''
endfunction

" a:1 can be a string or a dictionary.
" if a:1 is of another type, an error will be thrown.
" if a:0 is greater than 1, an error will be thrown.
" See: s:parseopts for details.
function! x2a#sessions#save(...) abort
  let [l:opts, l:name, l:directory, l:file] = call('s:parseopts', a:000)

  if isdirectory(l:directory) && filewritable(l:directory) != 2
    throw 'Permissions error: Directory not writable: ' . l:directory
  endif

  call mkdir(l:directory, 'p')

  if filereadable(l:file) && (!strlen(v:this_session) || v:this_session !=# l:file)
    call x2a#utils#echo#Warning('Warning: A session file with the same name already exists.')

    let l:choice = confirm('Do you want to save the session anyway?', "&Yes\n&No")

    if l:choice != 1
      return v:false
    endif
  endif

  execute 'mksession! ' . l:file

  let v:this_session = l:file

  call x2a#utils#echo#Message('Saved saved: ' . l:name . ' (file: ' . l:file . ')')

  return v:true
endfunction

" a:1 can be a string or a dictionary.
" if a:1 is of another type, an error will be thrown.
" if a:0 is greater than 1, an error will be thrown.
" See: s:parseopts for details.
function! x2a#sessions#load(...) abort
  let [l:opts, l:name, l:directory, l:file] = call('s:parseopts', a:000)

  let l:modified_buffers_count = x2a#buffers#CountModifiedBuffers()

  if l:modified_buffers_count
    let l:message = 'Aborting: ' . l:modified_buffers_count . ' buffer' . (l:modified_buffers_count > 1 ? 's' : '')
          \ . ' have unsaved changes.'

    call x2a#utils#echo#Error(l:message)

    return v:false
  endif

  let l:buffers_count = x2a#buffers#Count()

  if l:buffers_count
    let l:message = 'You have ' . l:buffers_count . ' open buffer' . (l:buffers_count > 1 ? 's' : '') . '.'
          \ . ' Loading the session will first close all buffers.'

    call x2a#utils#echo#Warning(l:message)

    let l:choice = confirm('Do you want to load the session anyway?', "&Yes\n&No")

    if l:choice != 1
      return v:false
    endif
  endif

  if !filereadable(l:file)
    let l:message = 'Error: Session file does not exist or is not readable: ' . l:file

    call x2a#utils#echo#Error(l:message)

    return v:false
  elseif strlen(v:this_session) && (has_key(l:opts, 'name') || has_key(l:opts, 'directory')) && v:this_session ==# l:file
    call x2a#utils#echo#Warning('A session with the same name is already loaded.')

    let l:choice = confirm('Do you want to load the session anyway?', "&Yes\n&No")

    if l:choice != 1
      return v:false
    endif
  endif

  let l:lazyredraw_keep = &lazyredraw

  set lazyredraw

  silent execute '%bwipeout'

  silent execute 'source ' . l:file

  call s:restore_drawers()

  let &lazyredraw = l:lazyredraw_keep

  call x2a#utils#echo#Message('Session loaded: ' . l:name . ' (file: ' . l:file . ')')

  return v:true
endfunction

" Same as x2a#sessions#load() except that
" it doesn't set v:this_session
function! x2a#sessions#resume(...) abort
  silent let l:session_loaded = call('x2a#sessions#load', a:000)

  if l:session_loaded
    let l:file = v:this_session
    let l:name = fnamemodify(l:file, ':t')
    let v:this_session = ''

    call x2a#utils#echo#Message('Session resumed: ' . l:name . ' (file: ' . l:file . ')')

    return v:true
  else
    let l:message = empty(v:errmsg) ? 'Failed to resume session.' : v:errmsg

    call x2a#utils#echo#Error(l:message)

    return v:false
  endif
endfunction

" a:1 can be a string or a dictionary.
" if a:1 is of another type, an error will be thrown.
" if a:0 is greater than 1, an error will be thrown.
" See: s:parseopts for details.
"
" This function also accepts the 'force' option to
" delete a session without confirmation.
" It must be a boolean and the default value is 0.
function! x2a#sessions#delete(...) abort
  let [l:opts, l:name, l:directory, l:file] = call('s:parseopts', a:000)

  if !filewritable(l:file)
    let l:message = 'Error: Session file does not exist or you do not have the required permissions to delete it: ' . l:file

    call x2a#utils#echo#Error(l:message)

    return v:false
  endif

  let l:force = get(l:opts, 'force', v:false)

  if type(l:force) isnot v:t_bool
    throw 'Argument Error: The force option must be a boolean, got this value instead: ' . string(l:force)
  endif

  if l:force
    let l:choice = v:true
  else
    call x2a#utils#echo#Warning('This session will be deleted: ' . l:name . ' (file: ' . l:file . ')')

    let l:choice = confirm('Do you want to proceed?', "&Yes\n&No") == 1
  endif

  if !l:choice
    call x2a#utils#echo#Error('Abort: Session not deleted: ' . l:name . ' (file: ' . l:file . ')')

    return v:false
  endif

  let l:deleted = delete(l:file)

  if l:deleted == -1
    let l:message = 'Error: The session could not be deleted: ' . l:file

    call x2a#utils#echo#Error(l:message)

    return v:false
  endif

  if strlen(v:this_session) && (has_key(l:opts, 'name') || has_key(l:opts, 'directory')) && v:this_session ==# l:file
    let v:this_session = ''
  endif

  call x2a#utils#echo#Message('Session deleted: ' . l:name . ' (file: ' . l:file . ')')

  return v:true
endfunction
