scriptencoding utf-8

" scrooloose/nerdtree
" ------------------------------------------------------------------------------
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
      \   '.git$[[dir]]',
      \   '.hg$[[dir]]',
      \   '.svn$[[dir]]',
      \   '.gem$[[dir]]',
      \   '.yardoc$[[dir]]',
      \   '.sass-cache[[dir]]',
      \   '.idea[[dir]]',
      \   'Pods$[[dir]]',
      \   '.DS_Store$[[file]]',
      \   'Gemfile.lock$[[file]]',
      \   'Podfile.lock$[[file]]',
      \   '.zwc$[[file]]', '.zwc.old$[[file]]',
      \ ]

nnoremap <silent> -  :NERDTreeToggle<CR>
nnoremap <silent> g-  :NERDTreeFocus<CR>
nnoremap <silent> gF :silent! NERDTreeFind<CR>

" Make sure NERDTree has always the same size
Autocmd BufEnter,BufWinEnter NERD_tree_\d\+ execute 'vertical resize ' . NERDTreeWinSize
Autocmd BufLeave,BufWinLeave NERD_tree_\d\+ execute 'vertical resize ' . NERDTreeWinSize
