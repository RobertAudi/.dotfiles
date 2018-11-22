" Highlighting for ~/.ssh/known_hosts

if exists("b:current_syntax")
  finish
endif

" Markers
setlocal iskeyword+=-
setlocal iskeyword+=@-@

syntax case ignore
syntax keyword knownHostsMarker @cert-authority @revoked

" Any WORD followed by a key type
syntax match knownHostsDNS /\S\+\%(\s\+\%(ssh-\%(dss\|rsa\)\|ecdsa-sha2-nistp\%(256\|384\|521\)\)\)\@=/

" Host key type
syntax keyword knownHostsType
      \ ssh-dss
      \ ssh-dsa
      \ ssh-rsa
      \ ssh-ed25519
      \ ecdsa-sha2-nistp256
      \ ecdsa-sha2-nistp384
      \ ecdsa-sha2-nistp521

highlight def link knownHostsMarker Identifier
highlight def link knownHostsDNS PreProc
highlight def link knownHostsType Type

let b:current_syntax = "known_hosts"

" vim: filetype=vim
