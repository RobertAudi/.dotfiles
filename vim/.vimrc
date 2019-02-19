set encoding=utf-8
set termencoding=utf-8
scriptencoding utf-8

" Setup {{{
" ------------------------------------------------------------------------------

set t_Co=256
set ttyfast

if !has('gui_running')
  if empty($TMUX)
    set term=xterm-256color
  else
    set term=screen-256color
  endif
endif

" Credits: Suraj N. Kurapati (sunaku)
" URL: https://github.com/sunaku
" Source: https://github.com/sunaku/.vim/blob/7e004686e4a7f8d66e79572eb477976a40f552a3/plugin/color.vim#L16-L21
"
" Disable Background Color Erase (BCE) so that color schemes
" render properly when inside 256-color tmux and GNU screen.
" See also http://snk.tuxfamily.org/log/vim-256color-bce.html
set t_ut=

filetype plugin indent on

if !exists('g:syntax_on')
  syntax enable
endif

" Disable pre-bundled plugins {{{
" ------------------------------------------------------------------------------

let g:loaded_getscriptPlugin = 1
let g:loaded_getscript = 1
let g:loaded_gzip = 1
let g:loaded_logiPat = 1
let g:loaded_rrhelper = 1
let g:loaded_spellfile_plugin  = 1
let g:loaded_tarPlugin = 1
let g:loaded_tar = 1
let g:loaded_tutor_mode_plugin = 1
let g:loaded_2html_plugin = 1
let g:loaded_vimballPlugin = 1
let g:loaded_vimball = 1
let g:loaded_zipPlugin = 1
let g:loaded_zip = 1

" ------------------------------------------------------------------------------ }}}

" Install vim-plug if needed {{{
" ------------------------------------------------------------------------------

if !filereadable(expand('~/.vim/autoload/plug.vim')) || !isdirectory(expand('~/.vim/plugged'))
  echomsg 'Installing vim-plug...'
  silent! execute '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim &>/dev/null'
  silent! execute 'source ~/.vim/plugins.vim'

  echomsg 'Installing Plugins...'
  execute 'PlugInstall!'

  echomsg 'Quitting in 3 seconds...'
  silent! execute 'sleep 1'
  echomsg 'Quitting in 2 seconds...'
  silent! execute 'sleep 1'
  echomsg 'Quitting in 1 seconds...'
  silent! execute 'sleep 1'
  execute 'quitall'

  finish
endif

" ------------------------------------------------------------------------------ }}}

" Workaround for this deprecation warning:
"   DeprecationWarning: The imp module is deprecated in favour of importlib;
" https://github.com/SirVer/ultisnips/issues/996
if has('python3')
  silent! python3 1
endif

if has('gui_macvim')
  let g:macvim_skip_cmd_opt_movement = 1
  let g:macvim_skip_colorscheme = 1
end

" ------------------------------------------------------------------------------ }}}

" Settings {{{
" ------------------------------------------------------------------------------

" default shell
set shell=$SHELL

" Use the System Clipboard
if has('unnamedplus')
  set clipboard^=unnamed,unnamedplus
else
  set clipboard^=unnamed
endif

" Disable all the fucking beeps, bells and flashes, ALL THE FUCKING TIME!
set noerrorbells
set visualbell
set t_vb=
if exists('+belloff')
  set belloff=all
endif

" Always tell me the number of lines changed by a command
set report=0

" Keep plenty of command and search history, because disk space is cheap
set history=2000

" Number format to use. Unsetting bascially only allows decimal.
" Octal and hex may make trouble if tried to increment/decrement
" certain numberformats
" (e.g. 007 will be incremented to 010, because vim thinks its octal)
set nrformats=

set iskeyword+=_,$,@,%,#,-

" Automatically update buffers when the
" filesystem file changes
set autoread

" Disable hover tooltips
set noballooneval
let g:netrw_nobeval = 1

" Buffers and splits {{{
" ------------------------------------------------------------------------------

set hidden
set switchbuf=useopen,usetab

" Don't force all windows to have the same
" size when creating new splits
set noequalalways

" New window goes below
set splitbelow

" New windows goes right
set splitright

" ------------------------------------------------------------------------------ }}}

" Looks {{{
" ------------------------------------------------------------------------------

" UI {{{
" ------------------------------------------------------------------------------

" A slightly higher command-line window reduces
" the chance of "window jumping" if more than one
" line of text is displayed.
set cmdheight=2
set cmdwinheight=3
set nomore

" Always show status line.
set laststatus=2

" Show open tabs. Always.
set showtabline=2

" Display an incomplete command in the
" lower right corner of the Vim window
set showcmd

" Pop-up menu's line height
set pumheight=20

" Minimum help window height
set helpheight=12

" Completion preview height
set previewheight=8

