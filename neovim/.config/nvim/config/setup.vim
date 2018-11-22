" Python setup {{{
" ------------------------------------------------------------------------------

if filereadable(expand('~/.pyenv/versions/neovim2/bin/python'))
  let g:python_host_prog = expand('~/.pyenv/versions/neovim2/bin/python')
endif

if filereadable(expand('~/.pyenv/versions/neovim3/bin/python'))
  let g:python_host_prog = expand('~/.pyenv/versions/neovim3/bin/python')
endif

" ------------------------------------------------------------------------------ }}}

" Setup {{{
" ------------------------------------------------------------------------------

scriptencoding utf-8

augroup RAVimAutocommands
  autocmd!
augroup END

command! -nargs=* Autocmd autocmd RAVimAutocommands <args>
command! -nargs=* AutocmdFT autocmd RAVimAutocommands FileType <args>

AutocmdFT vim highlight def link raVimAutocmd vimAutoCmd
AutocmdFT vim match raVimAutocmd /\<\(Autocmd\|AutocmdFT\)\>/

" ------------------------------------------------------------------------------ }}}
