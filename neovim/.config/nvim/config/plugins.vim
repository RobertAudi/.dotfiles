" Plugins {{{
" ------------------------------------------------------------------------------
"
" Install vim-plug if needed:
"
"     curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
"         https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" ------------------------------------------------------------------------------

let g:plug_threads = 16
let g:plug_retries = 3
let g:plug_timeout = 180
let g:plug_shallow = 1

call plug#begin('~/.local/share/nvim/plugged')

Plug 'junegunn/vim-plug'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neco-syntax'
Plug 'Shougo/neco-vim'
Plug 'Shougo/neoinclude.vim'
Plug 'zchee/deoplete-zsh'
Plug 'dahu/vim-foist'

Plug 't9md/vim-choosewin'
Plug 't9md/vim-textmanip'

Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-parenmatch'

Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-characterize'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-scriptease'

" Tabs, Buffers, Files
Plug 'scrooloose/nerdtree', { 'on': ['NERDTree', 'NERDTreeToggle', 'NERDTreeFocus', 'NERDTreeFind'] }
Plug 'troydm/zoomwintab.vim'
Plug 'moll/vim-bbye'
Plug 'dahu/tabby'
Plug 'AndrewRadev/bufferize.vim'
Plug 'RobertAudi/junkfile.vim'

" Movements
Plug 'rhysd/accelerated-jk'
Plug 'bkad/CamelCaseMotion'
Plug 'dietsche/vim-lastplace'
Plug 'Konfekt/vim-smartbraces'
Plug 'vim-utils/vim-vertical-move'
Plug 'kana/vim-niceblock'
Plug 'deris/vim-shot-f'
Plug 'fcpg/vim-navmode'
Plug 'vim-scripts/ingo-library'
Plug 'vim-scripts/CountJump'
Plug 'vim-scripts/help_movement'
Plug 'vim-scripts/visualrepeat'
Plug 'vim-scripts/EnhancedJumps'

" Searching
Plug 'haya14busa/vim-asterisk'
Plug 'markonm/traces.vim'
Plug 'dyng/ctrlsf.vim'

" Git
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'itchyny/vim-gitbranch'
Plug 'airblade/vim-gitgutter'
Plug 'rhysd/committia.vim'

" Tmux
Plug 'tmux-plugins/vim-tmux'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'christoomey/vim-tmux-navigator'
Plug 'benmills/vimux'

" Ruby
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-bundler'
Plug 'killphi/vim-ruby-refactoring', { 'branch': 'refactor' }

" Markdown
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'itspriddle/vim-marked', { 'for': 'markdown' }
Plug 'mzlogin/vim-markdown-toc', { 'for': 'markdown' }
Plug 'rhysd/vim-gfm-syntax', { 'for': 'markdown' }

" HTML, CSS, SCSS, JavaScript
Plug 'othree/html5.vim', { 'for': ['html', 'eruby'] }
Plug 'hail2u/vim-css3-syntax', { 'for': ['css', 'scss', 'html', 'eruby'] }
Plug 'cakebaker/scss-syntax.vim', { 'for': ['scss'] }
Plug 'ap/vim-css-color', { 'for': ['css', 'scss', 'html', 'eruby', 'javascript', 'json'] }
Plug 'othree/yajs.vim', { 'for': ['javascript', 'html', 'eruby'] }
Plug 'othree/es.next.syntax.vim', { 'for': ['javascript', 'html', 'eruby'] }
Plug 'briancollins/vim-jst', { 'for': ['javascript', 'html', 'eruby'] }
Plug 'kchmck/vim-coffee-script', { 'for': ['coffee'] }
Plug 'lukaszkorecki/CoffeeTags', { 'for': ['coffee'] }
Plug 'leafgarland/typescript-vim', { 'for': ['typescript'] }
Plug 'rhysd/npm-filetypes.vim'

" Other filetypes
Plug 'tbastos/vim-lua', { 'for': ['lua'] }
Plug 'rhysd/vim-crystal'
Plug 'stephpy/vim-yaml'
Plug 'elzr/vim-json'
Plug 'dag/vim-fish'
Plug 'chr4/nginx.vim'
Plug 'chr4/sslsecure.vim'
Plug 'dzeban/vim-log-syntax'
Plug 'fcpg/vim-weblogs'
Plug 'mjakl/vim-asciidoc'
Plug 'mustache/vim-mustache-handlebars'
Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'vim-scripts/applescript.vim'
Plug 'keith/swift.vim'
Plug 'keith/xcconfig.vim'
Plug 'xu-cheng/brew.vim'
Plug 'ekalinin/Dockerfile.vim'
Plug 'chrisbra/vim-sh-indent'
Plug 'chrisbra/vim-zsh'
Plug 'Clavelito/indent-awk.vim'
Plug 'Clavelito/indent-sh.vim'
Plug 'vim-jp/syntax-vim-ex'
Plug 'noprompt/vim-yardoc'
Plug 'vim-utils/vim-man'
Plug 'Shougo/context_filetype.vim'
Plug 'aliou/sql-heredoc.vim'
Plug 'b4b4r07/vim-sqlfmt'

" Help
Plug 'Shougo/echodoc.vim'
Plug 'chrisbra/vim_faq'
Plug 'tweekmonster/helpful.vim'

" Utils
Plug 'haya14busa/vim-auto-mkdir'
Plug 'bogado/file-line'
Plug 'jszakmeister/vim-togglecursor'
Plug 'machakann/vim-highlightedyank'
Plug 'ciaranm/securemodelines'
Plug 'jsfaint/purge_undodir.vim'
Plug 'chrisbra/Recover.vim'
Plug 'critiqjo/husk-x.vim'
Plug 'powerman/vim-plugin-AnsiEsc'
Plug 'vim-utils/vim-troll-stopper'
Plug 'ntpeters/vim-better-whitespace'
Plug 'will133/vim-dirdiff'
Plug 'janko-m/vim-test'
Plug 'tyru/open-browser.vim'

Plug 'SirVer/ultisnips'
Plug 'mattn/sonictemplate-vim'
Plug 'vim-scripts/loremipsum'
Plug 'chriskempson/base16-vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'RobertAudi/BlockQuote.vim'
Plug 'RobertAudi/bannerizor.vim'
Plug 'sk1418/blockit', { 'on': ['Block', 'BlockitVersion', '<Plug>BlockitVisual'] }
Plug 'dkarter/bullets.vim'
Plug 'KabbAmine/lazyList.vim'
Plug 'RobertAudi/vim-accent'
Plug 'kshenoy/vim-signature'
Plug 'dahu/vim-lotr'
Plug 'benjifisher/matchit.zip'
Plug 'vimtaku/hl_matchit.vim'
Plug 'gregsexton/MatchTag'
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
Plug 'godlygeek/tabular'
Plug 'jiangmiao/auto-pairs'
Plug 'sk1418/Join'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'AndrewRadev/switch.vim'
Plug 'vim-scripts/PreserveNoEOL'

call plug#end()

" ------------------------------------------------------------------------------ }}}
