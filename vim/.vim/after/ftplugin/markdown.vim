setlocal complete+=k/usr/share/dict/words
setlocal omnifunc=htmlcomplete#CompleteTags

" Word wrap without line breaks
setlocal wrap
setlocal linebreak
setlocal textwidth=0
setlocal wrapmargin=0
setlocal formatoptions-=t
setlocal formatoptions+=l

" vim-surround
let b:surround_{char2nr('*')} = "*\r*"
let b:surround_{char2nr('i')} = "*\r*"
let b:surround_{char2nr('b')} = "**\r**"

" Headings with ease!
nnoremap <buffer> \3    I###<Space><Esc>
nnoremap <buffer> \4   I####<Space><Esc>
nnoremap <buffer> \5  I#####<Space><Esc>
nnoremap <buffer> \6 I######<Space><Esc>

" Easy bold and italic
vmap <buffer> <C-i> Si
vmap <buffer> <C-b> Sb

if has("gui_running") && has("gui_macvim")
  xmap <buffer> <D-b> Sb
  xmap <buffer> <D-i> Si
endif

" ---
" Stolen from gabrielelana/vim-markdown
"   https://github.com/gabrielelana/vim-markdown/blob/08e0731ce2c0b541ea335c782c59bb2e870730d4/ftplugin/markdown.vim#L155-L160
" ---
"
" Jumping around
noremap  <silent> <buffer> ]] :<C-u>call x2a#utils#markdown#JumpToHeader(1, 0)<CR>
noremap  <silent> <buffer> [[ :<C-u>call x2a#utils#markdown#JumpToHeader(0, 0)<CR>
vnoremap <silent> <buffer> ]] :<C-u>call x2a#utils#markdown#JumpToHeader(1, 1)<CR>
vnoremap <silent> <buffer> [[ :<C-u>call x2a#utils#markdown#JumpToHeader(0, 1)<CR>
noremap  <silent> <buffer> ][ <Nop>
noremap  <silent> <buffer> [] <Nop>
