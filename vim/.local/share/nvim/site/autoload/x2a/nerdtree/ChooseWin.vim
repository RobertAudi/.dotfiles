" Description: Select the window where to open the file.
"              Use the 'choosewin' plugin if it is loaded.
"              Else ask for a user input.
" Source:      https://github.com/weilbith/nerdtree_choosewin-plugin
" Author:      Thore Weilbier (weilbith)
" License:     MIT license
function! x2a#nerdtree#ChooseWin#Open(filenode) abort
  " It is necessary to jump back the NERDTree window, cause local buffer
  " variables are required for the following procedure.
  let l:nerdwindow = win_getid()

  " Check if choosewin has been loaded.
  if exists('g:loaded_choosewin')
    call choosewin#start(range(1, winnr('$')))
  else
    call x2a#utils#echo#Warning('Warn: choosewin not loaded!')

    " This is to make sure the message is seen
    sleep 750m
  endif

  " Jump back to the NERDTree window and continue to open the file.
  call win_gotoid(l:nerdwindow)
  call a:filenode.activate({ 'reuse': 'all', 'where': 'p' })
endfunction
