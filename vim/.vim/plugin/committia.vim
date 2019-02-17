" Plugin: committia.vim
" Description: A Vim plugin for more pleasant editing on commit messages
" URL: https://github.com/rhysd/committia.vim

if has('gui_running')
  finish
endif

let g:committia_hooks = {}
function! g:committia_hooks.edit_open(info) abort
  " Additional settings
  setlocal nospell
  setlocal nocursorline
  setlocal nolist

  " If no commit message, start with insert mode
  if a:info.vcs ==# 'git' && getline(1) ==# ''
    startinsert
  end
endfunction