" Window title
set title
set titlelen=95
set titlestring=%{x2a#TitleString#build()}

" I hate line numbers
set nonumber
set norelativenumber

" ------------------------------------------------------------------------------ }}}

" Stop highlighting lines midway
" if they're too long
set synmaxcol=1200
set colorcolumn=121

" prefer a slight higher line height
set linespace=2

" Highlight the current line
set cursorline

" Show matching brackets.
set showmatch
set matchpairs=(:),[:],{:}

" Match multibyte pairs if Vim supports it.
"   https://github.com/lilydjwg/dotvim/commit/880fc3b
try
  set matchpairs+=《:》,〈:〉,「:」,『:』,‘:’,“:”
catch /^Vim\%((\a\+)\)\=:E474/
endtry

set list
set listchars=tab:\⋮\ ,extends:…,precedes:…,trail:·,nbsp:⦸
set fillchars=vert:│,fold:-,diff:⣿

let &showbreak = '↳  '
set ambiwidth=single

" Whitespace {{{
" ------------------------------------------------------------------------------

set tabstop=2
set shiftwidth=2
set softtabstop=2
set shiftround
set expandtab
set autoindent           " carry over indenting from previous line
set copyindent           " make autoindent use the same characters to indent
set breakindent
set smartindent
set smarttab

" ------------------------------------------------------------------------------ }}}

" Color scheme
set background=dark

" ------------------------------------------------------------------------------ }}}

" Completion {{{
" ------------------------------------------------------------------------------

set tags+=./tags,./.git/tags
set dictionary=/usr/share/dict/words

" Show more information while completing tags.
set showfulltag

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

" Timeouts {{{
" ------------------------------------------------------------------------------

set timeout
set timeoutlen=1000
set ttimeout
set ttimeoutlen=50
let g:default_timeoutlen = &timeoutlen
let g:default_ttimeoutlen = &ttimeoutlen

" Time of inactivity to trigger CursorHold
set updatetime=1000

" ------------------------------------------------------------------------------ }}}

" Search {{{
" ------------------------------------------------------------------------------

set hlsearch
set ignorecase
set smartcase
set incsearch
set gdefault

if executable('rg')
  set grepprg=rg\ --smart-case\ --vimgrep
  set grepformat=%f:%l:%c:%m
  cnoreabbrev <expr> rg grep
elseif executable('ag')
  set grepprg=ag\ --smart-case\ --vimgrep
  set grepformat=%f:%l:%c:%m
  cnoreabbrev <expr> ag grep
endif

" ------------------------------------------------------------------------------ }}}

" Movements {{{
" ------------------------------------------------------------------------------

" Make j/k respect the columns
set nostartofline

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

" Allow backspace beyond insertion point
set backspace=indent,eol,start

" Enable to select past the end of line in
" blockwise visual mode
set virtualedit=block

" Do not fucking move the cursor for no
" fucking reason!!!
set whichwrap=

" ------------------------------------------------------------------------------ }}}

" Formatting {{{
" ------------------------------------------------------------------------------

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

" Only insert single space after a '.',
" '?' and '!' with a join command.
set nojoinspaces

set textwidth=121

" ------------------------------------------------------------------------------ }}}

" Short message settings ('shortmess') {{{
" ------------------------------------------------------------------------------

set shortmess=
set shortmess+=a  " Use short version of stuff (Same as filmnrwx)
set shortmess+=tT " Truncate long messages in the middle
set shortmess+=I  " Skip the intro
set shortmess+=oO " Overwrite subsequent messages
set shortmess+=W  " Don't give "written" or "[w]" when writing a file
set shortmess+=c  " Shut off completion messages

" ------------------------------------------------------------------------------ }}}

" Folding {{{
" ------------------------------------------------------------------------------

" Use markers for folds
set foldmethod=marker
set foldmarker={{{,}}}

" Size of the fold column
set foldcolumn=0

" Start will all folds open
set foldlevelstart=99

" Better fold text
set foldtext=AwesomeFoldText#foldtext()

" ------------------------------------------------------------------------------ }}}

" Swaps, backups, and undos {{{
" ------------------------------------------------------------------------------

set backup
set writebackup

" Keep backups with a .bak extension
set backupext=.bak

if empty($SUDO_USER) || $USER ==# $SUDO_USER
  set noswapfile
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

" Sessions {{{
" ------------------------------------------------------------------------------

" :h viminfo
set viminfo=!,'300,<50,s10,h

" Don't save terminal windows in sessions
set sessionoptions-=terminal

" Don't save help pages in sessions
set sessionoptions-=help

" Don't save hidden buffers -- only save the visible ones.
set sessionoptions-=buffers

" ------------------------------------------------------------------------------ }}}

" Diff {{{
" ------------------------------------------------------------------------------

" Ignore changes in amount of white space
set diffopt+=iwhite

" Diff in vertical mode
set diffopt+=vertical

if has('patch-8.1.0360')
  " Use the patience diff algorithm when creating a diff
  set diffopt+=internal,algorithm:patience
endif

" ------------------------------------------------------------------------------ }}}

" Mouse {{{
" ------------------------------------------------------------------------------

" Use the mouse only in normal mode and for hit-enter and more-prompt prompts
set mouse=nr

" Hide the mouse when typing
set mousehide

" Disable the right click
set mousemodel=

" ------------------------------------------------------------------------------ }}}

" ------------------------------------------------------------------------------ }}}

" Plugins {{{
" ------------------------------------------------------------------------------

let g:plug_threads = 16
let g:plug_retries = 3
let g:plug_timeout = 180
let g:plug_shallow = 1

call plug#begin('~/.vim/plugged')

" Base16 for Vim (colorsheme)
Plug 'chriskempson/base16-vim'

" FileType plugins {{{
" ------------------------------------------------------------------------------

" Context filetype library for Vim script
Plug 'Shougo/context_filetype.vim'

" Vim {{{
" ------------------------------------------------------------------------------

" Better VimL syntax highlighting
Plug 'vim-jp/syntax-vim-ex'

" A Vim plugin for Vim plugins
Plug 'tpope/vim-scriptease'

" Better completion for Vim builtins
Plug 'fcpg/vim-complimentary', { 'for': 'vim' }

" Jump to the definition of variables or functions in VimL code.
Plug 'mhinz/vim-lookup', { 'for': 'vim' }

" Display vim version numbers in docs
Plug 'tweekmonster/helpful.vim', { 'for': 'vim' }

" Show syntax highlighting attributes of character under cursor.
Plug 'inkarkat/SyntaxAttr.vim', { 'on': 'ShowSyntax' }

" ------------------------------------------------------------------------------ }}}

" Syntax highlighting for AppleScript
Plug 'RobertAudi/applescript.vim'

" Apple Official swift vim plugin
Plug 'bumaociyuan/vim-swift'

" Vim runtime files for xcconfigs
Plug 'keith/xcconfig.vim'

" Vim syntax for TOML
Plug 'cespare/vim-toml', { 'for': 'toml' }

" Vim Syntax for Homebrew formulae
Plug 'xu-cheng/brew.vim'

" Vim support for editing fish scripts
Plug 'dag/vim-fish', { 'for': 'fish' }

" CSS {{{
" ------------------------------------------------------------------------------

" CSS3 syntax support
Plug 'hail2u/vim-css3-syntax'

" Vim syntax file for scss
Plug 'cakebaker/scss-syntax.vim'

" ------------------------------------------------------------------------------ }}}

" Read and browse info files in Vim
Plug 'HiPhish/info.vim', { 'for': 'info' }

" Vim filetype and tools support for Crystal language.
Plug 'rhysd/vim-crystal', { 'for': 'crystal' }

" Improved Lua 5.3 syntax and indentation support for Vim
Plug 'tbastos/vim-lua', { 'for': ['lua'] }

" Python syntax highlighting for Vim (enhanced version)
Plug 'vim-python/python-syntax', { 'for': 'python' }

" Support for Perl 5 in Vim
Plug 'vim-perl/vim-perl', { 'for': 'perl' }

" Vim configuration for Rust.
Plug 'rust-lang/rust.vim'

" Go development plugin for Vim
Plug 'fatih/vim-go', { 'for': 'go', 'do': ':GoUpdateBinaries' }

" SQL {{{
" ------------------------------------------------------------------------------

" Postgresql syntax
Plug 'exu/pgsql.vim', { 'for': ['sql', 'pgsql'] }

" A plugin for SQL formatter like gofmt
Plug 'b4b4r07/vim-sqlfmt'

" Syntax highlighting for SQL heredocs
Plug 'aliou/sql-heredoc.vim'

" ------------------------------------------------------------------------------ }}}

" HTML5 omnicomplete and syntax
Plug 'othree/html5.vim'

" Override vim syntax for yaml files (faster)
Plug 'stephpy/vim-yaml'

" A better JSON for Vim
Plug 'elzr/vim-json'

" Javascript {{{
" ------------------------------------------------------------------------------

" Vastly improved Javascript indentation and syntax support in Vim.
Plug 'pangloss/vim-javascript'

" Typescript syntax files for Vim
Plug 'leafgarland/typescript-vim'

" CoffeeScript support for vim
Plug 'kchmck/vim-coffee-script', { 'for': ['coffee', 'litcoffee'] }

" A vim plugin for highlighting and indenting JST/EJS syntax
Plug 'briancollins/vim-jst'

" Standalone JSDoc syntax for vim
Plug 'othree/jsdoc-syntax.vim'

" ------------------------------------------------------------------------------ }}}

" Mustache and Handlebars mode for vim
Plug 'mustache/vim-mustache-handlebars'

" Markdown {{{
" ------------------------------------------------------------------------------

" A vim 7.4+ plugin to generate table of contents for Markdown files.
Plug 'mzlogin/vim-markdown-toc', { 'for': 'markdown' }

" GitHub Flavored Markdown syntax highlight extension for Vim
Plug 'rhysd/vim-gfm-syntax', { 'for': 'markdown' }

" Open the current Markdown buffer in Marked.app
Plug 'itspriddle/vim-marked', { 'for': 'markdown' }

" ------------------------------------------------------------------------------ }}}

" Asciidoc syntax and configuration for Vim
Plug 'mjakl/vim-asciidoc', { 'for': 'asciidoc' }

" Vim syntax for log highlighting
Plug 'dzeban/vim-log-syntax'

" Vim syntax file & snippets for Docker's Dockerfile
Plug 'ekalinin/Dockerfile.vim'

" Improved nginx vim plugin (incl. syntax highlighting)
Plug 'chr4/nginx.vim'

" Git {{{
" ------------------------------------------------------------------------------

" Vim Git runtime files
Plug 'tpope/vim-git'

" Provides the branch name of the current git repository
Plug 'itchyny/vim-gitbranch'

" A Vim plugin which shows a git diff in the gutter (sign column) and stages/undoes hunks.
Plug 'airblade/vim-gitgutter'

" Weapon to fight against conflicts in Vim.
Plug 'rhysd/conflict-marker.vim'

" A Vim plugin for more pleasant editing on commit messages
Plug 'rhysd/committia.vim'

" ------------------------------------------------------------------------------ }}}

" Vim configuration files for Nix
"   http://nixos.org/nix
Plug 'LnL7/vim-nix', { 'for': 'nix' }

" Ruby {{{
" ------------------------------------------------------------------------------

" Vim/Ruby Configuration Files
Plug 'vim-ruby/vim-ruby'

" Ruby on Rails power tools
Plug 'tpope/vim-rails', { 'for': ['ruby', 'eruby'] }

" It's like rails.vim without the rails
Plug 'tpope/vim-rake'

" Lightweight support for Ruby's Bundler
Plug 'tpope/vim-bundler'

" Vim plugin for highliting code in ruby here document
Plug 'joker1007/vim-ruby-heredoc-syntax', { 'for': ['ruby'] }

" Better rspec syntax highlighting for Vim
Plug 'keith/rspec.vim'

" Ruby syntax extensions for highlighting YARD documentation.
Plug 'noprompt/vim-yardoc'

" The Vim RuboCop plugin runs RuboCop and displays the results in Vim
Plug 'ngmy/vim-rubocop', { 'on': ['RuboCop'] }

" ------------------------------------------------------------------------------ }}}

" Tmux {{{
" ------------------------------------------------------------------------------

" Vim plugin for tmux.conf
Plug 'tmux-plugins/vim-tmux'

" Vim plugin to interact with tmux
Plug 'benmills/vimux'

" Seamless navigation between tmux panes and vim splits
Plug 'christoomey/vim-tmux-navigator', has('gui_vimr') ? { 'on': [] } : {}

" ------------------------------------------------------------------------------ }}}

" ------------------------------------------------------------------------------ }}}

" A Plugin to show a diff, whenever recovering a buffer
Plug 'chrisbra/Recover.vim'

" Quoting/parenthesizing made simple
Plug 'tpope/vim-surround'

" Comment stuff out
Plug 'tpope/vim-commentary'

" Unicode character metadata
Plug 'tpope/vim-characterize'

" Wisely add "end" in ruby, endfunction/endif/more in vim script, etc
Plug 'tpope/vim-endwise'

" Ghetto HTML/XML mappings
Plug 'tpope/vim-ragtag'

" Granular project configuration
Plug 'tpope/vim-projectionist'

" Set the 'path' option for miscellaneous file types
Plug 'tpope/vim-apathy'

" Continuously updated session files
Plug 'tpope/vim-obsession'

" Enable repeating supported plugin maps with "."
Plug 'tpope/vim-repeat'

" Create repeat.vim mappings with one simple "Repeatable" command
Plug 'kreskij/Repeatable.vim', { 'on': 'Repeatable' }

" The ultimate snippet solution for Vim
Plug 'SirVer/ultisnips'

" Completion {{{
" ------------------------------------------------------------------------------

" Async completion framework made ease.
Plug 'maralla/completor.vim'

" Include completion framework
Plug 'Shougo/neoinclude.vim'

" The vim source
Plug 'Shougo/neco-vim'

" neco-vim completion support for completor.vim
Plug 'kyouryuukunn/completor-necovim'

" omnicompletion via zsh's completion engine
Plug 'Valodim/vim-zsh-completion'

" Complete whole lines from any partial therein
Plug 'dahu/vim-foist'

" ------------------------------------------------------------------------------ }}}

" File management and manipulation {{{
" ------------------------------------------------------------------------------

" CtrlP {{{
" ------------------------------------------------------------------------------

" Fuzzy file, buffer, mru, tag, etc finder.
Plug 'ctrlpvim/ctrlp.vim'

" Fast vim CtrlP matcher based on python
Plug 'FelikZ/ctrlp-py-matcher'

" Easily open locally modified files in your git-versioned projects.
Plug 'jasoncodes/ctrlp-modified.vim'

" CtrlP extension for vim help keywords.
Plug 'zeero/vim-ctrlp-help', { 'on': 'CtrlPHelp' }

" ------------------------------------------------------------------------------ }}}

" Plugin for vim to enabling opening a file in a given line
Plug 'bogado/file-line'

" Helpers for UNIX
" Provides commands (among others):
"   :Delete
"   :Rename
"   :Chmod
Plug 'tpope/vim-eunuch'

" Automatically create missing directories when saving a (new) file
Plug 'haya14busa/vim-auto-mkdir'

" NERDTree {{{
" ------------------------------------------------------------------------------

" File system explorer
Plug 'scrooloose/nerdtree', { 'on': ['NERDTree', 'NERDTreeToggle', 'NERDTreeFocus', 'NERDTreeFind'] }

" A plugin of NERDTree showing git status
Plug 'Xuyuanp/nerdtree-git-plugin'

" ------------------------------------------------------------------------------ }}}

" ------------------------------------------------------------------------------ }}}

" Distributes available space among vertical splits, and plays nice with NERDTree.
Plug 'jordwalke/VimSplitBalancer'

" A light and configurable statusline/tabline plugin for Vim
Plug 'itchyny/lightline.vim'

" An ack.vim alternative mimics Ctrl-Shift-F on Sublime Text 2
Plug 'dyng/ctrlsf.vim'

" Incremental search improved
Plug 'haya14busa/is.vim'

" *-Improved
Plug 'haya14busa/vim-asterisk'

" Range, pattern and substitute preview for Vim
Plug 'markonm/traces.vim'

" Vim plugin, insert or delete brackets, parens, quotes in pair
Plug 'jiangmiao/auto-pairs'

" A Vim alignment plugin
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }

