" Highlighting for ssh authorized_keys

if exists("b:current_syntax")
  finish
endif

" Options
syntax keyword authorizedKeysOptions
      \ cert-authority
      \ command
      \ environment
      \ from
      \ permitopen
      \ principals
      \ restrict
      \ tunnel
      \ zos-key-ring-label

syntax match authorizedKeysOptions "\(no-\)\?agent-forwarding"
syntax match authorizedKeysOptions "\(no-\)\?port-forwarding"
syntax match authorizedKeysOptions "\(no-\)\?pty"
syntax match authorizedKeysOptions "\(no-\)\?user-rc"
syntax match authorizedKeysOptions "\(no-\)\?X11-forwarding"

" Host key type
syntax keyword authorizedKeysType
      \ ssh-dss
      \ ssh-dsa
      \ ssh-rsa
      \ ssh-ed25519
      \ ecdsa-sha2-nistp256
      \ ecdsa-sha2-nistp384
      \ ecdsa-sha2-nistp521

" Strings
syntax region authorizedKeysString start=/"/ skip=/\\"/ end=/"/ oneline

" Comments
syntax match authorizedKeysComment /^#.*/
syntax match authorizedKeysComment /= .*$/ms=s+1
syntax match authorizedKeysComment /==.*$/ms=s+2

highlight link authorizedKeysType    Type
highlight link authorizedKeysComment Comment
highlight link authorizedKeysOptions Keyword
highlight link authorizedKeysString  String

let b:current_syntax = "authorized_keys"

" vim: set filetype=vim :
