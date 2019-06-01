if exists('g:loaded_nerdtree_path_filters')
  finish
endif
let g:loaded_nerdtree_path_filters = 1

call NERDTreeAddPathFilter('x2a#NERDTree#PathFilters#IgnoreSpecialVimDirectories')
call NERDTreeAddPathFilter('x2a#NERDTree#PathFilters#IgnoreZpluginPluginDirectories')
