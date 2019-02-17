" Disable pre-bundled plugins
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

if has('gui_running')
  set t_Co=16
else
  set t_Co=256
  set termencoding=utf-8
  set ttyfast
  set term=screen-256color
endif

filetype plugin indent on
syntax enable

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

if has('gui_macvim')
  let g:macvim_skip_cmd_opt_movement = 1
  let g:macvim_skip_colorscheme = 1
end

" Workaround for this deprecation warning:
"   DeprecationWarning: The imp module is deprecated in favour of importlib;
" https://github.com/SirVer/ultisnips/issues/996
if has('python3')
  silent! python3 1
endif

" Settings {{{
" ------------------------------------------------------------------------------

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

" ------------------------------------------------------------------------------ }}}

" Plugins {{{
" ------------------------------------------------------------------------------

let g:plug_threads = 16
let g:plug_retries = 3
let g:plug_timeout = 180
let g:plug_shallow = 1

call plug#begin('~/.vim/plugged')

Plug 'junegunn/vim-plug'

" FileType plugins {{{
" ------------------------------------------------------------------------------
Plug 'pangloss/vim-javascript'
Plug 'briancollins/vim-jst', { 'for': ['javascript', 'html', 'eruby'] }
Plug 'leafgarland/typescript-vim'
Plug 'kchmck/vim-coffee-script'

Plug 'elzr/vim-json'
Plug 'stephpy/vim-yaml'
Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'noprompt/vim-yardoc'
Plug 'othree/jsdoc-syntax.vim'

Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'fatih/vim-go'
Plug 'rust-lang/rust.vim'
Plug 'vim-perl/vim-perl', { 'for': 'perl' }
Plug 'vim-python/python-syntax', { 'for': 'python' }
Plug 'rhysd/vim-crystal'
Plug 'tbastos/vim-lua', { 'for': ['lua'] }
Plug 'exu/pgsql.vim'

Plug 'othree/html5.vim'
Plug 'tpope/vim-haml'
Plug 'mustache/vim-mustache-handlebars'

Plug 'hail2u/vim-css3-syntax'
Plug 'cakebaker/scss-syntax.vim'

Plug 'ekalinin/Dockerfile.vim'
Plug 'CH-DanReif/haproxy.vim'
Plug 'chr4/nginx.vim'
Plug 'chr4/sslsecure.vim'
Plug 'dzeban/vim-log-syntax'
Plug 'fcpg/vim-weblogs'

Plug 'vim-ruby/vim-ruby'
Plug 'keith/rspec.vim'

Plug 'vim-scripts/applescript.vim'
Plug 'keith/swift.vim'
Plug 'keith/xcconfig.vim'

Plug 'chrisbra/vim-sh-indent'

" Official Vim Runtime Files for Zsh
Plug 'chrisbra/vim-zsh', { 'for': 'zsh' }

Plug 'Clavelito/indent-awk.vim'
Plug 'Clavelito/indent-sh.vim'
Plug 'dag/vim-fish'
Plug 'ericpruitt/tmux.vim'
Plug 'tpope/vim-git'
Plug 'xu-cheng/brew.vim'
" ------------------------------------------------------------------------------ }}}

" Toggle, display and navigate marks
Plug 'kshenoy/vim-signature'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tommcdo/vim-fugitive-blame-ext'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-characterize'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-scriptease'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-apathy'
Plug 'tpope/vim-dotenv'
Plug 'tpope/vim-repeat'
Plug 'kreskij/Repeatable.vim', { 'on': 'Repeatable' }

Plug 'jordwalke/VimSplitBalancer'
Plug 'fcpg/vim-navmode'
Plug 'kana/vim-niceblock'
Plug 'andymass/vim-matchup'

Plug 'RobertAudi/vim-smartbraces'
Plug 'vim-scripts/loremipsum'
Plug 'Olical/vim-expand'

Plug 'lifepillar/vim-mucomplete'

Plug 'itchyny/vim-gitbranch'
Plug 'airblade/vim-gitgutter'
Plug 'rhysd/conflict-marker.vim'

