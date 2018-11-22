" AndrewRadev/switch.vim
" ------------------------------------------------------------------------------
nmap <Space> :Switch<CR>

let g:switch_custom_definitions =
      \ [
      \    ['!=', '=='],
      \    ['show', 'hide'],
      \    ['top', 'bottom'],
      \    ['min', 'max']
      \ ]

let g:switch_filetype_definitions = {}

let g:switch_filetype_definitions.css =
      \ [
      \    ['padding', 'margin']
      \ ]

let g:switch_filetype_definitions.javascript =
      \ [
      \    ['addClass', 'removeClass']
      \ ]

let g:switch_filetype_definitions.vim =
      \ [
      \    ['g:', 'b:', 'l:', 's:'],
      \    ['map', 'nmap', 'imap', 'vmap', 'smap', 'xmap', 'cmap', 'omap'],
      \    ['noremap', 'nnoremap', 'inoremap', 'vnoremap', 'snoremap', 'xnoremap', 'cnoremap', 'onoremap'],
      \    ['unmap', 'nunmap', 'iunmap', 'vunmap', 'sunmap', 'xunmap', 'cunmap', 'ounmap'],
      \    ['<special>', '<silent>', '<buffer>', '<expr>'],
      \ ]

AutocmdFT css,scss let b:switch_custom_definitions = g:switch_filetype_definitions.css
AutocmdFT javascript let b:switch_custom_definitions = g:switch_filetype_definitions.javascript
AutocmdFT vim let b:switch_custom_definitions = g:switch_filetype_definitions.vim
