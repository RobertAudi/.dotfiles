" Plugin: ultisnips
" Description: The ultimate snippet solution for Vim
" URL: https://github.com/SirVer/ultisnips

let g:UltiSnipsNoPythonWarning     = 1
let g:UltiSnipsSnippetDirectories  = [expand($XDG_DATA_HOME . '/nvim/site/UltiSnips')]
let g:UltiSnipsExpandTrigger       = '<C-j>'
let g:UltiSnipsListSnippets        = '<C-]>'
let g:UltiSnipsJumpForwardTrigger  = '<C-j>'
let g:UltiSnipsJumpBackwardTrigger = '<C-k>'
