setlocal concealcursor=
setlocal conceallevel=0
setlocal nomodeline

setlocal nofoldenable
setlocal norightleft
setlocal noexpandtab

setlocal tabstop=8
setlocal textwidth=78

setlocal iskeyword+=:
setlocal iskeyword+=#
setlocal iskeyword+=-
setlocal keywordprg=:help

if getbufvar('%', '&timeoutlen') == 0
  let &timeoutlen = get(g:, 'default_timeoutlen', 1000)
endif

call x2a#help#maps#disable()