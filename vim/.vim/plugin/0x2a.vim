scriptencoding utf-8

" Symbols
let g:x2a#help_symbol     = "\u2139" " ℹ︎
let g:x2a#lock_symbol     = "\ue0a2" " 
let g:x2a#modified_symbol = "\u25cb" " ○
let g:x2a#git_symbol      = "\u00b1" " ±
let g:x2a#asterisk_symbol = "\u2731" " ✱

" Separators
let g:x2a#vertical_separator   = "\u007c" " |
let g:x2a#horizontal_separator = "\u2014" " —

" Files {{{
" ------------------------------------------------------------------------------

command! -bang -nargs=+ Chmod call x2a#file#Chmod(<bang>0, <f-args>)
command! -bang -nargs=1 -complete=custom,x2a#file#Rename#complete Rename call x2a#file#Rename(<f-args>, <bang>0)

command! -bang -nargs=0 Delete call x2a#file#Delete(<q-bang>, v:false)
command! -bang -nargs=0 Remove call x2a#file#Delete(<q-bang>, v:true)

nnoremap \rf :Rename <C-r>=expand("%:t")<CR>

" Make scripts executable on save
function! s:MakeScriptExecutable()
  let l:file = expand('%:p')
  if getline(1) =~# '^#!' && !executable(l:file)
    silent! call x2a#file#Chmod(0, '+x', l:file)
  endif
endfunction

augroup RAPluginsUnix
  autocmd!
  autocmd BufWritePost * call s:MakeScriptExecutable()
augroup END

" ------------------------------------------------------------------------------ }}}
