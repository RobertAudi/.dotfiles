" Disable pre-bundled plugins
let g:loaded_getscriptPlugin = 1
let g:loaded_getscript = 1
let g:loaded_gzip = 1
let g:loaded_logiPat = 1
let g:loaded_rrhelper = 1
let g:loaded_spellfile_plugin  = 1
let g:loaded_tarPlugin = 1
let g:loaded_tar = 1
let g:loaded_tutor_mode_plugin = 1
let g:loaded_tarPlugin = 1
let g:loaded_2html_plugin = 1
let g:loaded_vimballPlugin = 1
let g:loaded_vimball = 1
let g:loaded_zipPlugin = 1
let g:loaded_zip = 1

if has('gui_running')
  set t_Co=16
else
  set t_Co=256
  set termencoding=utf-8
  set ttyfast
  set term=screen-256color
endif

filetype plugin indent on
syntax enable

if !filereadable(expand('~/.vim/autoload/plug.vim')) || !isdirectory(expand('~/.vim/plugged'))
  echomsg 'Installing vim-plug...'
  silent! execute '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim &>/dev/null'
  silent! execute 'source ~/.vim/plugins.vim'

  echomsg 'Installing Plugins...'
  execute 'PlugInstall!'

  echomsg 'Quitting in 3 seconds...'
  silent! execute 'sleep 1'
  echomsg 'Quitting in 2 seconds...'
  silent! execute 'sleep 1'
  echomsg 'Quitting in 1 seconds...'
  silent! execute 'sleep 1'
  execute 'quitall'

  finish
endif

if has('gui_macvim')
  let g:macvim_skip_cmd_opt_movement = 1
  let g:macvim_skip_colorscheme = 1
end

" Workaround for this deprecation warning:
"   DeprecationWarning: The imp module is deprecated in favour of importlib;
" https://github.com/SirVer/ultisnips/issues/996
if has('python3')
  silent! python3 1
endif

source ~/.vim/plugins.vim
source ~/.vim/settings.vim
source ~/.vim/syntax.vim
source ~/.vim/abbreviations.vim
source ~/.vim/commands.vim
source ~/.vim/autocommands.vim
source ~/.vim/mappings.vim
