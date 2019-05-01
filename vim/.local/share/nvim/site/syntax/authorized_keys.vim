" Highlighting for ssh authorized_keys

" Options
" any WORD at the beginning followed by a key type
syntax match authorizedKeysOptions /^\s*\S\+\%(\s\+\%(ssh-\%(dss\|rsa\)\|ecdsa-sha2-nistp\%(256\|384\|521\)\)\)\@=/
highlight link authorizedKeysOptions PreProc

" Key type
setlocal iskeyword+=-
syntax keyword authorizedKeysType
   \ ssh-dss
   \ ssh-rsa
   \ ecdsa-sha2-nistp256
   \ ecdsa-sha2-nistp384
   \ ecdsa-sha2-nistp521
highlight link authorizedKeysType Type

" Comments (usually emails)
setlocal synmaxcol&
syntax match authorizedKeysComment /\S\+\s*$/
highlight link authorizedKeysComment Comment

" vim: filetype=vim
