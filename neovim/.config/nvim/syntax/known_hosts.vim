" Highlighting for ~/.ssh/known_hosts

" Markers
setlocal iskeyword+=-
setlocal iskeyword+=@-@
syntax keyword knownHostsMarker @cert-authority @revoked
highlight link knownHostsMarker Identifier

" Hosts
" any WORD followed by a key type
syntax match knownHostsDNS /\S\+\%(\s\+\%(ssh-\%(dss\|rsa\)\|ecdsa-sha2-nistp\%(256\|384\|521\)\)\)\@=/
highlight link knownHostsDNS PreProc

" Key type
syntax keyword knownHostsType
      \ ssh-dss
      \ ssh-rsa
      \ ecdsa-sha2-nistp256
      \ ecdsa-sha2-nistp384
      \ ecdsa-sha2-nistp521
highlight link knownHostsType Type

" vim: filetype=vim
