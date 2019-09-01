" Plugin: jumpy.vim
" Description: Filetype-specific mappings for [[ and ]]
" URL: https://github.com/arp242/jumpy.vim

" Include space and * so it won't jump to next tag on the same line.
call jumpy#map('\*[a-zA-Z0-9:_<> *-]\+\*')