" Print documents in echo area.
Plug 'Shougo/echodoc.vim'

" The Vim FAQ
Plug 'chrisbra/vim_faq'

" Toggle, display and navigate marks
Plug 'kshenoy/vim-signature'

" Create temporary file for memo, testing, etc.
Plug 'RobertAudi/junkfile.vim', { 'on': ['JunkfileOpen', 'JunkfileVsplitOpen', 'JunkfileSplitOpen'] }

" Modern matchit and matchparen replacement
Plug 'andymass/vim-matchup'

" Make blockwise Visual mode more useful
Plug 'kana/vim-niceblock'

" Vimscript library of common functions
Plug 'inkarkat/vim-ingo-library'

" Enhanced jump and change list navigation commands.
Plug 'inkarkat/vim-EnhancedJumps'

" Repeat command extended to visual mode.
Plug 'vim-scripts/visualrepeat'

" Preserve missing EOL at the end of text files.
Plug 'vim-scripts/PreserveNoEOL'

" Make the yanked region apparent!
Plug 'machakann/vim-highlightedyank'

" A vim plugin to yank code.
Plug 'AaronLasseigne/yank-code', { 'on': ['YankCode', '<plug>YankCode'] }

" Navigation mode for Vim
Plug 'fcpg/vim-navmode'

