" Plugin: vim-gitgutter
" Description: A Vim plugin which shows a git diff in the gutter (sign column)
"              and stages/undoes hunks.
" URL: https://github.com/airblade/vim-gitgutter

scriptencoding utf-8

let g:gitgutter_enabled = 1

let g:gitgutter_sign_added = "\u258F" " ▏
let g:gitgutter_sign_modified = g:gitgutter_sign_added
let g:gitgutter_sign_removed = "\u2581" " ▁
let g:gitgutter_sign_removed_first_line = "\u2594" " ▔
let g:gitgutter_sign_modified_removed = g:gitgutter_sign_added

let g:gitgutter_map_keys = 0
let g:gitgutter_signs = 1
let g:gitgutter_max_signs = 300
let g:gitgutter_highlight_lines = 0
let g:gitgutter_diff_args = '--ignore-space-at-eol'

nmap [c <Plug>(GitGutterPrevHunk)
nmap ]c <Plug>(GitGutterNextHunk)

augroup RAPluginsGitGutter
  autocmd!

  autocmd BufReadPost *
        \ if &readonly || !&modifiable
        \ | call gitgutter#buffer_disable() |
        \ endif
augroup END
