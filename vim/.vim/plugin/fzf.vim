let g:fzf_command_prefix = 'Fzf'
let g:fzf_colors =
      \ {
      \   'fg':      ['fg', 'Normal'],
      \   'bg':      ['bg', 'Normal'],
      \   'hl':      ['fg', 'Comment'],
      \   'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \   'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \   'hl+':     ['fg', 'Statement'],
      \   'info':    ['fg', 'PreProc'],
      \   'border':  ['fg', 'Ignore'],
      \   'prompt':  ['fg', 'Conditional'],
      \   'pointer': ['fg', 'Exception'],
      \   'marker':  ['fg', 'Keyword'],
      \   'spinner': ['fg', 'Label'],
      \   'header':  ['fg', 'Comment']
      \ }

let g:fzf_follow_symlinks = get(g:, 'fzf_follow_symlinks', 0)

if x2a#fzf#has_fast_command()
  let s:fzf_files_command = x2a#fzf#files_command()

  command! -bang -nargs=? -complete=dir FzfFiles
        \ call fzf#vim#files(<q-args>, { 'source': s:fzf_files_command }, <bang>0)
endif

augroup RAPluginsFzf
  autocmd!

  autocmd FocusGained,TabEnter *
        \ if &filetype ==# 'fzf'
        \ | call feedkeys('i', 'n') |
        \ endif
augroup END

nnoremap <C-p> :FzfFiles<CR>