Plug 'vim-scripts/ingo-library'
Plug 'vim-scripts/CountJump'
Plug 'vim-scripts/help_movement'
Plug 'vim-scripts/visualrepeat'
Plug 'vim-scripts/EnhancedJumps'

Plug 'vim-scripts/PreserveNoEOL'

Plug 'ctrlpvim/ctrlp.vim'
Plug 'FelikZ/ctrlp-py-matcher'
Plug 'jasoncodes/ctrlp-modified.vim'
Plug 'naquad/ctrlp-filetype'
Plug 'SpaceVim/vim-ctrlp-help'

Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

Plug 'rhysd/committia.vim', { 'for': 'gitcommit' }

Plug 'dahu/vim-foist'
Plug 'dahu/vim-lotr'

" Better completion for Vim builtins
Plug 'fcpg/vim-complimentary'

Plug 'machakann/vim-highlightedyank'
Plug 'AaronLasseigne/yank-code'
Plug 'jsfaint/purge_undodir.vim'

Plug 'troydm/zoomwintab.vim', { 'on': ['ZoomWinTabIn', 'ZoomWinTabOut', 'ZoomWinTabToggle'] }
Plug 'moll/vim-bbye'

Plug 'farmergreg/vim-lastplace'
Plug 'haya14busa/vim-auto-mkdir'
Plug 'direnv/direnv.vim'

Plug 'benmills/vimux'
Plug 'christoomey/vim-tmux-navigator', has('gui_running') ? { 'on': [] } : {}

" Enhanced terminal integration for Vim
" Includes:
"   - Cursor shape change in insert and replace mode
"   - Improved mouse support
"   - Focus reporting
"   - Bracketed Paste
Plug 'wincent/terminus'

" Pasting in Vim with indentation adjusted to destination context
Plug 'sickill/vim-pasta'

Plug 'haya14busa/vim-asterisk'
Plug 'markonm/traces.vim'
Plug 'ciaranm/securemodelines'

Plug 'tweekmonster/helpful.vim', { 'for': 'vim' }

" Show syntax highlighting attributes of character under cursor.
Plug 'inkarkat/SyntaxAttr.vim'

Plug 'scrooloose/nerdtree', { 'on': ['NERDTree', 'NERDTreeToggle', 'NERDTreeFocus', 'NERDTreeFind'] }
Plug 'Xuyuanp/nerdtree-git-plugin'

" Quickly highlight <cword> or visually selected word
Plug 't9md/vim-quickhl'

" Land on window you chose like tmux's 'display-pane'
Plug 't9md/vim-choosewin'
Plug 't9md/vim-textmanip'
Plug 'wesleyche/SrcExpl', { 'on': ['SrcExpl', 'SrcExplClose', 'SrcExplToggle'] }

" Base16 for Vim
Plug 'chriskempson/base16-vim'

Plug 'godlygeek/tabular'
Plug 'itspriddle/vim-marked', { 'for': 'markdown' }
Plug 'dkarter/bullets.vim'
Plug 'mzlogin/vim-markdown-toc', { 'for': 'markdown' }
Plug 'rhysd/vim-gfm-syntax', { 'for': 'markdown' }
Plug 'KabbAmine/lazyList.vim'
Plug 'unblevable/quick-scope'

Plug 'mjakl/vim-asciidoc'
Plug 'bkad/CamelCaseMotion'

Plug 'kana/vim-gf-user'
Plug 'sgur/vim-gf-autoload', { 'for': 'vim' }

Plug 'will133/vim-dirdiff'
Plug 'duggiefresh/vim-easydir'
Plug 'bogado/file-line'

" Plugin for opening selected content in https://carbon.now.sh.
Plug 'kristijanhusak/vim-carbon-now-sh', { 'on': 'CarbonNowSh' }

Plug 'itchyny/lightline.vim'
Plug 'dyng/ctrlsf.vim'
Plug 'rhysd/accelerated-jk'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'AndrewRadev/switch.vim'
Plug 'AndrewRadev/bufferize.vim'
Plug 'sk1418/Join'

