" Settings {{{
" ------------------------------------------------------------------------------

" Default fileformat.
set fileformat=unix

" Automatic recognition of a new line cord.
set fileformats=unix,dos,mac

" :h shada
set shada=!,'300,<50,s10,h

" Ignore the case of normal letters.
set ignorecase

" If the search pattern contains upper case characters, override ignorecase option.
set smartcase

" Enable incremental search.
set incsearch

" Highlight search result.
set hlsearch

" Searches wrap around the end of the file.
set wrapscan

" Smart insert tab setting.
set smarttab

" Exchange tab to spaces.
set expandtab

" Substitute <Tab> with blanks.
set tabstop=2

" Spaces instead <Tab>.
set softtabstop=2

" Autoindent width.
set shiftwidth=2

" Do not round indent by shiftwidth.
set noshiftround

" Carry over indenting from previous line
set autoindent
set breakindent

" Enable smart indent.
set smartindent

" Make autoindent use the same characters to indent
set copyindent

" Do not fucking move the cursor for no fucking reason!!!
set whichwrap=

" Disable wrapping
set nowrap

" Allow backspace beyond insertion point
set backspace=indent,eol,start

" Make j/k respect the columns
set nostartofline

" Only insert single space after a '.', '?' and '!' with a join command.
set nojoinspaces

" Highlight <>.
set matchpairs+=<:>

" Display another buffer when current buffer isn't saved.
set hidden

" Automatically update buffers when the filesystem file changes
set autoread

" Keymapping timeout.
set timeout
set timeoutlen=1000
set ttimeoutlen=50

" Enable to select past the end of line in blockwise visual mode
set virtualedit=block

" Setup automatic text formatting/wrapping
set formatoptions=
set formatoptions+=c   " Do autowrap comments
set formatoptions+=j   " Remove comment string when joining lines
set formatoptions+=r   " Automatically continue comments
set formatoptions+=2   " Indent based on second line of para, not first
set formatoptions+=o   " Automatically continue comments when hitting 'o' or 'O'
set formatoptions+=q   " Allow formating of comments with 'gq'
set formatoptions+=n   " Recognize numbered lists
set formatoptions+=l   " Don't break long lines that were already there
set formatoptions+=B   " Don't insert space between multi-byte characters when joining lines
set formatoptions+=1   " Don't break a line after a one-letter word

" Use the System Clipboard
if has('unnamedplus')
  set clipboard+=unnamedplus
else
  set clipboard+=unnamed
endif

" Swaps, backups, and shit
if strlen($SUDO_USER)
  set nobackup
  set nowritebackup
  set noundofile
else
  set backup
  set writebackup
  set undofile

  set backupdir=$XDG_DATA_HOME/nvim/backup//,.,/var/tmp
  set undodir=$XDG_DATA_HOME/nvim/undo//,.,/var/tmp
  set directory=$XDG_DATA_HOME/nvim/swap//,.,/var/tmp
endif

" Hide line numbers
set nonumber
set norelativenumber

" Show <TAB> and <CR>
set list
set listchars=tab:\⋮\ ,extends:›,precedes:‹,trail:·,nbsp:_

" Characters to fill the statuslines and vertical separators
set fillchars=vert:\|,fold:-,diff:⣿

" Always display statusline.
set laststatus=2

" Height of command line.
set cmdheight=2

" Set maximam maximam command line window.
set cmdwinheight=5

" Minimum help window height
set helpheight=12

" Completion preview height
set previewheight=8

" Set popup menu max height.
set pumheight=20

" When the page starts to scroll, keep the cursor 8 lines from the top and 8 lines from the bottom
set scrolloff=8

" Line to scroll when cursor leaves screen
set scrolljump=10

" Same as above but for horizontal scrolling
set sidescrolloff=12

" Number of cols to scroll at a time
set sidescroll=1

" Show a ruler at 120+ characters
set colorcolumn=120

" Don't show command on statusline.
set noshowcmd

" String to put at the start of lines that have been wrapped
set showbreak=›››\ "

" Short message settings
set shortmess=
set shortmess+=a  " Use short version of stuff (Same as filmnrwx)
set shortmess+=tT " Truncate long messages in the middle
set shortmess+=I  " Skip the intro
set shortmess+=oO " Overwrite subsequent messages
set shortmess+=W  " Don't give "written" or "[w]" when writing a file

" Disable all the fucking beeps, bells and flashes, ALL THE FUCKING TIME!
set t_vb=
set noerrorbells
set novisualbell
set belloff=all

" New window goes below
set splitbelow

" New windows goes right
set splitright

" Don't force all windows to have the same size when creating new splits
set noequalalways

" Keep plenty of command and search history
set history=10000

" Always tell me the number of lines changed by a command
set report=0

" When a line is long, do not omit it in @.
set display=lastline

" Disable conceal
set conceallevel=0
set concealcursor=

" Display all the information of the tag by the supplement of the Insert mode.
set showfulltag

" Don't open buffers in multiple windows/tabs
set switchbuf=useopen,usetab

" Use markers for folds
set foldmethod=marker

" Size of the fold column
set foldcolumn=0

" Start will all folds open
set foldlevelstart=99

" Use the mouse only in normal mode and for hit-enter and more-prompt prompts
set mouse=nr

" Disable the right click
set mousemodel=

" Check for file specific vim settings in the last line of the file
set modeline
set modelines=1

" Color scheme
set background=dark

" ~ Tab completion
" ------------------------------------------------------------------------------

" Command mode
set wildmenu
set wildignorecase
set wildmode=list:full,full
set wildignore+=*.tar.*,*.zip,.sass-cache,*.p12
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg
set wildignore+=*.eot,*.ttf,*.otf,*.woff,*.woff2,*.svg
set wildignore+=.DS_Store,tags,*~,.keep,*.zwc,*.zwc.old,*.cache,*.log,*.sw?
set wildignore+=*.storyboard,*.xib,*.xcassets,*.xcodeproj,*.xcworkspace,*.framework

" Insert mode
set complete=.,w,b,u,U,t,i
set completeopt=menuone,menu,longest

" ------------------------------------------------------------------------------ }}}
