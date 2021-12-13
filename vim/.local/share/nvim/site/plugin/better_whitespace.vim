" Plugin: vim-better-whitespace
" Description: Better whitespace highlighting for Vim
" URL: https://github.com/ntpeters/vim-better-whitespace

let g:strip_whitespace_on_save = 0
let g:better_whitespace_filetypes_blacklist =
      \ [
      \   'help',
      \   'qf',
      \   'man',
      \   'ctrlsf',
      \   'vim-plug',
      \   'vista',
      \   'TelescopePrompt',
      \   'TelescopeResults',
      \   'floaterm',
      \   'diff',
      \   'git',
      \   'gitcommit',
      \   'gitrebase',
      \   'gitblame'
      \ ]

augroup RAPluginsBetterWhitespace
  autocmd!

  autocmd BufReadPost *
        \ if &readonly || !&modifiable
        \ | execute 'DisableWhitespace' |
        \ endif
augroup END