" Better VimL syntax highlighting
Plug 'vim-jp/syntax-vim-ex'

" Jump to the definition of variables or functions in VimL code.
Plug 'mhinz/vim-lookup', { 'for': 'vim' }

Plug 'tpope/vim-rails', { 'for': ['ruby', 'eruby', 'haml', 'slim'] }
Plug 'tpope/vim-rake'
Plug 'tpope/vim-bundler'
Plug 'rlue/vim-fold-rspec'
Plug 'killphi/vim-ruby-refactoring', { 'branch': 'refactor' }
Plug 'joker1007/vim-ruby-heredoc-syntax'
Plug 'mikepjb/vim-chruby'
Plug 'ngmy/vim-rubocop', { 'on': ['RuboCop'] }
Plug 'lucerion/vim-i18n-rails', { 'for': ['ruby', 'eruby', 'haml', 'slim', 'javascript', 'coffee'] }
Plug 'janko-m/vim-test'
Plug 'aliou/sql-heredoc.vim'
Plug 'b4b4r07/vim-sqlfmt'

Plug 'mattn/sonictemplate-vim'
Plug 'sk1418/blockit', { 'on': ['Block', 'BlockitVersion', '<Plug>BlockitVisual'] }

" Calculates the sum, average, min, and max for a visual region containing numbers.
Plug 'nixon/vim-vmath'

Plug 'thinca/vim-ft-help_fold', { 'for': ['help'] }
Plug 'thinca/vim-ft-diff_fold', { 'for': ['diff'] }
Plug 'thinca/vim-ft-markdown_fold', { 'for': ['markdown'] }

Plug 'ap/vim-css-color'

" Highlights terminal color code numbers (0-255)
Plug 'sunaku/vim-hicterm', { 'on': ['HiCterm', 'HiCtermFg', 'HiCtermBg'] }

" Table of all 256 xterm colors with their RGB equivalents
Plug 'guns/xterm-color-table.vim'

" dircolors in your vidir session
Plug 'trapd00r/vim-syntax-vidir-ls'

Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
Plug 'ntpeters/vim-better-whitespace'

Plug 'jiangmiao/auto-pairs'
Plug 'SirVer/ultisnips'

Plug 'Shougo/context_filetype.vim'
Plug 'Shougo/echodoc.vim'
Plug 'chrisbra/vim_faq'

Plug 'vim-utils/vim-man', { 'on': ['Man', 'Sman', 'Vman', 'Tman', 'Mangrep', '<Plug>(Man)', '<Plug>(Sman)', '<Plug>(Vman)', '<Plug>(Tman)'] }
Plug 'vim-utils/vim-troll-stopper'
Plug 'vim-utils/vim-vertical-move'
Plug 'tyru/open-browser.vim'
Plug 'tyru/open-browser-github.vim', { 'on': ['OpenGithubFile', 'OpenGithubIssue', 'OpenGithubPullReq', 'OpenGithubProject'] }
Plug 'tyru/open-browser-unicode.vim', { 'on': ['OpenBrowserUnicode'] }
Plug 'tyru/capture.vim', { 'on': ['Capture'] }
Plug 'chrisbra/Recover.vim'
Plug 'chrisbra/vim-diff-enhanced', has('patch-8.1.0360') ? { 'on': [] } : {}

Plug 'powerman/vim-plugin-AnsiEsc'

Plug 'RobertAudi/junkfile.vim'
Plug 'RobertAudi/vim-accent'
Plug 'RobertAudi/BlockQuote.vim'
Plug 'RobertAudi/bannerizor.vim'

call plug#end()

" ------------------------------------------------------------------------------ }}}

" Syntax {{{
" ------------------------------------------------------------------------------

highlight IncSearch cterm=NONE ctermfg=Black ctermbg=154 gui=NONE guifg=#000000 guibg=#c0cd38
highlight! link txtBold Identifier

