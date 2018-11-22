" itchyny/vim-gitbranch
" ------------------------------------------------------------------------------
" Show git branch with ctrl-g info
function! s:ctrl_g(cnt) abort
  redir => msg | silent execute "norm! 1\<c-g>" | redir END
  echo gitbranch#name() msg[2:] (a:cnt ? strftime('%Y-%m-%d %H:%M', getftime(expand('%:p'))) : '')
endfunction

nnoremap <C-g> :<C-u>call <SID>ctrl_g(v:count)<CR>

" airblade/vim-gitgutter
" ------------------------------------------------------------------------------
let g:gitgutter_sign_added = "\u258F"
let g:gitgutter_sign_modified = g:gitgutter_sign_added
let g:gitgutter_sign_removed = "\u2581"
let g:gitgutter_sign_removed_first_line = "\u2594"
let g:gitgutter_sign_modified_removed = g:gitgutter_sign_added

let g:gitgutter_map_keys = 0
let g:gitgutter_signs = 1
let g:gitgutter_highlight_lines = 0
let g:gitgutter_diff_args = '--ignore-space-at-eol'

nmap [c <Plug>GitGutterPrevHunk
nmap ]c <Plug>GitGutterNextHunk

Autocmd BufWritePost * GitGutter
