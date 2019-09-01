" Plugin: git-blame.vim
" Description: A plugin to run `git blame` on the current buffer.
" URL: https://github.com/RobertAudi/git-blame.vim

let g:gitblame_mappings = {
      \   'previewCommit': '<CR>',
      \   'close': 'q'
      \ }

command! -nargs=0 GBlame call gitblame#blame()