" Zoom in/out of windows
Plug 'troydm/zoomwintab.vim', { 'on': ['ZoomWinTabIn', 'ZoomWinTabOut', 'ZoomWinTabToggle'] }

" Delete buffers and close files in Vim without closing your windows or messing up your layout.
Plug 'moll/vim-bbye', { 'on': ['Bdelete', 'Bwipeout'] }

" Land on window you chose like tmux's 'display-pane'
Plug 't9md/vim-choosewin', { 'on': ['<Plug>(choosewin)', 'ChooseWin', 'ChooseWinSwap', 'ChooseWinSwapStay'] }

" Intelligently reopen files at your last edit position in Vim.
Plug 'farmergreg/vim-lastplace'

" Vim plugin for direnv support
Plug 'direnv/direnv.vim'

" Enhanced terminal integration for Vim
" Includes:
"   - Cursor shape change in insert and replace mode
"   - Improved mouse support
"   - Focus reporting
"   - Bracketed Paste
Plug 'wincent/terminus'

" Pasting in Vim with indentation adjusted to destination context
Plug 'sickill/vim-pasta'

" A secure alternative to Vim modelines
Plug 'RobertAudi/securemodelines'

" Easy text manupilation for vim
Plug 't9md/vim-textmanip'

" Calculates the sum, average, min, and max for a visual region containing numbers.
Plug 'nixon/vim-vmath'

