" Description: Embed awk highlighting
" See: :h *sh-embed*

if exists('b:current_syntax')
  unlet b:current_syntax
endif

" Silence if syntax/awk.vim not in runtime (e.g. in a crappy vim)
try
  syntax include @AWKScript syntax/awk.vim
catch
endtry

syntax region AWKScriptCode matchgroup=AWKCommand start=+[=\\]\@<!'+ skip=+\\'+ end=+'+ contains=@AWKScript contained
syntax region AWKScriptEmbedded matchgroup=AWKCommand start=+\<awk\>+ skip=+\\$+ end=+[=\\]\@<!'+me=e-1 contains=@shIdList,@shExprList2 nextgroup=AWKScriptCode
syntax cluster shCommandSubList add=AWKScriptEmbedded
highlight def link AWKCommand Type
