function! x2a#lightline#predicates#IgnoreSpecialFiletype(filetype) abort
  return index(g:x2a#lightline#ignored_special_filetypes, a:filetype) >= 0
endfunction

function! x2a#lightline#predicates#IgnorePluginFiletype(filetype) abort
  return index(g:x2a#lightline#ignored_plugin_filetypes, a:filetype) >= 0
endfunction

function! x2a#lightline#predicates#IgnoreFiletype(filetype) abort
  return x2a#lightline#predicates#IgnoreSpecialFiletype(a:filetype)
        \ || x2a#lightline#predicates#IgnorePluginFiletype(a:filetype)
endfunction

function! x2a#lightline#predicates#IsSpecialFiletype(filetype) abort
  return has_key(g:x2a#lightline#special_filetypes, a:filetype)
endfunction

function! x2a#lightline#predicates#IsPluginFiletype(filetype) abort
  return has_key(g:x2a#lightline#plugin_filetypes, a:filetype)
endfunction
