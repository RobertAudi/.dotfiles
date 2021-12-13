" Plugin: ale.vim
" Description: Check syntax in Vim asynchronously and fix files, with Language Server Protocol (LSP) support
" URL: https://github.com/dense-analysis/ale

scriptencoding utf-8

" Only run linters named in ale_linters settings.
let g:ale_linters_explicit = 1

" \u2581 : ▁
let g:ale_sign_error   = "\u2581"
let g:ale_sign_warning = "\u2581"
let g:ale_sign_info    = "\u2581"

let g:ale_set_highlights = 0
let g:ale_completion_enabled = 0
let g:ale_lint_on_enter = 1
let g:ale_lint_on_filetype_changed = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_update_tagstack = 0

let g:ale_linter_aliases = {'rspec': 'ruby'}

highlight! link ALEStyleError       ALEError
highlight! link ALEErrorSign        ALEError
highlight! link ALEStyleErrorSign   ALEError
highlight! link ALEStyleWarning     ALEWarning
highlight! link ALEWarningSign      ALEWarning
highlight! link ALEStyleWarningSign ALEWarning
highlight! link ALEInfoSign         ALEInfo

augroup RAPluginsAle
  autocmd!

  autocmd ColorScheme * highlight ALEError   cterm=bold ctermfg=196 ctermbg=237 gui=bold guifg=#da4939 guibg=#333435
  autocmd ColorScheme * highlight ALEWarning cterm=bold ctermfg=220 ctermbg=237 gui=bold guifg=#ffc66d guibg=#333435
  autocmd ColorScheme * highlight ALEInfo               ctermfg=74  ctermbg=237 gui=bold guifg=#b6b3eb guibg=#333435

  autocmd BufReadPost *
        \ if &readonly || !&modifiable
        \ | let b:ale_enabled = 0 |
        \ endif
augroup END
