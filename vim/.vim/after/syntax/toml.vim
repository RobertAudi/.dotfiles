" Credits: Wei Zhang (maralla)
" URL:     https://github.com/maralla/vim-toml-enhance
" Source:  https://github.com/maralla/vim-toml-enhance/blob/aad256fa2f3551afb8676a2ca387ef87bcf71dee/after/syntax/toml.vim#L1-L6

syntax match tomlLabel /^[^#]\{-}=/me=e-1 display

highlight tomlTable      cterm=bold ctermfg=01 guifg=#da4938
highlight tomlTableArray cterm=bold ctermfg=01 guifg=#CB4B16
highlight tomlLabel                 ctermfg=04 guifg=#7facca
highlight tomlString                ctermfg=02 guifg=#b3cb74
