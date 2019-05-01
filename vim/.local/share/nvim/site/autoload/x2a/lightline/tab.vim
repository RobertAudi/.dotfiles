function! x2a#lightline#tab#Filename(n) abort
  let l:window_number = tabpagewinnr(a:n)
  let l:filetype = gettabwinvar(a:n, l:window_number, '&filetype')

  if x2a#lightline#predicates#IsPluginFiletype(l:filetype)
    return g:x2a#lightline#plugin_filetypes[l:filetype]
  elseif x2a#lightline#predicates#IsSpecialFiletype(l:filetype)
    return g:x2a#lightline#special_filetypes[l:filetype]
  else
    let l:buffer_list = tabpagebuflist(a:n)
    let l:filename = expand('#' . l:buffer_list[l:window_number - 1] . ':t')

    return '' !=# l:filename ? l:filename : '[No Name]'
  endif
endfunction

function! x2a#lightline#tab#TabNumber(n) abort
  return '[' . a:n . ']'
endfunction

function! x2a#lightline#tab#Modified(n) abort
  let l:window_number = tabpagewinnr(a:n)
  let l:filetype      = gettabwinvar(a:n, l:window_number, '&filetype')
  let l:is_readonly   = gettabwinvar(a:n, l:window_number, '&readonly')
  let l:is_modifiable = gettabwinvar(a:n, l:window_number, '&modifiable')
  let l:is_modified   = gettabwinvar(a:n, l:window_number, '&modified')
  let l:ignore_filetype = x2a#lightline#predicates#IgnoreFiletype(l:filetype)

  if l:ignore_filetype || l:is_readonly || !l:is_modifiable
    return ''
  elseif l:is_modified
    return g:x2a#lightline#modified_symbol
  else
    return ''
  endif
endfunction

function! x2a#lightline#tab#Readonly(n) abort
  let l:window_number = tabpagewinnr(a:n)
  let l:filetype = gettabwinvar(a:n, l:window_number, '&filetype')
  let l:is_readonly = gettabwinvar(a:n, l:window_number, '&readonly')
  let l:is_modifiable = gettabwinvar(a:n, l:window_number, '&modifiable')
  let l:ignore_filetype = x2a#lightline#predicates#IgnoreFiletype(l:filetype)

  if l:ignore_filetype
    return ''
  elseif l:is_readonly || !l:is_modifiable
    return g:x2a#lightline#lock_symbol
  else
    return  ''
  endif
endfunction
