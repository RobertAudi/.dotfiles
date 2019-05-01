setlocal iskeyword+=:
setlocal iskeyword+=#
setlocal iskeyword+=-

setlocal nocursorline
setlocal readonly
setlocal nomodifiable
setlocal nolist
setlocal wrap
setlocal keywordprg=:help
setlocal bufhidden=hide

if getbufvar('%', '&timeoutlen') != 0
  set timeoutlen=0
endif

call x2a#help#maps#enable()
