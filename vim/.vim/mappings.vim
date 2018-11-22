" Map leaders
let mapleader        = ','
let g:mapleader      = ','

" No Help, please
inoremap <F1> <Esc>
nnoremap <F1> <Esc>
vnoremap <F1> <Esc>

" Command Mode maps
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-d> <Del>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-y> <C-r>+

if has('gui_running') && has('gui_macvim')
  cnoremap ∫ <S-Left>
  cnoremap ƒ <S-Right>
  cnoremap ∂ <S-Right><C-w>
elseif !has('gui_running')
  cmap <Esc>f <S-Right>
  cmap <Esc>b <S-Left>
  cmap <Esc>d <S-Right><C-w>
  cnoremap <nowait> <Esc> <C-c>
endif

" Disable Ex mode
" Instead use Q to reapeat the last macro
nnoremap Q @@

" . in visual mode
vnoremap . :normal .<CR>

" Uppercase/Lowercase word under the cursor.
nnoremap gU gUiw`]
nnoremap gu guiw`]

" Repeats macro on every line
vnoremap @ :normal @

" Reapeat the last macro on every line
vnoremap Q :normal @@<CR>

" Get more information from ctrl-g:
nnoremap <C-g> 2<C-g>

noremap  <Left>  <Nop>
noremap  <Right> <Nop>
noremap  <Up>    <Nop>
noremap  <Down>  <Nop>
inoremap <Left>  <Nop>
inoremap <Right> <Nop>
inoremap <Up>    <Nop>
inoremap <Down>  <Nop>

" Linewise movement should work on screen lines
nnoremap <expr>  $ x2a#movements#line#Dollar()
nnoremap <expr> g$ x2a#movements#line#gDollar()
vnoremap <expr>  $ x2a#movements#line#Dollar()
vnoremap <expr> g$ x2a#movements#line#gDollar()

nnoremap <expr>  0 x2a#movements#line#Zero()
nnoremap <expr> g0 x2a#movements#line#gZero()
vnoremap <expr>  0 x2a#movements#line#Zero()
vnoremap <expr> g0 x2a#movements#line#gZero()

nnoremap <expr>  ^ x2a#movements#line#Caret()
nnoremap <expr> g^ x2a#movements#line#gCaret()
vnoremap <expr>  ^ x2a#movements#line#Caret()
vnoremap <expr> g^ x2a#movements#line#gCaret()

nnoremap <expr>  k x2a#movements#line#Up()
nnoremap <expr> gk x2a#movements#line#gUp()
vnoremap <expr>  k x2a#movements#line#Up()
vnoremap <expr> gk x2a#movements#line#gUp()

nnoremap <expr>  j x2a#movements#line#Down()
nnoremap <expr> gj x2a#movements#line#gDown()
vnoremap <expr>  j x2a#movements#line#Down()
vnoremap <expr> gj x2a#movements#line#gDown()

" Open closed fold on the current line
nnoremap <expr> h foldclosed('.') > -1 ? 'zo' : 'h'
nnoremap <expr> l foldclosed('.') > -1 ? 'zo' : 'l'

" see Vertical Text Shifting functions.vim
nnoremap <S-Left>  <<
nnoremap <S-Right> >>
inoremap <S-Left>  <C-d>
inoremap <S-Right> <C-t>

" Don't make a # force column zero.
inoremap # x<BS>#

" Add new line below without leaving insert mode
inoremap <S-Enter> <C-o>o

" Do not exit visual mode when shifting
vnoremap <silent> > >gv
vnoremap <silent> < <gv

" Stolen from: https://github.com/godlygeek/vim-files
"   https://github.com/godlygeek/vim-files/blob/26aafb044895f778710bbc507310f5598019fa96/.vimrc#L268-L274
"
" Make [[ and ]] work even if the { is not in the first column
nnoremap <silent> [[ :call search('^\S\@=.*{\s*$', 'besW')<CR>
nnoremap <silent> ]] :call search('^\S\@=.*{\s*$', 'esW')<CR>
onoremap <expr> [[ (search('^\S\@=.*{\s*$', 'ebsW') && (setpos("''", getpos('.')) <Bar><Bar> 1) ? "''" : "\<Esc>")
onoremap <expr> ]] (search('^\S\@=.*{\s*$', 'esW') && (setpos("''", getpos('.')) <Bar><Bar> 1) ? "''" : "\<Esc>")

" In VISUAL mode:
"   v switches to VISUAL BLOCK mode
" In VISUAL BLOCK mode:
"   v switches to VISUAL mode
" In any VISUAL mode:
"   <C-v> goes back to NORMAL mode
vnoremap <expr> v mode() == "v" ? '<C-v>' : 'v'
vnoremap <C-v> <Esc>

" Select, reindent or yank the entire file
nnoremap <silent> <Leader>a :call x2a#buffers#Select()<CR>
nnoremap <Leader>= :ReindentBuffer<CR>
nnoremap <Leader>y :YankBuffer<CR>

" match 'Y' behavior with 'C' and 'D' : Y = yy -> y$
nmap Y y$