" Set "TODO" & "FIXME" strings to be bold and standout as hell.
highlight Todo term=standout ctermfg=196 ctermbg=226 guifg=#ff4500 guibg=#eeee00

" Show deleted plugins after a :PlugClean[!]
highlight! link plugDeleted plugName

" ------------------------------------------------------------------------------ }}}

" Abbreviations {{{
" ------------------------------------------------------------------------------

" Easy shebang
iabbrev #! #!/usr/bin/env

" ------------------------------------------------------------------------------ }}}

" Commands {{{
" ------------------------------------------------------------------------------

" Save and make executable
command! -bang -nargs=? WX silent write<bang> <args> | Chmod +x

" Change the filetype of the current buffer
command! -complete=filetype -nargs=? FT call x2a#utils#setFileType(<f-args>)

if has("gui_mac") || has("gui_macvim") || has("mac")
  command! -nargs=0 RevealInFinder call x2a#macos#RevealInFinder(expand('%:p'))
  command! -nargs=? -complete=file TextMate silent! call x2a#TextMate#Open(<f-args>)
endif

call x2a#abolish#commands('e', 'E')
call x2a#abolish#commands('w', 'W')
call x2a#abolish#commands('q', 'Q')
call x2a#abolish#commands('wa', 'Wa', 'WA')
call x2a#abolish#commands('wq', 'Wq', 'WQ')
call x2a#abolish#commands('wqa', 'Wqa', 'WQa', 'WQA')
call x2a#abolish#commands('qa', 'Qa', 'QA')
call x2a#abolish#commands('tabc', 'Tabc')
call x2a#abolish#commands('tabnew', 'Tabnew', 'Tnew', 'TNew', 'tnew')

" Buffers
" ------------------------------------------------------------------------------
command! -nargs=0 ReindentBuffer silent! call x2a#utils#helpers#Preserve('x2a#buffers#Reindent')
command! -nargs=0 YankBuffer silent! call x2a#utils#helpers#Preserve('x2a#buffers#Yank')

" Copy (to the system clipboard) the path to current file
command! -nargs=0 CopyFilePath call x2a#buffers#CopyFullPath()
command! -nargs=0 CopyFullFilePath call x2a#buffers#CopyFullPath()
command! -nargs=0 CopyRelativeFilePath call x2a#buffers#CopyRelativePath()
command! -nargs=0 CopyRelativeFilePathWithLineNumber call x2a#buffers#CopyRelativePathWithLineNumber()

" Golden Ratio
command! -nargs=0 GoldenRatio execute 'vertical resize' &columns * 5 / 8

command! -bang -nargs=0 BufOnly silent! call x2a#buffers#BufOnly(<bang>0)
command! -bang -nargs=0 BufDeleteInactive silent! call x2a#buffers#BufDeleteInactive(<bang>0)
command! -bang -nargs=0 BufDeleteAll silent! call x2a#buffers#BufDeleteAll(<bang>0)

" Command ':Bclose' executes ':bd' to delete buffer in current window.
" The window will show the alternate buffer (Ctrl-^) if it exists,
" or the previous buffer (:bp), or a blank buffer if no previous.
" Command ':Bclose!' is the same, but executes ':bd!' (discard changes).
" An optional argument can specify which buffer to close (name or number).
command! -bang -complete=buffer -nargs=? Bclose call x2a#buffers#Bclose('<bang>', '<args>')

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

" Drawing
" ------------------------------------------------------------------------------
command! -range=% BoxIn call x2a#drawing#BoxIn()

" Help
" ------------------------------------------------------------------------------
command! -bang -nargs=? -complete=help Help call x2a#hhhhelp#alternate('<bang>', <f-args>)

call x2a#abolish#commands('Help', 'H')

" Misc
" ------------------------------------------------------------------------------
command! -nargs=0 ReloadFiletype call x2a#utils#ReloadFiletype()
command! -nargs=+ -complete=command Page call x2a#utils#page(<q-args>)
command! -nargs=0 -range Append <line1>,<line2>call x2a#utils#Append()
command! -nargs=0 NormalizeWhitespace call x2a#utils#helpers#Preserve('x2a#utils#UnfuckWhitespace')
command! -nargs=0 WhatSyntax call x2a#utils#WhatSyntax()

