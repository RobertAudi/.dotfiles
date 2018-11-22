set encoding=utf-8
scriptencoding utf-8

syntax on
filetype plugin indent on

" Assume POSIX by default, not original Bourne shell
let g:is_posix = 1

" Make sure that the shell scripts are properly highlighted.
let g:bash_is_sh = 1

" syntax/sh.vim adds `.` to iskeyword(verify with :verbose set iskeyword?).
" So `w` jumps past it. see :h g:sh_isk
let g:sh_noisk = 1

" Shell script syntax highlighting craps out on some closing parentheses etc?
let g:sh_no_error = 1

" default shell
set shell=$SHELL

" Display an incomplete command in the
" lower right corner of the Vim window
set showcmd

" Use the System Clipboard
set clipboard^=unnamed,unnamedplus

" Disable all the fucking beeps, bells and flashes, ALL THE FUCKING TIME!
set noerrorbells
set visualbell
set t_vb=
if exists('+belloff')
  set belloff=all
endif

set nomore
set hidden
set switchbuf=useopen,usetab
set hlsearch
set ignorecase
set smartcase
set incsearch
set gdefault
set ttyfast
set lazyredraw
set cmdwinheight=3
set tags+=./tags,./.git/tags
set dictionary=/usr/share/dict/words
set viminfo='33,<50,s10,h

set timeout
set timeoutlen=1000
set ttimeout
set ttimeoutlen=50
let g:default_timeoutlen = &timeoutlen
let g:default_ttimeoutlen = &ttimeoutlen

