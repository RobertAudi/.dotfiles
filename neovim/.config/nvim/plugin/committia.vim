" rhysd/committia.vim
" ------------------------------------------------------------------------------
let g:committia_hooks = {}
function! g:committia_hooks.edit_open(info)
  " Additional settings
  setlocal nospell

  " If no commit message, start with insert mode
  if a:info.vcs ==# 'git' && getline(1) ==# ''
    startinsert
  end
endfunction

augroup RAPluginsCommittia
  autocmd!
  autocmd InsertEnter COMMIT_EDITMSG,MERGE_MSG
        \ if &filetype == 'gitcommit' && exists('b:committia_opened')
        \ | setlocal lazyredraw |
        \ endif
augroup END
