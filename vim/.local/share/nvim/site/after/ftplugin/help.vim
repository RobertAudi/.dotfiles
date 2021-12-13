setlocal iskeyword+=:
setlocal iskeyword+=#
setlocal iskeyword+=-

setlocal keywordprg=:help

setlocal nocursorline
setlocal readonly
setlocal nomodifiable
setlocal nolist
setlocal wrap
setlocal bufhidden=hide

setlocal nospell

if getbufvar('%', '&timeoutlen') != 0
  set timeoutlen=0
endif

call x2a#help#maps#enable()
