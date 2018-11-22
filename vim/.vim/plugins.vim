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

Plug 'Konfekt/vim-smartbraces'
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

Plug 'rhysd/committia.vim', { 'for': 'gitcommit' }

Plug 'dahu/vim-foist'
Plug 'dahu/vim-lotr'

" Better completion for Vim builtins
Plug 'fcpg/vim-complimentary'

Plug 'machakann/vim-highlightedyank'
Plug 'AaronLasseigne/yank-code'
Plug 'jsfaint/purge_undodir.vim'

Plug 'troydm/zoomwintab.vim'
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
Plug 'wesleyche/SrcExpl'

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
Plug 'victormours/ruby-memoize.vim'
Plug 'joker1007/vim-ruby-heredoc-syntax'
Plug 'mikepjb/vim-chruby'
Plug 'ngmy/vim-rubocop'
Plug 'lucerion/vim-i18n-rails', { 'for': ['ruby', 'eruby', 'haml', 'slim', 'javascript', 'coffee'] }
Plug 'janko-m/vim-test'
Plug 'aliou/sql-heredoc.vim'
Plug 'b4b4r07/vim-sqlfmt'

Plug 'mattn/sonictemplate-vim'
Plug 'sk1418/blockit'

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

Plug 'junegunn/vim-easy-align', { 'on': [ '<Plug>(EasyAlign)', 'EasyAlign' ] }
Plug 'ntpeters/vim-better-whitespace'

Plug 'jiangmiao/auto-pairs'
Plug 'SirVer/ultisnips'

Plug 'Shougo/context_filetype.vim'
Plug 'Shougo/echodoc.vim'
Plug 'chrisbra/vim_faq'
Plug 'fcpg/vim-complimentary'

Plug 'vim-utils/vim-man'
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
