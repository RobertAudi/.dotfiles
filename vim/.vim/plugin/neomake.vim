" Plugin: neomake
" Description: Asynchronous linting and make framework for Neovim/Vim
" URL: https://github.com/neomake/neomake

scriptencoding utf-8

" Full config: when writing or reading a buffer, and on changes in insert and
" normal mode (after 500ms; no delay when writing).
call neomake#configure#automake('nrwi', 500)

" \u2581 : ▁
let g:neomake_error_sign   = { 'text': "\u2581", 'texthl': 'NeomakeErrorSign'   }
let g:neomake_warning_sign = { 'text': "\u2581", 'texthl': 'NeomakeWarningSign' }
let g:neomake_message_sign = { 'text': "\u2581", 'texthl': 'NeomakeMessageSign' }
let g:neomake_info_sign    = { 'text': "\u2581", 'texthl': 'NeomakeInfoSign'    }
