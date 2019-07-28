function! x2a#nerdtree#PathFilters#IgnoreSpecialVimDirectories(params) abort
  return a:params['path'].str() =~? $DOTFILES_DIR . '\/vim\/\.local\/share\/nvim\/\%(backup\|sessions\|swap\|undo\)'
endfunction

function! x2a#nerdtree#PathFilters#IgnoreZpluginPluginDirectories(params) abort
  return a:params['path'].str() =~? $DOTFILES_DIR . '\/\%(.\+\/\)*\.zplugin\%(\/.*\)*$'
endfunction
