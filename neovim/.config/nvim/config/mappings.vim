" Mappings {{{
" ------------------------------------------------------------------------------

" Disable some annoying mappings
nnoremap M  <Nop>
nnoremap U  <Nop>
nnoremap ZZ <Nop>
nnoremap Q  <Nop>
nnoremap gQ <Nop>

" No Help, please
inoremap <F1> <Esc>
nnoremap <F1> <Esc>
vnoremap <F1> <Esc>

" Linewise movement should work on screen lines
nnoremap <expr>  $ v:count == 0 ? "g$" :  "$"
nnoremap <expr> g$ v:count == 0 ?  "$" : "g$"

nnoremap <expr>  0 v:count == 0 ? "g0" :  "0"
nnoremap <expr> g0 v:count == 0 ?  "0" : "g0"

nnoremap <expr>  ^ v:count == 0 ? "g^" :  "^"
nnoremap <expr> g^ v:count == 0 ?  "^" : "g^"

nnoremap <expr>  k v:count == 0 ? "gk" :  "k"
nnoremap <expr> gk v:count == 0 ?  "k" : "gk"

nnoremap <expr>  j v:count == 0 ? "gj" :  "j"
nnoremap <expr> gj v:count == 0 ?  "j" : "gj"

" Yank the characters under the cursor until the end of the line
" Match 'Y' behavior with 'C' and 'D' : Y = yy -> y$
nmap Y y$

" Move cursor to the end of selected area after yank
xmap Y y`>
xmap y y`<

" Keep cursor position when pasting
nnoremap p p`[
nnoremap P P`]

" In VISUAL mode:
"   v switches to VISUAL BLOCK mode
" In VISUAL BLOCK mode:
"   v switches to VISUAL mode
" In any VISUAL mode:
"   <C-v> goes back to NORMAL mode
vnoremap <expr> v mode() == "v" ? '<C-v>' : 'v'
vnoremap <C-v> <Esc>

" Select the contents of the current line,
" excluding indentation.
nnoremap vv ^vg_

" Faster indents
nnoremap > >>
nnoremap < <<

" Do not exit visual mode when shifting
vnoremap <silent> > >gv
vnoremap <silent> < <gv

" Movement through splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Remove search highlight and
" clear any message already displayed.
nnoremap <silent> <CR>       :nohlsearch<Bar>:match<Bar>:echo<CR>
nnoremap <silent> <Esc><Esc> :nohlsearch<Bar>:match<Bar>:echo<CR>

" Remap H and L to beggining and end of
" the line (Smart Home/End)
nnoremap <expr> H (col('.') == matchend(getline('.'), '^\s*')+1 ? '0' : '^')
vnoremap <expr> H (col('.') == matchend(getline('.'), '^\s*')+1 ? '0' : '^')
noremap  <expr> L (col('.') == match(getline('.'), '\s*$') ? '$'  : 'g_')
vnoremap <expr> L (col('.') == match(getline('.'), '\s*$') ? '$h' : 'g_')

" Repeats macro on every line
vnoremap @ :normal @

" Matchit!
map <BS> %

" Complete whole line
inoremap <C-l> <C-x><C-l>

" Easier search
nnoremap ,s :%s//<Left>
xnoremap ,s :s//<Left>
xnoremap s :s//<Left>
nnoremap ,S :%s/<C-r>=expand("<cword>")<CR>//<Left>

" Select the entire file
nnoremap ,a :keepjumps normal ggVG<CR>

" Universal opposite of J
nnoremap <silent> S :call breakhere#BreakHere()<CR>

" Use aesthetic middle of screen for "zz"
nnoremap <silent> zz :call utils#CenterCursorAesthetically()<CR>

" Increment/Decrement numbers in visual selection
xnoremap <silent> <C-a> :<C-u>let vcount = v:count1 <bar> '<,'>s/\%V\d\+/\=submatch(0) + vcount<cr>gv
xnoremap <silent> <C-x> :<C-u>let vcount = v:count1 <bar> '<,'>s/\%V\d\+/\=submatch(0) - vcount<cr>gv

" Sequentially increment numbers in visual selection
" Starting with the first number
xnoremap <silent> ,i :<C-u>let vcount = v:count<CR>gv:call incr#Incr(vcount)<CR>

" Drawing
" ------------------------------------------------------------------------------
nnoremap <silent> \-  :silent call drawing#Underline(drawing#delimiters.superdash)<CR>
nnoremap <silent> \_  :silent call drawing#Underline(drawing#delimiters.fat_underscore)<CR>
nnoremap <silent> \g- :silent call drawing#Line(drawing#delimiters.superdash)<CR>
nnoremap <silent> \g_ :silent call drawing#Line(drawing#delimiters.fat_underscore)<CR>
nnoremap <silent> \a_ :silent call drawing#AppendTrailer(drawing#delimiters.underscore)<CR>
nnoremap <silent> \a. :silent call drawing#AppendTrailer(drawing#delimiters.dot)<CR>
nnoremap <silent> \a? :call drawing#InputTrailer()<CR>
nnoremap <silent> \> :silent call drawing#RightJustify()<CR>

" In visual mode, \box draws a box around the highlighted text.
vnoremap <silent> ,box <Esc>:call drawing#BoxIn()<CR>gvlolo

inoremap <C-b>= <Esc>:call <SID>MakeSectionBox("=")<CR>
inoremap <C-b>- <Esc>:call <SID>MakeSectionBox("-")<CR>

" ------------------------------------------------------------------------------ }}}
