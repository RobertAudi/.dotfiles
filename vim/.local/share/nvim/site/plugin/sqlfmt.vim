" Plugin: vim-sqlfmt
" Description: A plugin for SQL formatter like gofmt
" URL: https://github.com/b4b4r07/vim-sqlfmt

if executable('sqlfmt')
  let g:sqlfmt_command = "sqlfmt"
  let g:sqlfmt_options = ""
elseif executable('sqlformat')
  let g:sqlfmt_command = "sqlformat"
  let g:sqlfmt_options = "-r -k upper"
endif
