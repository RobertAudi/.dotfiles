if exists('b:did_indent')
  finish
endif
let b:did_indent = 1

" Allow use of line continuation.
let s:save_cpo = &cpo
set cpo&vim


setlocal indentexpr=GetAppleScriptIndent()
setlocal indentkeys+=!^F,o,O,0=if,0=else,0=end,0=repeat,0=tell

" Restore when changing filetype.
let b:undo_indent = 'setlocal indentexpr< indentkeys<'

if !exists('g:applescript_default_indent')
  let g:applescript_default_indent = &shiftwidth
endif

" Only define the function once.
if exists('s:loaded')
  let &cpo = s:save_cpo
  unlet s:save_cpo
  finish
endif
let s:loaded = 1

function GetAppleScriptIndent()
  if v:lnum == 0
    return 0
  endif

  let lnum = prevnonblank(v:lnum - 1)

  let ind = indent(lnum)
  if ind == 0
    let ind = g:applescript_default_indent
  endif

  let line = getline(lnum)
  if line =~? '^\s*\<if\>'
    if substitute(line, '--.*$', '', '') =~? '\<then\>\s*$'
      let ind += &shiftwidth
    endif
  endif

  if line =~? '^\s*\<tell\>'
    if line !~? '\<to\>'
      let ind += &shiftwidth
    endif
  endif

  if line =~? '^\s*\<repeat\>\|^\s*\<on\>\|^\s*\<else\>\|^\s*\<with\>'
    let ind += &shiftwidth
  endif

  let line = getline(v:lnum)
  if line =~? '^\s*\<end\>\|^\s*\<else\>'
    let ind -= &shiftwidth
  endif

  return ind
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