" Window title
set title
set titlelen=95
set titlestring=%{x2a#TitleString#build()}

" Disable hover tooltips
set noballooneval
let g:netrw_nobeval = 1

" Show more information while completing tags.
set showfulltag

if executable('rg')
  set grepprg=rg\ --smart-case\ --vimgrep
  set grepformat=%f:%l:%c:%m
  cnoreabbrev <expr> rg grep
elseif executable('ag')
  set grepprg=ag\ --smart-case\ --vimgrep
  set grepformat=%f:%l:%c:%m
  cnoreabbrev <expr> ag grep
endif

" Specify the spelling language Spelling
" is disabled globally, but when I do
" enable it the language will be already
" set.
set nospell

" prefer a slight higher line height
set linespace=2

" Always show status line.
set laststatus=2

" Show open tabs. Always.
set showtabline=2

" Show matching brackets.
set showmatch
set matchpairs=(:),[:],{:}

" Match multibyte pairs if Vim supports it.
"   https://github.com/lilydjwg/dotvim/commit/880fc3b
try
  set matchpairs+=《:》,〈:〉,［:］,（:）,｛:｝,「:」,『:』,‘:’,“:”
catch /^Vim\%((\a\+)\)\=:E474/
endtry

" Make j/k respect the columns
set nostartofline

" Wrapping shit
set nowrap

" Setup automatic text formatting/wrapping (formatoptions) {{{
" ------------------------------------------------------------------------------
set formatoptions=
set formatoptions+=c   " Automatically wrap comment lines
set formatoptions+=j   " Remove comment string when joining lines
set formatoptions+=r   " Automatically continue comments
set formatoptions+=2   " Indent based on second line of para, not first
set formatoptions+=o   " Automatically continue comments when hitting 'o' or 'O'
set formatoptions+=q   " Allow formating of comments with 'gq'
set formatoptions+=n   " Automatically indent numbered lists
set formatoptions+=l   " Don't break long lines that were already there
set formatoptions+=B   " Don't insert space between multi-byte characters when joining lines
set formatoptions+=1   " Don't break a line after a one-letter word
" ------------------------------------------------------------------------------ }}}

" Short message settings {{{
" ------------------------------------------------------------------------------
set shortmess=
set shortmess+=a  " Use short version of stuff (Same as filmnrwx)
set shortmess+=tT " Truncate long messages in the middle
set shortmess+=I  " Skip the intro
set shortmess+=oO " Overwrite subsequent messages
set shortmess+=W  " Don't give "written" or "[w]" when writing a file
set shortmess+=c  " Shut off completion messages
" ------------------------------------------------------------------------------ }}}

" Don't try to lines highlight
" longer than 256 characters.
set synmaxcol=256

" Use markers for folds
set foldmethod=marker

" Size of the fold column
set foldcolumn=0

" Start will all folds open
set foldlevelstart=99

" Better fold text
set foldtext=AwesomeFoldText#foldtext()

" Don't force all windows to have the same
" size when creating new splits
set noequalalways

" New window goes below
set splitbelow

" New windows goes right
set splitright

" I hate line numbers
set nonumber
set norelativenumber

" Automatically update buffers when the
" filesystem file changes
set autoread

" Time of inactivity to trigger CursorHold
set updatetime=1000

" Highlight the current line
set cursorline

" Pop-up menu's line height
set pumheight=20

" Minimum help window height
set helpheight=12

" Completion preview height
set previewheight=8

" Height of the command line
set cmdheight=2

" When the page starts to scroll, keep the
" cursor 4 lines from the top and 4 lines
" from the bottom
set scrolloff=4

" Line to scroll when cursor leaves screen
set scrolljump=4

" Same as above but for horizontal
" scrolling
set sidescrolloff=12

" Number of cols to scroll at a time
set sidescroll=1

set textwidth=121
set colorcolumn=121

" Allow backspace beyond insertion point
set backspace=2 " Same as backspace=indent,eol,start

" Do not fucking move the cursor for no
" fucking reason!!!
set whichwrap=

" Enable to select past the end of line in
" blockwise visual mode
set virtualedit=block

" Only insert single space after a '.',
" '?' and '!' with a join command.
set nojoinspaces

" Keep plenty of command and search history, because disk space is cheap
set history=2000

" Always tell me the number of lines changed by a command
set report=0

" Numberformat to use, unsetting bascially only allows decimal
" octal and hex may make trouble if tried to increment/decrement
" certain numberformats
" (e.g. 007 will be incremented to 010, because vim thinks its octal)
set nrformats=

set iskeyword+=_,$,@,%,#,-

" Swaps, backups, and shit {{{
" ------------------------------------------------------------------------------
set backup
set writebackup

" Keep backups with a .bak extension
set backupext=.bak

if empty($SUDO_USER) || $USER ==# $SUDO_USER
  set undofile

  " => $HOME/.tmp/vim/swap/%path%to%orig
  set directory=$HOME/.tmp/vim/swap//,.,/var/tmp
  set backupdir=$HOME/.tmp/vim/backup//,.,/var/tmp
  set undodir=$HOME/.tmp/vim/undo//,.,/var/tmp

  set undolevels=1000
  set undoreload=10000

  " Make important directories if they don't exist
  for dir in [&backupdir, &directory, &undodir, &viewdir]
    if empty(finddir(dir))
      call mkdir(dir, 'p', 0700)
    endif
  endfor
else
  set viminfo=
  set directory-=$HOME/.tmp/vim/swap//
  set directory-=~/tmp
  set backupdir-=$HOME/.tmp/vim/backup//
  set backupdir-=~/tmp
  set undodir=
  set viewdir=
  set noundofile
endif
" ------------------------------------------------------------------------------ }}}

" Don't save terminal windows in sessions
set sessionoptions-=terminal
" Don't save help pages in sessions
set sessionoptions-=help
" Don't save hidden buffers -- only save the visible ones.
set sessionoptions-=buffers

" Tab completion {{{
" ------------------------------------------------------------------------------
set wildmenu
set wildignorecase
set wildmode=longest,full

" wildignore {{{
" ------------------------------------------------------------------------------

" version control
set wildignore+=.git
set wildignore+=.hg
set wildignore+=.svn
set wildignore+=*.orig " Merge resolution files
set wildignore+=.gitkeep
set wildignore+=.keep

" latex intermediate files
set wildignore+=*.aux
set wildignore+=*.fdb_latexmk
set wildignore+=*.fls
set wildignore+=*.idx
set wildignore+=*.out
set wildignore+=*.toc

" binary documents and office documents
set wildignore+=*.djvu
set wildignore+=*.doc   " Microsoft Word
set wildignore+=*.docx  " Microsoft Word
set wildignore+=*.dvi
set wildignore+=*.ods   " Open Document spreadsheet
set wildignore+=*.odt   " Open Document spreadsheet template
set wildignore+=*.pdf
set wildignore+=*.ps
set wildignore+=*.xls   " Microsoft Excel
set wildignore+=*.xlsx  " Microsoft Excel

" binary images
set wildignore+=*.bmp
set wildignore+=*.gif
set wildignore+=*.jpeg
set wildignore+=*.jpg
set wildignore+=*.png

" fonts
set wildignore+=*.eot
set wildignore+=*.ttf
set wildignore+=*.otf
set wildignore+=*.woff
set wildignore+=*.woff2
set wildignore+=*.svg

" music
set wildignore+=*.mp3
set wildignore+=*.flac

" special vim files
set wildignore+=.*.sw? " Vim swap files
set wildignore+=*.spl  " compiled spell word lists

" OS specific files
set wildignore+=.DS_Store

" Backups, caches, logs
set wildignore+=.sass-cache
set wildignore+=*~
set wildignore+=*.zwc
set wildignore+=*.zwc.old
set wildignore+=*.cache
set wildignore+=*.log

" compiled and binary files
set wildignore+=*.class     " java
set wildignore+=*.dll       " windows libraries
set wildignore+=*.exe       " windows executeables
set wildignore+=*.o         " object files
set wildignore+=*.obj       " ?
set wildignore+=*.pyc       " Python byte code
set wildignore+=*.luac      " Lua byte code
set wildignore+=__pycache__ " python stuff
set wildignore+=*.egg-info  " python stuff
set wildignore+=*.p12

" Xcode files
set wildignore+=*.storyboard
set wildignore+=*.xib
set wildignore+=*.xcassets
set wildignore+=*.xcodeproj
set wildignore+=*.xcworkspace
set wildignore+=*.framework

" unsuported archives and images
set wildignore+=*.dmg
set wildignore+=*.iso
set wildignore+=*.tar
set wildignore+=*.tar.bz2
set wildignore+=*.tar.gz
set wildignore+=*.tbz2
set wildignore+=*.tgz
set wildignore+=*.zip

" Other
set wildignore+=tags

" ------------------------------------------------------------------------------ }}}

set complete=
set complete+=. " Scan the current buffer
set complete+=b " Scan other loaded buffers that are in the buffer list
set complete+=w " Scan buffers from other windows
set complete+=u " Scan the unloaded buffers that are in the buffer list
set complete+=U " Scan the buffers that are not in the buffer list

set completeopt=
set completeopt+=menu     " Use a popup menu to show the possible completions
set completeopt+=menuone  " Show menu even if only 1 item long
set completeopt+=noselect " Do not select a match in the menu, force the user to select one

set suffixes+=.log,.out
" ------------------------------------------------------------------------------ }}}

" Whitespace {{{
" ------------------------------------------------------------------------------
set tabstop=2
set shiftwidth=2
set softtabstop=2
set shiftround
set expandtab
set autoindent           " carry over indenting from previous line
set copyindent           " make autoindent use the same characters to indent
set smartindent
set smarttab
" ------------------------------------------------------------------------------ }}}

set list
set listchars=tab:\⋮\ ,extends:›,precedes:‹,trail:·,nbsp:_
set fillchars=vert:│,fold:-,diff:⣿

let &showbreak = '↳  '
set breakindent
set ambiwidth=single

" Ignore changes in amount of white space
set diffopt+=iwhite

" Diff in vertical mode
set diffopt+=vertical

if has('patch-8.1.0360')
  " Use the patience diff algorithm when creating a diff
  set diffopt+=internal,algorithm:patience
endif

" Use the mouse only in normal mode and for hit-enter and more-prompt prompts
set mouse=nr

" Disable the right click
set mousemodel=

" Disable modelines in favor of Secure Modelines (see the plugin)
set modelines=0

" Color scheme
set background=dark

" Credits: Suraj N. Kurapati (sunaku)
" URL: https://github.com/sunaku
" Source: https://github.com/sunaku/.vim/blob/7e004686e4a7f8d66e79572eb477976a40f552a3/plugin/color.vim#L16-L21
if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif
