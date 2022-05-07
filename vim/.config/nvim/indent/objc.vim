" Description: Vim indent file
" Language: Objective-C
" Maintainer: Bjorn Winckler <bjorn.winckler@gmail.com>
" Last Change:  2012 Jan 01

" Only load this indent file when no other was loaded.
if exists('b:did_indent')
  finish
endif
let b:did_indent = 1

" Ensure 'cpoptions' is set to Vim default values and restore later
let s:save_cpoptions = &cpoptions
set cpoptions&vim

setlocal cindent
setlocal indentkeys=0{,0},:,0#,!^F,o,O,e,<:>
setlocal indentexpr=GetObjCIndentImproved()

" Restore when changing filetype.
let b:undo_indent = 'setlocal cindent< indentkeys< indentexpr<'

if !exists('*GetObjCIndentImproved')
  " Top level statements which should not be indented, and which should not
  " cause next (non-blank) line to be indented either.
  let s:topLev = '^\s*@\%(class\|end\|implementation\|interface\|protocol\|\)\>'

  function! GetObjCIndentImproved() abort
    " NOTE: Ignore leading white space to avoid having to deal with space vs.
    " tab issues.  Rely on the indent() function instead.
    let l:thisLine = substitute(getline(v:lnum), '^\s*', '', '')

    if l:thisLine =~# s:topLev || getline(prevnonblank(v:lnum - 1)) =~# s:topLev
      return 0
    endif

    " If current line looks like an argument to a message dispatch, then line
    " up colon with previous line.  This will indent the second line so that
    " the colons line up in
    "
    "   [obj firstParameter:value
    "                paramB:value2];
    "
    " but it will not line up colons in
    "
    "   if ([obj something:here])
    "       [obj other:here];
    "
    let l:thisColon = match(l:thisLine, '^\s*\K\k*\zs:')
    if l:thisColon > 0
      let l:prevLine = substitute(getline(v:lnum - 1), '^\s*', '', '')
      let l:prevColon = match(l:prevLine, ':')
      if l:prevColon > 0
        " Try to align colons, always making sure line is indented at least
        " one shiftwidth more than the indentation at the beginning of the
        " message.  Avoids situations like this:
        "
        "     if ([obj a:x
        "  aLongParameter:y])
        "
        let [l:lnum, l:lcol] = searchpairpos('\[', '', '\]', 'b', 0,
              \ max([1, v:lnum - 10]))
        let l:minInd = &shiftwidth + (l:lnum > 0 ? indent(l:lnum) : 0)
        let l:alignedInd = indent(v:lnum - 1) + l:prevColon - l:thisColon
        return l:alignedInd > l:minInd ? l:alignedInd : l:minInd
      endif
    endif

    let l:prevLnum = v:lnum - 1
    let l:ind      = indent(l:prevLnum)

    " Indent one shiftwidth after opening block, e.g.:
    "
    "   call_func_with_block(param, ^{
    "       do_stuff();
    "   });
    "
    let l:blockPat = '\^\s*\(([^)]*)\)\?\s*{$'
    if l:thisLine =~# '^}'
      normal! '^%'
      if getline('.') =~? l:blockPat
        return indent('.')
      endif
    endif

    if getline(l:prevLnum) =~? l:blockPat
      return l:ind + &shiftwidth
    endif

    return cindent(v:lnum)
  endfunction
endif

" Restore 'cpoptions' options
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions
