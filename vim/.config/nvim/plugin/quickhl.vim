" Plugin: t9md/vim-quickhl
" Description: Quickly highlight <cword> or visually selected word
" URL: https://github.com/t9md/vim-quickhl

nmap \m <Plug>(quickhl-manual-this)
xmap \m <Plug>(quickhl-manual-this)
nmap \M <Plug>(quickhl-manual-reset)
xmap \M <Plug>(quickhl-manual-reset)

let g:quickhl_manual_colors =
      \ [
      \   'cterm=bold ctermfg=16 ctermbg=214 gui=bold guifg=#000000 guibg=#ffa724',
      \   'cterm=bold ctermfg=16 ctermbg=154 gui=bold guifg=#000000 guibg=#aeee00',
      \   'cterm=bold ctermfg=16 ctermbg=121 gui=bold guifg=#000000 guibg=#8cffba',
      \   'cterm=bold ctermfg=7  ctermbg=16  gui=bold guifg=#ffffff guibg=#4c8f2f',
      \   'cterm=bold ctermfg=16 ctermbg=137 gui=bold guifg=#000000 guibg=#b88853',
      \   'cterm=bold ctermfg=7  ctermbg=21  gui=bold guifg=#ffffff guibg=#d4a00d',
      \   'cterm=bold ctermfg=16 ctermbg=211 gui=bold guifg=#000000 guibg=#ff9eb8',
      \   'cterm=bold ctermfg=7  ctermbg=45  gui=bold guifg=#ffffff guibg=#5b3674',
      \   'cterm=bold ctermfg=7  ctermbg=195 gui=bold guifg=#ffffff guibg=#ff2c4b',
      \   'cterm=bold ctermfg=7  ctermbg=50  gui=bold guifg=#ffffff guibg=#1060a0',
      \   'cterm=bold ctermfg=7  ctermbg=22  gui=bold guifg=#ffffff guibg=#06287e',
      \   'cterm=bold ctermfg=16 ctermbg=56  gui=bold guifg=#000000 guibg=#a0b0c0',
      \   'cterm=bold ctermfg=16 ctermbg=153 gui=bold guifg=#ffffff guibg=#0a7383'
      \ ]
