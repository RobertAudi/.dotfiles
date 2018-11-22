function! s:Redir(cmd) abort
  let l:output = ''
  redir =>> l:output
  silent exe a:cmd
  redir END
  " remove first blank line
  return l:output[1:]
endfunction

" A command to open a scratch buffer.
function! utils#scratch() abort
  split Scratch
  setlocal buftype=nofile bufhidden=wipe noswapfile nobuflisted
  return bufnr('%')
endfunction

" Capture and return the long output of a verbose command. Put the output in a scratch buffer.
" It also works with the :!cmd command and Ex special characters like % (cmdline-special)
"
" Examples:
"
"   :Page version
"   :Page messages
"   :Page ls
"   :Page !wc %
"
function! utils#page(command) abort
  let l:output = s:Redir(a:command)
  call utils#scratch()
  normal! gg
  call append(1, split(l:output, "\n"))
endfunction

" Diff open windows, specifying which windows by their number
"
" Ex: With 3 windows in the top row and 1 in the bottom, diff the top left and top right windows:
"   :DiffThese 1, 3
function! utils#DiffThese(...) abort
  let l:windows = a:000
  if len(a:000) == 0
    " Default to diffing the top 3 windows (assuming vimdiff)
    let l:windows = [1, 2, 3]
  endif

  let l:start_i = winnr()
  windo diffthis | if index(l:windows, winnr()) == -1 | set nodiff | endif
  execute l:start_i . 'wincmd w'
endfunction

" Open in secondary editor.
function! utils#OpenInGUIEditor() abort
  if exists("g:gui_editor")
    let l:buf = bufname("%")
    call system(join([g:gui_editor, l:buf], ' '))
  else
    echomsg 'g:gui_editor is not set'
  endif
endfunction

function! utils#OpenPluginRepoInBrowser() abort
  let l:line = getline('.')
  let l:pattern = '\v[[:blank:]]*<(Plug(in)?|NeoBundle(Fetch|Lazy)?)>[[:blank:]]'
  let l:match_position = match(l:line, l:pattern)

  if l:match_position >= 0
    let l:repo = substitute(substitute(l:line, l:pattern . "'", '', 'g'), "'.*", '', 'g')
    execute 'silent! !open -g https://github.com/' . l:repo
  endif
endfunction

function! utils#OpenPluginGitHubRepoInBrowser() abort
  let l:line = getline('.')
  let l:sha  = matchstr(l:line, '^  \zs[0-9a-f]\{7}\ze ')
  let l:name = empty(l:sha) ? matchstr(l:line, '^[-x+] \zs[^:]\+\ze:')
        \ : getline(search('^- .*:$', 'bn'))[2:-2]
  let l:uri  = get(get(g:plugs, l:name, {}), 'uri', '')

  if l:uri !~# 'github.com'
    return
  endif

  let l:repo = matchstr(l:uri, '[^:/]*/' . l:name)
  let l:url  = empty(l:sha) ? 'https://github.com/' . l:repo
        \ : printf('https://github.com/%s/commit/%s', l:repo, l:sha)

  call netrw#NetrwBrowseX(l:url, 0)
endfunction

" Stolen from https://github.com/ivalkeen/dotfiles
"   https://github.com/ivalkeen/dotfiles/blob/b645b0caa0ca9fb1c32791b612bd32aa37332dc7/nvim/plugin/my_functions.vim#L90-L96
function! utils#RailsLog() abort
  tabnew
  execute '0read !tail -n 1000 log/development.log'
  setlocal nomodifiable readonly tabstop=8 textwidth=0 nowrap syntax=diff filetype=diff
  setlocal buftype=nofile noswapfile bufhidden=delete
  normal! G
endfunction

" Stolen from https://github.com/raymond-w-ko/dot
"   https://github.com/raymond-w-ko/dot/blob/f8afd2346e58b4f2982170f865c9b1db0ba57d94/.vimrc#L490-L504
" Use aesthetic middle of screen for "zz"
function! utils#CenterCursorAesthetically() abort
  normal! zz

  let l:center = round(winheight(0) / 2.0)
  let l:offset = winheight(0) * 0.1
  let l:final = l:center - l:offset
  let l:rounded_final = float2nr(l:final)
  let l:rounded_offset = float2nr(l:offset)
  let l:delta = winline() - (l:rounded_final + 1)

  if l:delta > 0
    execute 'normal! ' . l:delta . "\<C-e>"
  endif
endfunction

" Stolen from https://github.com/kballard/.vim
"   https://github.com/kballard/.vim/blob/8ad9711b7c4781bead66f25b942ca1d8997efa48/vimrc#L1984-L1990
function! utils#ReloadFiletype() abort
  let l:old_filetype = &filetype
  setfiletype none

  " ensure all the syntax items are cleared out
  syntax clear
  let &l:filetype = l:old_filetype
endfunction

" Stolen from https://github.com/chrisbra/vim_dotfiles
"   https://github.com/chrisbra/vim_dotfiles/blob/98178c298fd9bfd1c832b4f1a6780f103fb34d4c/functions.vim#L319-L338
"
" Show highlight groups under cursor
function! utils#WhatSyntax() abort
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

" Append stuff to all the selected lines
function! utils#Append() range abort
  call inputsave()
  let l:str = input('> ')
  call inputrestore()

  redraw!

  if strlen(l:str) > 0
    execute a:firstline . ',' . a:lastline . 'normal A' . l:str
  endif
endfunction

" ---
" Stolen from https://github.com/gabrielelana/vim-markdown
"   https://github.com/gabrielelana/vim-markdown/blob/08e0731ce2c0b541ea335c782c59bb2e870730d4/ftplugin/markdown.vim#L97-L115
" ---
function! utils#JumpToMarkdownHeader(forward, visual) abort
  let l:cnt = v:count1
  let l:save = @/
  let l:pattern = '\v^#{1,6}.*$|^.+\n%(\-+|\=+)$'
  if a:visual
    normal! gv
  endif
  if a:forward
    let l:motion = '/' . l:pattern
  else
    let l:motion = '?' . l:pattern
  endif
  while l:cnt > 0
    silent! execute l:motion
    let l:cnt = l:cnt - 1
  endwhile
  call histdel('/', -1)
  let @/ = l:save
endfunction

" Make scripts executable on save
function! utils#MakeScriptExecutable() abort
  let file = expand('%:p')
  if getline(1) =~# '^#!' && !executable(file)
    silent! Chmod +x
  endif
endfunction
