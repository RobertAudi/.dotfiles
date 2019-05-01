setlocal commentstring=#\ %s

nnoremap <buffer> <silent> [[ <Cmd>call search('\v^\[.+\]\s*$', 'bsW')<CR>
nnoremap <buffer> <silent> ]] <Cmd>call search('\v^\[.+\]\s*$', 'sW')<CR>
onoremap <expr> [[ (search('\v^\[.+\]\s*$', 'bsW') && (setpos("''", getpos('.')) <Bar><Bar> 1) ? "''" : "\<Esc>")
onoremap <expr> ]] (search('\v^\[.+\]\s*$', 'sW') && (setpos("''", getpos('.')) <Bar><Bar> 1) ? "''" : "\<Esc>")
