" Plugin: LanguageClient-neovim
" Description: Language Server Protocol (LSP) support for vim and neovim.
" URL: autozimu/LanguageClient-neovim

let g:LanguageClient_autoStart = 1
let g:LanguageClient_autoStop = 1

let g:LanguageClient_serverCommands = {
      \   'sh':         ['bash-language-server', 'start'],
      \   'javascript': ['javascript-typescript-stdio'],
      \   'ruby':       ['solargraph', 'stdio'],
      \   'html':       ['html-languageserver',  '--stdio'],
      \   'css':        ['css-languageserver',   '--stdio'],
      \   'scss':       ['css-languageserver',   '--stdio'],
      \   'json':       ['json-language-server', '--stdio'],
      \   'yaml':       ['yaml-language-server', '--stdio'],
      \ }