" Automated bullet lists.
Plug 'dkarter/bullets.vim'

" A vim plugin to accelerate up-down moving
Plug 'rhysd/accelerated-jk'

" A vim plugin that simplifies the transition between multiline and single-line code
Plug 'AndrewRadev/splitjoin.vim'

" A simple Vim plugin to switch segments of text with predefined replacements
Plug 'AndrewRadev/switch.vim'

" Run your tests at the speed of thought
Plug 'janko-m/vim-test'

" Asynchronous linting and make framework for Neovim/Vim
Plug 'neomake/neomake'

" Preview colours in source code while editing
Plug 'ap/vim-css-color'

" Highlights terminal color code numbers (0-255)
Plug 'sunaku/vim-hicterm', { 'on': ['HiCterm', 'HiCtermFg', 'HiCtermBg'] }

" dircolors in your vidir session
Plug 'trapd00r/vim-syntax-vidir-ls'

" Better whitespace highlighting for Vim
Plug 'ntpeters/vim-better-whitespace'

" Quickly highlight <cword> or visually selected word
Plug 't9md/vim-quickhl'

" Better Diff options for Vim
Plug 'chrisbra/vim-diff-enhanced', has('patch-8.1.0360') ? { 'on': [] } : {}

" Highlight insecure SSL configuration in Vim
Plug 'chr4/sslsecure.vim'

" Stop Unicode trolls from messing with your code.
Plug 'vim-utils/vim-troll-stopper'

" Open URI with your favorite browser from your most favorite editor
Plug 'tyru/open-browser.vim'

" ANSI escape sequences concealed, but highlighted as specified (conceal)
Plug 'powerman/vim-plugin-AnsiEsc'

" Lord of the Registers displays a persistent view of your Vim :registers in a sidebar window.
Plug 'dahu/vim-lotr', { 'on': ['LOTROpen', 'LOTRClose', 'LOTRToggle', '<Plug>LOTRToggle'] }

" Open GitHub URL of current file, etc. from Vim editor
Plug 'tyru/open-browser-github.vim', { 'on': ['OpenGithubFile', 'OpenGithubIssue', 'OpenGithubPullReq', 'OpenGithubProject'] }

" Open fileformat.info page about character on current cursor / given character
Plug 'tyru/open-browser-unicode.vim', { 'on': ['OpenBrowserUnicode'] }

" View and grep man pages in vim
Plug 'vim-utils/vim-man'

" A Vim plugin for typing accented characters without remembering their pseudo versions.
Plug 'RobertAudi/vim-accent'

" Insert block quotes
Plug 'RobertAudi/BlockQuote.vim', { 'on': ['BlockQuote', 'BlockQuoteFile', 'BlockUnQuote'] }

" Create banners
Plug 'RobertAudi/bannerizor.vim'

" Initialize plugin system
call plug#end()

" ------------------------------------------------------------------------------ }}}

" Syntax {{{
" ------------------------------------------------------------------------------

highlight IncSearch cterm=NONE ctermfg=Black ctermbg=154 gui=NONE guifg=#000000 guibg=#c0cd38
highlight! link txtBold Identifier

" Set "TODO" & "FIXME" strings to be bold and standout as hell.
highlight Todo term=standout ctermfg=196 ctermbg=226 guifg=#ff4500 guibg=#eeee00

" ------------------------------------------------------------------------------ }}}

" Abbreviations {{{
" ------------------------------------------------------------------------------

" Easy shebang
iabbrev #! #!/usr/bin/env

" ------------------------------------------------------------------------------ }}}

" Commands {{{
" ------------------------------------------------------------------------------

call x2a#abolish#commands('e', 'E')
call x2a#abolish#commands('w', 'W')
call x2a#abolish#commands('q', 'Q')
call x2a#abolish#commands('wa', 'Wa', 'WA')
call x2a#abolish#commands('wq', 'Wq', 'WQ')
call x2a#abolish#commands('wqa', 'Wqa', 'WQa', 'WQA')
call x2a#abolish#commands('qa', 'Qa', 'QA')
call x2a#abolish#commands('tabc', 'Tabc')
call x2a#abolish#commands('tabnew', 'Tabnew', 'Tnew', 'TNew', 'tnew')

" Buffers {{{
" ------------------------------------------------------------------------------

