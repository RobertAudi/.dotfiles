" Default plugin
let g:markdown_syntax_conceal = 0
let g:markdown_fenced_languages = [
      \   'vim',
      \   'sh',
      \   'bash=sh',
      \   'zsh',
      \   'swift',
      \   'ruby',
      \   'python',
      \   'javascript',
      \   'js=javascript',
      \   'html',
      \ ]

" ------------------------------------------------------------------------------
" Plugin: vim-gfm-syntax
" Description: GitHub Flavored Markdown syntax highlight extension for Vim
" URL: https://github.com/rhysd/vim-gfm-syntax
" ------------------------------------------------------------------------------
let g:gfm_syntax_enable_always = 0
let g:gfm_syntax_highlight_emoji = 0
let g:gfm_syntax_enable_filetypes = ['markdown']
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" Plugin: vim-markdown-toc
" Description: A vim 7.4+ plugin to generate table of contents for Markdown files.
" URL: https://github.com/mzlogin/vim-markdown-toc
" ------------------------------------------------------------------------------
let g:vmt_auto_update_on_save = 0
let g:vmt_dont_insert_fence = 0
" ------------------------------------------------------------------------------
