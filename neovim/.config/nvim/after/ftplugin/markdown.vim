setlocal complete+=k/usr/share/dict/words
setlocal omnifunc=htmlcomplete#CompleteTags

" Headings with ease!
nnoremap <buffer> <LocalLeader>3    I###<Space><Esc>
nnoremap <buffer> <LocalLeader>4   I####<Space><Esc>
nnoremap <buffer> <LocalLeader>5  I#####<Space><Esc>
nnoremap <buffer> <LocalLeader>6 I######<Space><Esc>

" ---
" Stolen from gabrielelana/vim-markdown
"   https://github.com/gabrielelana/vim-markdown/blob/08e0731ce2c0b541ea335c782c59bb2e870730d4/ftplugin/markdown.vim#L155-L160
" ---
"
" Jumping around
noremap  <silent> <buffer> ]] :<C-u>call utils#JumpToMarkdownHeader(1, 0)<CR>
noremap  <silent> <buffer> [[ :<C-u>call utils#JumpToMarkdownHeader(0, 0)<CR>
vnoremap <silent> <buffer> ]] :<C-u>call utils#JumpToMarkdownHeader(1, 1)<CR>
vnoremap <silent> <buffer> [[ :<C-u>call utils#JumpToMarkdownHeader(0, 1)<CR>
noremap  <silent> <buffer> ][ <Nop>
noremap  <silent> <buffer> [] <Nop>
