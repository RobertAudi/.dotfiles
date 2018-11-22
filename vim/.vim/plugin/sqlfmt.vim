if executable('sqlfmt')
  let g:sqlfmt_command = "sqlfmt"
  let g:sqlfmt_options = ""
elseif executable('sqlformat')
  let g:sqlfmt_command = "sqlformat"
  let g:sqlfmt_options = "-r -k upper"
endif
