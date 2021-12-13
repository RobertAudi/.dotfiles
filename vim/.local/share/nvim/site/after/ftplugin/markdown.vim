setlocal complete+=k/usr/share/dict/words
setlocal omnifunc=htmlcomplete#CompleteTags

" Word wrap without line breaks
setlocal wrap
setlocal linebreak
setlocal textwidth=0
setlocal wrapmargin=0
setlocal formatoptions-=t " Don't auto-wrap text using textwidth
setlocal formatoptions+=l " Don't format long lines automatically
setlocal spell

" Headings with ease!
nnoremap <buffer> \3    I###<Space><Esc>
nnoremap <buffer> \4   I####<Space><Esc>
nnoremap <buffer> \5  I#####<Space><Esc>
nnoremap <buffer> \6 I######<Space><Esc>

" ---
" Stolen from gabrielelana/vim-markdown
"   https://github.com/gabrielelana/vim-markdown/blob/08e0731ce2c0b541ea335c782c59bb2e870730d4/ftplugin/markdown.vim#L159-L160
" ---
noremap  <silent> <buffer> ][ <Nop>
noremap  <silent> <buffer> [] <Nop>
