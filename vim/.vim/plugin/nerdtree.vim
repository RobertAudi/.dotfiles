" Plugin: nerdtree
" Description: File system explorer
" URL: https://github.com/scrooloose/nerdtree

scriptencoding utf-8

nnoremap <silent> -  :NERDTreeToggle<CR>
nnoremap <silent> gF :silent! NERDTreeFind<CR>

let g:NERDTreeHighlightCursorline = 0
let g:NERDTreeAutoDeleteBuffer    = 1
let g:NERDTreeCreatePrefix = 'silent keepalt keepjumps'
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI  = 1
let g:NERDTreeDirArrows  = 1
let g:NERDTreeQuitOnOpen = 0
let g:NERDTreeChDirMode  = 0
let g:NERDTreeMouseMode  = 3
let g:NERDTreeWinSize    = 30
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

let g:NERDTreeIgnore = [
      \   '\.git$[[dir]]',
      \   '\.hg$[[dir]]',
      \   '\.svn$[[dir]]',
      \   '\.gem$[[dir]]',
      \   '\.yardoc$[[dir]]',
      \   '\.sass-cache[[dir]]',
      \   '\.idea[[dir]]',
      \   'Pods$[[dir]]',
      \   '\.DS_Store$[[file]]',
      \   'Gemfile\.lock$[[file]]',
      \   'Podfile\.lock$[[file]]',
      \   '\.zwc$[[file]]', '\.zwc\.old$[[file]]',
      \ ]

" ------------------------------------------------------------------------------
" Plugin: nerdtree-git-plugin
" Description: A plugin of NERDTree showing git status
" URL: https://github.com/Xuyuanp/nerdtree-git-plugin
" ------------------------------------------------------------------------------

let g:NERDTreeIndicatorMapCustom = {
      \ "Modified"  : "○",
      \ "Staged"    : "●",
      \ "Untracked" : "⁇",
      \ "Renamed"   : "➜",
      \ "Unmerged"  : "‼",
      \ "Deleted"   : "×",
      \ "Dirty"     : "◌",
      \ "Clean"     : "√",
      \ 'Ignored'   : "╳",
      \ "Unknown"   : "?"
      \ }

" ------------------------------------------------------------------------------

" Stolen from https://github.com/roryokane/dotvim
"   https://github.com/roryokane/dotvim/blob/fcccf7016d74aa7d077d7df96d0ca5651b3837e0/vimrc#L912-L926
"
" When Vim is started with a single directory argument, change to that
" directory and set up a *real* NERDTree
function! s:SetUpNERDTreeIfVimStartedWithOneDirectoryArgument()
  if argc() == 1 && getftype(argv(0)) ==# 'dir'
    bdelete " Delete the automatically-opened directory browser
    execute 'cd ' . fnameescape(argv(0))
    NERDTree
    " I don’t know of any other way to configure the below for NERDTree
    set nocursorline
  endif
endfunction

augroup RAPluginsNERDTree
  autocmd!

  autocmd VimEnter * call <SID>SetUpNERDTreeIfVimStartedWithOneDirectoryArgument()

  " Make sure NERDTree has always the same size
  autocmd BufEnter,BufWinEnter NERD_tree_\d\+ execute 'vertical resize ' . NERDTreeWinSize
  autocmd BufLeave,BufWinLeave NERD_tree_\d\+ execute 'vertical resize ' . NERDTreeWinSize
augroup END