" Unfuck my screen
" Source: https://bitbucket.org/sjl/dotfiles/src/26d3b19a08938930b576cedb18bc6fca706be6c5/vim/vimrc#vimrc-443
command! -nargs=0 UnfuckScreen syntax sync fromstart | :redraw!

if executable('lr')
  " :Lr <lr-args> to browse lr(1) results in a new window,
  "               press return to open file in new window.
  command! -nargs=* -complete=file Lr new
        \ | setlocal buftype=nofile noswapfile
        \ | silent execute "0r!lr -Q " <q-args>
        \ | 0 | resize | map <buffer> <C-M> $<C-W>F<C-W>_
endif

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
  autocmd BufNew *
        \ if &showtabline && winnr('$') == 1
        \ | tabmove |
        \ endif

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

" Mappings
" ------------------------------------------------------------------------------

" Map leaders
let mapleader        = ','
let g:mapleader      = ','

" No Help, please
inoremap <F1> <Esc>
nnoremap <F1> <Esc>
vnoremap <F1> <Esc>

" Command Mode maps
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

" Disable Ex mode
" Instead use Q to reapeat the last macro
nnoremap Q @@

" . in visual mode
vnoremap . :normal .<CR>

" Uppercase/Lowercase word under the cursor.
nnoremap gU gUiw`]
nnoremap gu guiw`]

" Repeats macro on every line
vnoremap @ :normal @

" Reapeat the last macro on every line
vnoremap Q :normal @@<CR>

" Get more information from ctrl-g:
nnoremap <C-g> 2<C-g>

noremap  <Left>  <Nop>
noremap  <Right> <Nop>
noremap  <Up>    <Nop>
noremap  <Down>  <Nop>
inoremap <Left>  <Nop>
inoremap <Right> <Nop>
inoremap <Up>    <Nop>
inoremap <Down>  <Nop>

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

" Open closed fold on the current line
nnoremap <expr> h foldclosed('.') > -1 ? 'zo' : 'h'
nnoremap <expr> l foldclosed('.') > -1 ? 'zo' : 'l'

" see Vertical Text Shifting functions.vim
nnoremap <S-Left>  <<
nnoremap <S-Right> >>
inoremap <S-Left>  <C-d>
inoremap <S-Right> <C-t>

" Don't make a # force column zero.
inoremap # x<BS>#

" Add new line below without leaving insert mode
inoremap <S-Enter> <C-o>o

" Do not exit visual mode when shifting
vnoremap <silent> > >gv
vnoremap <silent> < <gv

" Stolen from: https://github.com/godlygeek/vim-files
"   https://github.com/godlygeek/vim-files/blob/26aafb044895f778710bbc507310f5598019fa96/.vimrc#L268-L274
"
" Make [[ and ]] work even if the { is not in the first column
nnoremap <silent> [[ :call search('^\S\@=.*{\s*$', 'besW')<CR>
nnoremap <silent> ]] :call search('^\S\@=.*{\s*$', 'esW')<CR>
onoremap <expr> [[ (search('^\S\@=.*{\s*$', 'ebsW') && (setpos("''", getpos('.')) <Bar><Bar> 1) ? "''" : "\<Esc>")
onoremap <expr> ]] (search('^\S\@=.*{\s*$', 'esW') && (setpos("''", getpos('.')) <Bar><Bar> 1) ? "''" : "\<Esc>")

" In VISUAL mode:
"   v switches to VISUAL BLOCK mode
" In VISUAL BLOCK mode:
"   v switches to VISUAL mode
" In any VISUAL mode:
"   <C-v> goes back to NORMAL mode
vnoremap <expr> v mode() == "v" ? '<C-v>' : 'v'
vnoremap <C-v> <Esc>

