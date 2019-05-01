" Plugin: neomake
" Description: Asynchronous linting and make framework for Neovim/Vim
" URL: https://github.com/neomake/neomake

scriptencoding utf-8

" \u2581 : ▁
let g:neomake_error_sign   = { 'text': "\u2581", 'texthl': 'NeomakeErrorSign'   }
let g:neomake_warning_sign = { 'text': "\u2581", 'texthl': 'NeomakeWarningSign' }
let g:neomake_message_sign = { 'text': "\u2581", 'texthl': 'NeomakeMessageSign' }
let g:neomake_info_sign    = { 'text': "\u2581", 'texthl': 'NeomakeInfoSign'    }

let g:lint_types =
      \ [
      \   'css',
      \   'html',
      \   'javascript',
      \   'json',
      \   'markdown',
      \   'ruby',
      \   'sh',
      \   'vim'
      \ ]

augroup RAPluginsNERDTree
  autocmd!

  autocmd BufWritePost *
        \ if index(g:lint_types, &filetype) >= 0 && empty(&buftype)
        \ | Neomake |
        \ endif
augroup END