command! -nargs=0 ReindentBuffer silent! call x2a#utils#helpers#Preserve('x2a#buffers#Reindent')
command! -nargs=0 YankBuffer silent! call x2a#utils#helpers#Preserve('x2a#buffers#Yank')

" Golden Ratio
command! -nargs=0 GoldenRatio execute 'vertical resize' &columns * 5 / 8

command! -bang -nargs=0 BufOnly silent! call x2a#buffers#BufOnly(<bang>0)
command! -bang -nargs=0 BufDeleteInactive silent! call x2a#buffers#BufDeleteInactive(<bang>0)
command! -bang -nargs=0 BufDeleteAll silent! call x2a#buffers#BufDeleteAll(<bang>0)

call x2a#abolish#commands('BufOnly',
      \ 'BOnly', 'BOnl', 'BOn', 'BO',
      \ 'Bonly', 'Bonl', 'Bon', 'Bo',
      \ 'bonly', 'bonl', 'bon', 'bo')
call x2a#abolish#commands('Bdelete',
      \ 'BDelete', 'BDel', 'BD')
call x2a#abolish#commands('BufDeleteInactive',
      \ 'BDin', 'BDi',
      \ 'Bdin', 'Bdi',
      \ 'bdin', 'bdi')
call x2a#abolish#commands('BufDeleteAll',
      \ 'BDall', 'BDal', 'BDa',
      \ 'Bdall', 'Bdal', 'Bda',
      \ 'bdall', 'bdal', 'bda')

" ------------------------------------------------------------------------------ }}}

" Files {{{
" ------------------------------------------------------------------------------

" Copy (to the system clipboard) the path to current file
command! -nargs=0 CopyFilePath call x2a#file#CopyFullPath()
command! -nargs=0 CopyFullFilePath call x2a#file#CopyFullPath()
command! -nargs=0 CopyRelativeFilePath call x2a#file#CopyRelativePath()
command! -nargs=0 CopyRelativeFilePathWithLineNumber call x2a#file#CopyRelativePathWithLineNumber()

" ------------------------------------------------------------------------------ }}}

" Help {{{
" ------------------------------------------------------------------------------

command! -bang -nargs=? -complete=help Help call x2a#help#alternate('<bang>', <f-args>)

call x2a#abolish#commands('Help', 'H')

" ------------------------------------------------------------------------------ }}}

" Drawing {{{
" ------------------------------------------------------------------------------

command! -range=% BoxIn call x2a#drawing#BoxIn()

" ------------------------------------------------------------------------------ }}}

" Filetype {{{
" ------------------------------------------------------------------------------

" Change the filetype of the current buffer
command! -bang -complete=filetype -nargs=? FT call x2a#filetypes#setFileType(<bang>0, <f-args>)
command! -nargs=0 ReloadFiletype call x2a#utils#ReloadFiletype()

" ------------------------------------------------------------------------------ }}}

" macOS {{{
" ------------------------------------------------------------------------------

if has('gui_mac') || has('gui_macvim') || has('mac')
  command! -nargs=0 RevealInFinder call x2a#macos#RevealInFinder(expand('%:p'))

  if executable('mate')
    command! -nargs=? -complete=file TextMate silent! call x2a#TextMate#Open(<f-args>)
  endif
endif

" ------------------------------------------------------------------------------ }}}

" Git {{{
" ------------------------------------------------------------------------------

command! -bang -range=0 -nargs=0 GitPermalink echo x2a#git#permalink(<bang>0, <line1>, <count>)
command! -bang -range=0 -nargs=0 GitBrowse call x2a#git#browse(<bang>0, <line1>, <count>)
command! -bang -range=0 -nargs=0 GitCopyPermalink call x2a#git#copy_permalink(<bang>0, <line1>, <count>)

" ------------------------------------------------------------------------------ }}}

command! -nargs=+ -complete=command Page call x2a#utils#page(<q-args>)
command! -nargs=0 NormalizeWhitespace call x2a#utils#helpers#Preserve('x2a#utils#UnfuckWhitespace')
command! -nargs=0 WhatSyntax call x2a#utils#WhatSyntax()

" Unfuck my screen
" Source: https://bitbucket.org/sjl/dotfiles/src/26d3b19a08938930b576cedb18bc6fca706be6c5/vim/vimrc#vimrc-443
command! -nargs=0 UnfuckScreen syntax sync fromstart | :redraw!

" ------------------------------------------------------------------------------ }}}

" Autocommands {{{
" ------------------------------------------------------------------------------