" Select, reindent or yank the entire file
nnoremap <silent> <Leader>a :call x2a#buffers#Select()<CR>
nnoremap <Leader>= :ReindentBuffer<CR>
nnoremap <Leader>y :YankBuffer<CR>

" match 'Y' behavior with 'C' and 'D' : Y = yy -> y$
nmap Y y$

" move cursor to the end of selected area after yank
xmap gy y`>
xmap Y y`>
xmap y y`<

" Keep cursor position when pasting
nnoremap p p`[
nnoremap P P`]

" Remap U to nothing, I hate U!
nnoremap U <Nop>

" Disable ZZ.
nnoremap ZZ  <Nop>

" Stay in the center!!
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" Keep cursor joining lines
nnoremap J mzJ`z

" Movement through splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Next/Previous tab
nnoremap gt :tabnext<CR>
nnoremap gT :tabprevious<CR>

" Next/Previous buffer
nnoremap gb :bnext<CR>
nnoremap gB :bprevious<CR>

" Alternate buffer
nnoremap <C-e> <C-^>

" Change the filetype of the current buffer
nnoremap <Leader>ff :FT<Space>

" Browse Help
nnoremap <Leader>hh :Help<Space>

" use c* to change current word. than can use . to repeat action
nnoremap c* *Ncgn

" Easier search
nnoremap <Leader>s :%s//<Left>
xnoremap <Leader>s :s//<Left>
xnoremap s :s//<Left>
nnoremap <Leader>S :%s/<C-r>=expand("<cword>")<CR>//<Left>

" Use aesthetic middle of screen for "zz"
nnoremap zz :call x2a#movements#window#CenterCursorAesthetically()<CR>

" Universal opposite of J
nnoremap <silent> S :call x2a#breakhere#BreakHere()<CR>

" Increment/Decrement numbers in visual selection
xnoremap <silent> <C-a> :<C-u>let vcount = v:count1 <Bar> '<,'>s/\%V\d\+/\=submatch(0) + vcount<CR>gv
xnoremap <silent> <C-x> :<C-u>let vcount = v:count1 <Bar> '<,'>s/\%V\d\+/\=submatch(0) - vcount<CR>gv

" Sequentially increment numbers in visual selection
" Starting with the first number
xnoremap <silent> <Leader>i :<C-u>let vcount = v:count<CR>gv:call x2a#incr#Incr(vcount)<CR>

" Resize splits automatically
nnoremap <silent> <C-w>r :call x2a#utils#Splitresize()<CR>

" Same as */# but in a new split
nnoremap <C-w>*  <C-w>s*
nnoremap <C-w>#  <C-w>s#

" Remove search highlight and
" clear any message already displayed.
nnoremap <silent> <CR>       :nohlsearch<Bar>:match<Bar>:echo<CR>
nnoremap <silent> <Esc><Esc> :nohlsearch<Bar>:match<Bar>:echo<CR>

" Select the contents of the current line,
" excluding indentation.
nnoremap vv ^vg_

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

" Complete whole line
inoremap <C-l> <C-x><C-l>

" gi already moves to "last place you exited insert mode", so we'll map gI to
" something similar: move to last change
nnoremap gI `.i

" sort
vnoremap \s :sort u<CR>

" Matchit!
map <BS> %

" select last paste in visual mode
nnoremap <expr> gv '`[' . strpart(getregtype(), 0, 1) . '`]'

" Insert current date. Choice of format in dropdown
inoremap <silent> <C-g><C-t> <C-R>=repeat(complete(col('.'),map(["%Y-%m-%d %H:%M:%S","%a, %d %b %Y %H:%M:%S %z","%Y %b %d","%d-%b-%y","%a %b %d %T %Z %Y"],'strftime(v:val)')+[localtime()]),0)<CR>

" Drawing
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

if !has("gui_running")
  " backgrounding in insert mode
  inoremap <C-z> <C-o>:stop<CR>
endif

" ------------------------------------------------------------------------------ }}}

" Modeline {{{
" vim: set foldmarker={{{,}}} foldlevel=0 foldmethod=marker : }}}
