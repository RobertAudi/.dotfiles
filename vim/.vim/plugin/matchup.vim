" Plugin: vim-matchup
" Description: Modern matchit and matchparen replacement
" URL: https://github.com/andymass/vim-matchup

let g:matchup_motion_enabled = 1
let g:matchup_text_obj_enabled = 0
let g:matchup_matchparen_deferred = 1
let g:matchup_matchparen_status_offscreen = 0

augroup matchup_matchparen_highlight
  autocmd!

  autocmd ColorScheme * highlight MatchParen term=underline cterm=underline ctermfg=196 ctermbg=NONE gui=underline guifg=#ff4500 guibg=NONE
augroup END