augroup RAVimAutocommands
  autocmd!

  " Disable all the fucking beeps, bells and flashes, ALL THE FUCKING TIME!
  autocmd VimEnter,GUIEnter * set visualbell t_vb=

  " Set "TODO" & "FIXME" strings to be bold and standout as hell.
  autocmd VimEnter,ColorScheme *
        \ highlight Todo
        \ term=standout
        \ ctermfg=196 ctermbg=226
        \ guifg=#ff4500 guibg=#eeee00

  " Update the 'scrolloff' according to the height of the window
  " Source: https://github.com/uplus/vimrc/blob/80b6dc96d08bf00ed59e545448ea031aee194230/autocmds.vim#L8
  autocmd VimEnter,WinEnter,VimResized * let &scrolloff = float2nr(winheight('') * 0.1)

  " Only show cursorline in the current
  " window and in normal mode.
  autocmd WinLeave * setlocal nocursorline
  autocmd WinEnter *
        \ if !exists('b:NERDTree')
        \ | setlocal cursorline |
        \ endif

  " More eager than 'autoread'.
  autocmd WinEnter * checktime

  " Update diff.
  autocmd InsertLeave * if &l:diff | diffupdate | endif

  " Don't track changes, keep .viminfo information or swap files for files in
  " temporary directories. This is because they're used as scratch spaces for
  " tools like sudoedit(8) and pass(1) and hence could present a security problem
  autocmd BufNewFile,BufReadPre   /tmp/*,$TMPDIR/*,$TMP/*,$TEMP/* setlocal viminfo=
  autocmd BufWritePre             /tmp/*,$TMPDIR/*,$TMP/*,$TEMP/* setlocal noundofile

  if empty($SUDO_USER) || $USER ==# $SUDO_USER
    autocmd BufNewFile,BufReadPre /tmp/*,$TMPDIR/*,$TMP/*,$TEMP/* setlocal noswapfile
  endif

  " Open new tabs at the end
  autocmd TabNew * tabmove

  " Set timeoutlen to 0 for help and man buffers only
  " The conditionnal is required because timeoutlen is
  " a global option (can't be set locally)
  autocmd BufEnter *
        \ if index(['help', 'man'], &filetype) >= 0
        \ | set timeoutlen=0 |
        \ else
        \ | let &timeoutlen = get(g:, 'default_timeoutlen', 1000) |
        \ endif

  " Back to normal mode when Vim loses focus
  autocmd FocusLost,TabLeave *
        \ if mode() !=# "c"
        \ | call feedkeys("\<C-\>\<C-n>", 'n') |
        \ endif
augroup END

" ------------------------------------------------------------------------------ }}}

" Maps {{{
" ------------------------------------------------------------------------------

let mapleader = ','

" Disabled keys {{{
" ------------------------------------------------------------------------------

" No Help, please
inoremap <F1> <Esc>
nnoremap <F1> <Esc>
vnoremap <F1> <Esc>

" Disable arrow keys
noremap  <Left>  <Nop>
noremap  <Right> <Nop>
noremap  <Up>    <Nop>
noremap  <Down>  <Nop>
inoremap <Left>  <Nop>
inoremap <Right> <Nop>
inoremap <Up>    <Nop>
inoremap <Down>  <Nop>

" Remap U to nothing, I hate U!
nnoremap U <Nop>

" Disable ZZ.
nnoremap ZZ  <Nop>

" ------------------------------------------------------------------------------ }}}

" Improvements and overrides {{{
" ------------------------------------------------------------------------------

" match 'Y' behavior with 'C' and 'D' : Y = yy -> y$
nmap Y y$

" move cursor to the end of selected area after yank
xmap gy y`>
xmap Y y`>
xmap y y`<

" Keep cursor position when pasting
nnoremap p p`[
nnoremap P P`]

" Get more information from ctrl-g:
nnoremap <C-g> 2<C-g>

" Alternate buffer
nnoremap <C-e> <C-^>

" Keep cursor joining lines
nnoremap J mzJ`z

" Universal opposite of J
nnoremap <silent> S :call x2a#breakhere#BreakHere()<CR>

" Stay in the center!!
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" Do not exit visual mode when shifting
vnoremap <silent> > >gv
vnoremap <silent> < <gv

" ------------------------------------------------------------------------------ }}}

" Movements {{{
" ------------------------------------------------------------------------------

" Movement through splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Movement through splits in visual
" mode (but not in select mode)
xnoremap <C-h> <C-w>h
xnoremap <C-j> <C-w>j
xnoremap <C-k> <C-w>k
xnoremap <C-l> <C-w>l

" Linewise movement should work on screen lines
nnoremap <expr>  $ x2a#movements#line#Dollar()
nnoremap <expr> g$ x2a#movements#line#gDollar()
vnoremap <expr>  $ x2a#movements#line#Dollar()
vnoremap <expr> g$ x2a#movements#line#gDollar()

nnoremap <expr>  0 x2a#movements#line#Zero()
nnoremap <expr> g0 x2a#movements#line#gZero()
vnoremap <expr>  0 x2a#movements#line#Zero()
vnoremap <expr> g0 x2a#movements#line#gZero()

nnoremap <expr>  ^ x2a#movements#line#Caret()
nnoremap <expr> g^ x2a#movements#line#gCaret()
vnoremap <expr>  ^ x2a#movements#line#Caret()
vnoremap <expr> g^ x2a#movements#line#gCaret()

nnoremap <expr>  k x2a#movements#line#Up()
nnoremap <expr> gk x2a#movements#line#gUp()
vnoremap <expr>  k x2a#movements#line#Up()
vnoremap <expr> gk x2a#movements#line#gUp()

nnoremap <expr>  j x2a#movements#line#Down()
nnoremap <expr> gj x2a#movements#line#gDown()
vnoremap <expr>  j x2a#movements#line#Down()
vnoremap <expr> gj x2a#movements#line#gDown()

" Remap H and L to beggining and end of
" the line (Smart Home/End)
nnoremap <expr> H x2a#movements#line#Home()
vnoremap <expr> H x2a#movements#line#Home()
noremap  <expr> L x2a#movements#line#End()
vnoremap <expr> L x2a#movements#line#vEnd()

" Position the cursor at the top (gzh), middle (gzm) or bottom (gzl) of the screen
nnoremap gzh H
nnoremap gzm M
nnoremap gzl L

" gi already moves to "last place you exited insert mode", so we'll map gI to
" something similar: move to last change
nnoremap gI `.i

" Stolen from: https://github.com/godlygeek/vim-files
"   https://github.com/godlygeek/vim-files/blob/26aafb044895f778710bbc507310f5598019fa96/.vimrc#L268-L274
"
" Make [[ and ]] work even if the { is not in the first column
nnoremap <silent> [[ :call search('^\S\@=.*{\s*$', 'besW')<CR>
nnoremap <silent> ]] :call search('^\S\@=.*{\s*$', 'esW')<CR>
onoremap <expr> [[ (search('^\S\@=.*{\s*$', 'ebsW') && (setpos("''", getpos('.')) <Bar><Bar> 1) ? "''" : "\<Esc>")
onoremap <expr> ]] (search('^\S\@=.*{\s*$', 'esW') && (setpos("''", getpos('.')) <Bar><Bar> 1) ? "''" : "\<Esc>")

" ------------------------------------------------------------------------------ }}}

" Folding {{{
" ------------------------------------------------------------------------------

" Open fold
nnoremap <expr> h x2a#folding#can_close_fold('.') ? 'zc' : 'h'

" Toggle fold
nnoremap <expr> <Space> x2a#folding#can_toggle_fold('.') ? 'za' : "\<Space>"

" ------------------------------------------------------------------------------ }}}

" Visual mode {{{
" ------------------------------------------------------------------------------

" In VISUAL mode:
"   v switches to VISUAL BLOCK mode
" In VISUAL BLOCK mode:
"   v switches to VISUAL mode
" In any VISUAL mode:
"   <C-v> goes back to NORMAL mode
vnoremap <expr> v mode() == "v" ? '<C-v>' : 'v'
vnoremap <C-v> <Esc>

" Select the contents of the current line,
" excluding indentation.
nnoremap vv ^vg_

" select last paste in visual mode
nnoremap <expr> gv '`[' . strpart(getregtype(), 0, 1) . '`]'

" ------------------------------------------------------------------------------ }}}

" Command mode {{{
" ------------------------------------------------------------------------------

cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-d> <Del>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-y> <C-r>+

if has('gui_running') && has('gui_macvim')
  cnoremap ∫ <S-Left>
  cnoremap ƒ <S-Right>
  cnoremap ∂ <S-Right><C-w>
elseif !has('gui_running')
  cmap <Esc>f <S-Right>
  cmap <Esc>b <S-Left>
  cmap <Esc>d <S-Right><C-w>
  cnoremap <nowait> <Esc> <C-c>
endif

" ------------------------------------------------------------------------------ }}}

" Remove search highlight and
" clear any message already displayed.
nnoremap <silent> <CR>       :nohlsearch<Bar>match<Bar>echo<CR>
nnoremap <silent> <Esc><Esc> :nohlsearch<Bar>match<Bar>echo<CR>

" Easier search
nnoremap <Leader>s :%s//<Left>
xnoremap <Leader>s :s//<Left>

" Same as */# but in a new split
nnoremap <C-w>*  <C-w>s*
nnoremap <C-w>#  <C-w>s#

