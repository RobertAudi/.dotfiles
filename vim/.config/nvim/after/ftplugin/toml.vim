nnoremap <buffer> <silent> [[ <Cmd>call search('\v^%(\s*#\s*)*\[\[.+\]\]\s*$', 'bsW')<CR>
nnoremap <buffer> <silent> ]] <Cmd>call search('\v^%(\s*#\s*)*\[\[.+\]\]\s*$', 'sW')<CR>
onoremap <buffer> <expr> [[ (search('\v^%(\s*#\s*)*\[\[.+\]\]\s*$', 'bsW') && (setpos("''", getpos('.')) <Bar><Bar> 1) ? "''" : "\<Esc>")
onoremap <buffer> <expr> ]] (search('\v^%(\s*#\s*)*\[\[.+\]\]\s*$', 'sW') && (setpos("''", getpos('.')) <Bar><Bar> 1) ? "''" : "\<Esc>")
