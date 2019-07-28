" Source: https://sanctum.geek.nz/cgit/dotfiles.git
"         https://sanctum.geek.nz/cgit/dotfiles.git/tree/vim/after/syntax/vim.vim
"
" Remove special highlighting for double-quoted strings in comments
syntax clear vimCommentString

syntax keyword x2aVimPlug Plug skipwhite nextgroup=vimString

highlight def link x2aVimPlug Statement

" Source: https://sanctum.geek.nz/cgit/dotfiles.git
"         https://sanctum.geek.nz/cgit/dotfiles.git/tree/vim/after/syntax/vim.vim
"
" Highlight :CompilerSet commands like :set/:setlocal, but only in compiler
" scripts in recognisable paths
if expand('%:p:h:t') ==# 'compiler' && expand('%:e') ==# 'vim'
  syntax keyword vimCommand contained CompilerSet
  syntax region vimSet matchgroup=vimCommand
        \ start="\<CompilerSet\>" end="$" end="|" end="<[cC][rR]>"
        \ keepend
        \ matchgroup=vimNotation
        \ oneline
        \ skip="\%(\\\\\)*\\."
        \ contains=vimSetEqual,vimOption,vimErrSetting,vimComment,vimSetString,vimSetMod
endif
