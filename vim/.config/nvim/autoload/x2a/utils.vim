function! x2a#utils#Redir(cmd) abort
  let l:output = ''
  redir =>> l:output
  silent exe a:cmd
  redir END
  " remove first blank line
  return l:output[1:]
endfunction

" Description: A command to open a scratch buffer.
function! x2a#utils#scratch() abort
  split Scratch
  setlocal buftype=nofile bufhidden=wipe noswapfile nobuflisted
  return bufnr('%')
endfunction

" Description: Open in secondary editor.
function! x2a#utils#OpenInGUIEditor() abort
  if exists('g:gui_editor')
    let l:buf = bufname('%')
    call system(join([g:gui_editor, l:buf], ' '))
  else
    call x2a#utils#echo#Error('g:gui_editor is not set')
  endif
endfunction

" Description: Show highlight groups under cursor
" URL:    https://github.com/chrisbra/vim_dotfiles
" Source: https://github.com/chrisbra/vim_dotfiles/blob/98178c298fd9bfd1c832b4f1a6780f103fb34d4c/functions.vim#L319-L338
function! x2a#utils#WhatSyntax() abort
  if exists(':for')
    echo '<' .
          \ synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
          \ . '> from:'

    let l:indent = ''
    for l:syn_id in synstack(line('.'), col('.'))
      echo l:indent . '<' . synIDattr(l:syn_id, 'name') . '>'
      let l:indent .= ' '
    endfor
  else
    " can't do for loop, at least display something
    echo 'hi<' .
          \ synIDattr(synID(line('.'), col('.'), 1), 'name')
          \ . '> trans<' . synIDattr(synID(line('.'), col('.'), 0), 'name') . '> lo<'
          \ . synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name') . '>'
  endif
endfunction

function! x2a#utils#UnfuckWhitespace() abort
  " 1. Strip trailing whitespace
  execute '%substitute/\s\+$//e'
  " 2. Merge consecutive blank lines
  execute '%substitute/\n\{3,}/\r\r/e'
  " 3. Strip empty line from end of file
  execute '%substitute/\n\+\%$//e'
endfunction

" Execute commands without moving cursor,
" changing search pattern
"
" - First parameter is a function name to
"   call as a string
" - Second (optional) parameter is an
"   array of arguments to pass to the
"   function
function! x2a#utils#Preserve(func, ...) abort
  let l:FuncRef = function(a:func)
  if a:0 > 0
    let l:args = a:1
  else
    let l:args = []
  endif

  let l:saved_search = @/
  let l:saved_view = winsaveview()

  let l:return_value = call(l:FuncRef, l:args)

  call winrestview(l:saved_view)
  let @/ = l:saved_search

  return l:return_value
endfunction

" Author: Andrew Radev
" URL: https://github.com/AndrewRadev/Vimfiles
" Source: https://github.com/AndrewRadev/Vimfiles/blob/b02e9ed925c9eeecc4629ac1cc8b235d432f64f6/startup/commands.vim#L153,157
function! x2a#utils#Redraw() abort
  syntax sync fromstart

  nohlsearch

  redraw!
endfunction