" use c* to change current word. than can use . to repeat action
nnoremap c* *Ncgn

" Select, reindent or yank the entire file
nnoremap <silent> <Leader>a :call x2a#buffers#Select()<CR>
nnoremap <Leader>= :ReindentBuffer<CR>
nnoremap <Leader>y :YankBuffer<CR>

" Complete whole line
inoremap <C-l> <C-x><C-l>

" Matchit!
map <BS> %

" Uppercase/Lowercase word under the cursor.
nnoremap gU gUiw`]
nnoremap gu guiw`]

" Change the filetype of the current buffer
nnoremap <Leader>ff :FT<Space>

if !has('gui_running')
  " backgrounding in insert mode
  inoremap <C-z> <C-o>:stop<CR>
endif

" Next/Previous tab
nnoremap gt :<C-u>call x2a#tabs#TabForward(v:count1)<CR>
nnoremap gT :<C-u>call x2a#tabs#TabBaward(v:count1)<CR>

" Next/Previous buffer
nnoremap gb :bnext<CR>
nnoremap gB :bprevious<CR>

" Macros {{{
" ------------------------------------------------------------------------------

" Disable Ex mode
" Instead use Q to reapeat the last macro
nnoremap Q @@

" Repeats macro on every line
vnoremap @ :normal @

" Reapeat the last macro on every line
vnoremap Q  :normal @@<CR>
vnoremap @@ :normal @@<CR>

" ------------------------------------------------------------------------------ }}}

" Drawing {{{
" ------------------------------------------------------------------------------

nnoremap <silent> \-  :silent call x2a#drawing#Underline(x2a#drawing#delimiters.superdash)<CR>
nnoremap <silent> \_  :silent call x2a#drawing#Underline(x2a#drawing#delimiters.fat_underscore)<CR>
nnoremap <silent> \g- :silent call x2a#drawing#Line(x2a#drawing#delimiters.superdash)<CR>
nnoremap <silent> \g_ :silent call x2a#drawing#Line(x2a#drawing#delimiters.fat_underscore)<CR>
nnoremap <silent> \a_ :silent call x2a#drawing#AppendTrailer(x2a#drawing#delimiters.underscore)<CR>
nnoremap <silent> \a. :silent call x2a#drawing#AppendTrailer(x2a#drawing#delimiters.dot)<CR>
nnoremap <silent> \a? :call x2a#drawing#InputTrailer()<CR>
nnoremap <silent> \> :silent call x2a#drawing#RightJustify()<CR>

" In visual mode, \box draws a box around the highlighted text.
vnoremap <silent> ,box <Esc>:call x2a#drawing#BoxIn()<CR>gvlolo

inoremap <C-b>= <Esc>:call <SID>MakeSectionBox("=")<CR>
inoremap <C-b>- <Esc>:call <SID>MakeSectionBox("-")<CR>

" ------------------------------------------------------------------------------ }}}

" ------------------------------------------------------------------------------ }}}

" Modeline {{{
" vim: set foldmarker={{{,}}} foldlevel=0 foldmethod=marker : }}}
