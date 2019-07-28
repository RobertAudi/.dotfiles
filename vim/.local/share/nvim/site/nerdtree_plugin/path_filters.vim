if exists('g:loaded_nerdtree_path_filters')
  finish
endif
let g:loaded_nerdtree_path_filters = 1

call NERDTreeAddPathFilter('x2a#nerdtree#PathFilters#IgnoreSpecialVimDirectories')
call NERDTreeAddPathFilter('x2a#nerdtree#PathFilters#IgnoreZpluginPluginDirectories')
