" Plugin: vim-plug
" Description: Minimalist Vim Plugin Manager
" URL: https://github.com/junegunn/vim-plug

call x2a#abolish#commands('PlugInstall',
      \ 'plugi', 'plugin',
      \ 'Plugi', 'Plugin')

call x2a#abolish#commands('PlugClean',
      \ 'plugc', 'plugclean',
      \ 'Plugc', 'Plugclean')

call x2a#abolish#commands('PlugUpdate',
      \ 'plugu', 'plugup', 'plugupd', 'plugupdate',
      \ 'Plugu', 'Plugup', 'Plugupd', 'Plugupdate')
