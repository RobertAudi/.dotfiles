" Sequentially increment numbers in visual selection
"
" Depending on {linear}:
"
"   0:  Increments each number by {count} relative
"       to the previous one, starting with the
"       second number
"
"   1:  Increment all numbers by {count}
"       starting with the first number
function! x2a#incr#Incr(count, linear) range abort
  if a:count <= 0
    return
  endif

  let l:column = virtcol("'<")

  if a:firstline == a:lastline
    execute a:firstline . 'normal! ' . l:column . '|' . a:count . "\<C-a>"
  else
    let l:count = a:count
    let l:start = a:firstline
    let l:end = a:lastline

    if a:linear
      let l:modifier = 0
    else
      let l:modifier = a:count
      let l:start += 1
    endif

    let l:lines = range(l:start, l:end)

    for l:line in l:lines
      execute l:line . 'normal! ' . l:column . '|' . l:count . "\<C-a>"

      let l:count += l:modifier
    endfor
  endif
endfunction
