function! s:mixedcase(word)
  return substitute(s:camelcase(a:word),'^.','\u&','')
endfunction

function! s:camelcase(word)
  let word = substitute(a:word, '-', '_', 'g')
  if word !~# '_' && word =~# '\l'
    return substitute(word,'^.','\l&','')
  else
    return substitute(word,'\C\(_\)\=\(.\)','\=submatch(1)==""?tolower(submatch(2)) : toupper(submatch(2))','g')
  endif
endfunction

function! s:snakecase(word)
  let word = substitute(a:word,'::','/','g')
  let word = substitute(word,'\(\u\+\)\(\u\l\)','\1_\2','g')
  let word = substitute(word,'\(\l\|\d\)\(\u\)','\1_\2','g')
  let word = substitute(word,'[.-]','_','g')
  let word = tolower(word)
  return word
endfunction

function! s:uppercase(word)
  return toupper(s:snakecase(a:word))
endfunction

function! s:dashcase(word)
  return substitute(s:snakecase(a:word),'_','-','g')
endfunction

function! s:spacecase(word)
  return substitute(s:snakecase(a:word),'_',' ','g')
endfunction

function! s:dotcase(word)
  return substitute(s:snakecase(a:word),'_','.','g')
endfunction

function! s:titlecase(word)
  return substitute(s:spacecase(a:word), '\(\<\w\)','\=toupper(submatch(1))','g')
endfunction

