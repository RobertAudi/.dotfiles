" Syntax
let ruby_no_expensive = 1
let ruby_space_errors = 1
let ruby_operators    = 1
let ruby_fold = 1

" Omni
let g:rubycomplete_buffer_loading = 0
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1

let b:ctrlp_root_markers = ['Rakefile', 'Gemfile', '.ruby-version']

" Consider `!` and `?` as part of a word text object.
setlocal iskeyword+=!,?

nnoremap <buffer> <LocalLeader>wtf oputs "#" * 90<c-m>puts caller<c-m>puts "#" * 90<esc>
