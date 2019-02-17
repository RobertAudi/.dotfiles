function! s:Redir(cmd) abort
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

" Description:
"   Capture and return the long output of a verbose command. Put the output in a scratch buffer.
"   It also works with the :!cmd command and Ex special characters like % (cmdline-special)
"
" Examples:
"
"   :Page version
"   :Page messages
"   :Page ls
"   :Page !wc %
"
function! x2a#utils#page(command) abort
  let l:output = s:Redir(a:command)
  call x2a#utils#scratch()
  normal! gg
  call append(1, split(l:output, "\n"))
endfunction

" Description: Open in secondary editor.
function! x2a#utils#OpenInGUIEditor() abort
  if exists('g:gui_editor')
    let l:buf = bufname('%')
    call system(join([g:gui_editor, l:buf], ' '))
  else
    call x2a#utils#helpers#Warn('g:gui_editor is not set')
  endif
endfunction

" URL:    https://github.com/ivalkeen/dotfiles
" Source: https://github.com/ivalkeen/dotfiles/blob/b645b0caa0ca9fb1c32791b612bd32aa37332dc7/nvim/plugin/my_functions.vim#L90-L96
function! x2a#utils#RailsLog() abort
  tabnew
  execute '0read !tail -n 1000 log/development.log'
  setlocal nomodifiable readonly tabstop=8 textwidth=0 nowrap syntax=diff filetype=diff
  setlocal buftype=nofile noswapfile bufhidden=delete
  normal! G
endfunction

" URL:    https://github.com/kballard/.vim
" Source: https://github.com/kballard/.vim/blob/8ad9711b7c4781bead66f25b942ca1d8997efa48/vimrc#L1984-L1990
function! x2a#utils#ReloadFiletype() abort
  let l:old_filetype = &filetype
  setfiletype none

  " ensure all the syntax items are cleared out
  syntax clear
  let &l:filetype = l:old_filetype
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

" Description: Append stuff to all the selected lines
function! x2a#utils#Append() range abort
  call inputsave()
  let l:str = input('> ')
  call inputrestore()

  redraw!

  if strlen(l:str) > 0
    execute a:firstline . ',' . a:lastline . 'normal A' . l:str
  endif
endfunction

" Description: Resize splits automatically
function! x2a#utils#Splitresize() abort
  let hmax = max([winwidth(0), float2nr(&columns * 0.66), 90])
  let vmax = max([winheight(0), float2nr(&lines * 0.66), 25])
  execute 'vertical resize' . (min([hmax, 140]))
  execute 'resize' . (min([vmax, 60]))
endfunction

function! x2a#utils#UnfuckWhitespace() abort
  " 1. Strip trailing whitespace
  %substitute/\s\+$//e
  " 2. Merge consecutive blank lines
  %substitute/\n\{3,}/\r\r/e
  " 3. Strip empty line from end of file
  %substitute/\n\+\%$//e
endfunction
