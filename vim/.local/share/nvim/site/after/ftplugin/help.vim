setlocal iskeyword+=:
setlocal iskeyword+=#
setlocal iskeyword+=-

setlocal nocursorline
setlocal readonly
setlocal nomodifiable
setlocal nolist
setlocal wrap
setlocal keywordprg=:Help
setlocal bufhidden=hide

if getbufvar('%', '&timeoutlen') != 0
  set timeoutlen=0
endif

call x2a#help#maps#enable()
