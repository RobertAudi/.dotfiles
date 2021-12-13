" Plugin: vim-matchup
" Description: Modern matchit and matchparen replacement
" URL: https://github.com/andymass/vim-matchup

let g:matchup_motion_enabled = 1
let g:matchup_text_obj_enabled = 0
let g:matchup_matchparen_deferred = 1
let g:matchup_matchparen_deferred_show_delay = 250
let g:matchup_matchparen_deferred_hide_delay = 750
let g:matchup_matchparen_status_offscreen = 0
let g:matchup_matchparen_timeout = 100
let g:matchup_matchparen_insert_timeout = 50

" Don't match anything within strings and comments
let g:matchup_delim_noskips = 1

augroup RAPluginsMatchup
  autocmd!

  autocmd ColorScheme * highlight MatchParen term=underline cterm=underline ctermfg=196 ctermbg=NONE gui=underline guifg=#ff4500 guibg=NONE
augroup END
