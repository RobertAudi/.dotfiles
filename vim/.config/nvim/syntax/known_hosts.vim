" Vim syntax file
" Language:    ssh_known_hosts
" Maintainer:  YOSHIOKA Takuma <tashioka.256@gmail.com>
" Last Change: 2017 Jun 02
" Remark:      OpenSSH known_hosts syntax.

if exists("b:current_syntax")
  finish
endif

syntax case ignore

syntax region SshKnownHostsLine start=/^/ end=/$/ contains=SshKnownHostsLineComment,SshKnownHostsMarkers,SshKnownHostsHostnames

syntax match SshKnownHostsHostnames excludenl nextgroup=SshKnownHostsKeytype skipwhite '[^ ]\+ ' contained contains=SshKnownHostsHostname
syntax match SshKnownHostsMarkers excludenl nextgroup=SshKnownHostsHostnames skipwhite '^@[^ ]\+' contained

" Host key type
syntax keyword SshKnownHostsKeytype excludenl nextgroup=SshKnownHostsBase64EncodedKey skipwhite contained
      \ ssh-dss
      \ ssh-dsa
      \ ssh-rsa
      \ ssh-ed25519
      \ ecdsa-sha2-nistp256
      \ ecdsa-sha2-nistp384
      \ ecdsa-sha2-nistp521

syntax match SshKnownHostsBase64EncodedKey excludenl nextgroup=SshKnownHostsBodyComment skipwhite '[a-zA-Z0-9+/]\+=*' contained
syntax match SshKnownHostsBodyComment excludenl '.*' contained

" Single hostname.
syntax match SshKnownHostsHostname excludenl '[^, ]\+' contained contains=SshKnownHostsHostnameNegativePattern,SshKnownHostsHostnamePattern

" hostname / ipv4 / [hostname] / [ipv4] / [ipv6] / [hostname]:port / [ipv4]:port / [ipv6]:port
syntax match SshKnownHostsHostnamePattern excludenl /[^!][^, ]*/ contained transparent
            \ contains=SshKnownHostsHostnameBracket,SshKnownHostsHostnameSimpleHostname,SshKnownHostsHostnameSimpleIpv4Addr,SshKnownHostsHostnameHashedHostname
" !pattern
syntax match SshKnownHostsHostnameNegativePattern excludenl /!/ contained nextgroup=SshKnownHostsHostnamePattern

" [hostname] / [ipv4] / [ipv6]
syntax match SshKnownHostsHostnameBracket excludenl /\[[^][, ]\+\]/ contained nextgroup=SshKnownHostsHostnamePort
            \ contains=SshKnownHostsHostnameBracketHostname,SshKnownHostsHostnameBracketIpAddr
" :port
syntax match SshKnownHostsHostnamePort excludenl /\(:\d\+\)\?/ contained
" [hostname]
syntax match SshKnownHostsHostnameBracketHostname excludenl /\[[^][, :]\+\]/ms=s+1,me=e-1 contained
" [ipv4] / [ipv6]
syntax match SshKnownHostsHostnameBracketIpAddr excludenl /\[\([0-9*?]\+\(\.[0-9*?]\+\)\{3}\|[0-9a-fA-F*?]*\(:[0-9a-fA-F*?]*\)\{,7}\)\]/ms=s+1,me=e-1 contained nextgroup=SshKnownHostsHostnamePort
" hostname
syntax match SshKnownHostsHostnameSimpleHostname excludenl /[^][, :]\+/ contained
" ipv4
syntax match SshKnownHostsHostnameSimpleIpv4Addr excludenl /\([0-9*?]\+\.\)\{3}[0-9*?]\+/ contained
" |fmt|hashed_base64_hostname|
syntax match SshKnownHostsHostnameHashedHostname /|[^|]*|[a-zA-Z0-9+/]\+=*|/ contained

" Comments
syntax region SshKnownHostsLineComment oneline start=/^#/ end=/$/ contained containedin=SshKnownHostsLine

highlight link SshKnownHostsLineComment              Comment
highlight link SshKnownHostsMarkers                  Keyword
highlight link SshKnownHostsKeytype                  Type
highlight link SshKnownHostsBase64EncodedKey         Normal
highlight link SshKnownHostsBodyComment              Comment
highlight link SshKnownHostsHostnames                Delimiter
highlight link SshKnownHostsHostnameNegativePattern  Exception
highlight link SshKnownHostsHostnameBracket          Label
highlight link SshKnownHostsHostnamePort             Number
highlight link SshKnownHostsHostnameSimpleHostname   Title
highlight link SshKnownHostsHostnameBracketHostname  Title
highlight link SshKnownHostsHostnameSimpleIpv4Addr   Constant
highlight link SshKnownHostsHostnameBracketIpAddr    Constant
highlight link SshKnownHostsHostnameHashedHostname   Identifier

let b:current_syntax = "known_hosts"

" vim: set filetype=vim :