" move cursor to the end of selected area after yank
xmap gy y`>
xmap Y y`>
xmap y y`<

" Keep cursor position when pasting
nnoremap p p`[
nnoremap P P`]

" Remap U to nothing, I hate U!
nnoremap U <Nop>

" Disable ZZ.
nnoremap ZZ  <Nop>

" Stay in the center!!
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" Keep cursor joining lines
nnoremap J mzJ`z

" Movement through splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Next/Previous tab
nnoremap gt :tabnext<CR>
nnoremap gT :tabprevious<CR>

" Next/Previous buffer
nnoremap gb :bnext<CR>
nnoremap gB :bprevious<CR>

" Alternate buffer
nnoremap <C-e> <C-^>

" Change the filetype of the current buffer
nnoremap <Leader>ff :FT<Space>

" Browse Help
nnoremap <Leader>hh :Help<Space>

" use c* to change current word. than can use . to repeat action
nnoremap c* *Ncgn

" Easier search
nnoremap <Leader>s :%s//<Left>
xnoremap <Leader>s :s//<Left>
xnoremap s :s//<Left>
nnoremap <Leader>S :%s/<C-r>=expand("<cword>")<CR>//<Left>

" Use aesthetic middle of screen for "zz"
nnoremap zz :call x2a#movements#window#CenterCursorAesthetically()<CR>

" Universal opposite of J
nnoremap <silent> S :call x2a#breakhere#BreakHere()<CR>

" Increment/Decrement numbers in visual selection
xnoremap <silent> <C-a> :<C-u>let vcount = v:count1 <Bar> '<,'>s/\%V\d\+/\=submatch(0) + vcount<CR>gv
xnoremap <silent> <C-x> :<C-u>let vcount = v:count1 <Bar> '<,'>s/\%V\d\+/\=submatch(0) - vcount<CR>gv

" Sequentially increment numbers in visual selection
" Starting with the first number
xnoremap <silent> <Leader>i :<C-u>let vcount = v:count<CR>gv:call x2a#incr#Incr(vcount)<CR>

" Resize splits automatically
nnoremap <silent> <C-w>r :call x2a#utils#Splitresize()<CR>

" Same as */# but in a new split
nnoremap <C-w>*  <C-w>s*
nnoremap <C-w>#  <C-w>s#

" Remove search highlight and
" clear any message already displayed.
nnoremap <silent> <CR>       :nohlsearch<Bar>:match<Bar>:echo<CR>
nnoremap <silent> <Esc><Esc> :nohlsearch<Bar>:match<Bar>:echo<CR>

" Select the contents of the current line,
" excluding indentation.
nnoremap vv ^vg_

" Remap H and L to beggining and end of
" the line (Smart Home/End)
nnoremap <expr> H x2a#movements#line#Home()
vnoremap <expr> H x2a#movements#line#Home()
noremap  <expr> L x2a#movements#line#End()
vnoremap <expr> L x2a#movements#line#vEnd()

" Position the cursor at the top (gzh), middle (gzm) or bottom (gzl) of the screen
nnoremap gzh H
nnoremap gzm M
nnoremap gzl L

" Complete whole line
inoremap <C-l> <C-x><C-l>

" gi already moves to "last place you exited insert mode", so we'll map gI to
" something similar: move to last change
nnoremap gI `.i

" sort
vnoremap \s :sort u<CR>

" Matchit!
map <BS> %

" select last paste in visual mode
nnoremap <expr> gv '`[' . strpart(getregtype(), 0, 1) . '`]'

" Insert current date. Choice of format in dropdown
inoremap <silent> <C-g><C-t> <C-R>=repeat(complete(col('.'),map(["%Y-%m-%d %H:%M:%S","%a, %d %b %Y %H:%M:%S %z","%Y %b %d","%d-%b-%y","%a %b %d %T %Z %Y"],'strftime(v:val)')+[localtime()]),0)<CR>

" Drawing
" ------------------------------------------------------------------------------
nnoremap <silent> \-  :silent call x2a#drawing#Underline(x2a#drawing#delimiters.superdash)<CR>
nnoremap <silent> \_  :silent call x2a#drawing#Underline(x2a#drawing#delimiters.fat_underscore)<CR>
nnoremap <silent> \g- :silent call x2a#drawing#Line(x2a#drawing#delimiters.superdash)<CR>
nnoremap <silent> \g_ :silent call x2a#drawing#Line(x2a#drawing#delimiters.fat_underscore)<CR>
nnoremap <silent> \a_ :silent call x2a#drawing#AppendTrailer(x2a#drawing#delimiters.underscore)<CR>
nnoremap <silent> \a. :silent call x2a#drawing#AppendTrailer(x2a#drawing#delimiters.dot)<CR>
nnoremap <silent> \a? :call x2a#drawing#InputTrailer()<CR>
nnoremap <silent> \> :silent call x2a#drawing#RightJustify()<CR>

" In visual mode, \box draws a box around the highlighted text.
vnoremap <silent> ,box <Esc>:call x2a#drawing#BoxIn()<CR>gvlolo

inoremap <C-b>= <Esc>:call <SID>MakeSectionBox("=")<CR>
inoremap <C-b>- <Esc>:call <SID>MakeSectionBox("-")<CR>

if !has("gui_running")
  " backgrounding in insert mode
  inoremap <C-z> <C-o>:stop<CR>
endif
