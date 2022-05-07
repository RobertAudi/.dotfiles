" Plugin: AwesomeFoldText
" Description: FoldText improved for Vim
" Author: Enrico Ghirardi <i@choco.me>
" URL: https://github.com/choco/AwesomeFoldText

scriptencoding utf-8

function! s:GetSignsCount() abort
  let lang = v:lang
  language message C
  let signlist = execute('sign place buffer='. bufnr('%'))
  silent! execute 'language message' lang
  return len(split(signlist, '\n'))-1
endfunction

function! s:IsCommentBlock() abort
  return match(getline(v:foldstart), '^\s*/\*\+') != -1
endfunction

function! s:FoldMarkerIsOnSeparateLine() abort
  let foldStartMarker = matchstr(&foldmarker, '^[^,]*')
  return match(getline(v:foldstart), '^\s*["#/\*]*\s*' . foldStartMarker . 'd*\s*["#/\*]*$', 'g') != -1
endfunction

function! s:FilterInfo(text) abort
  let foldStartMarker = matchstr(&foldmarker, '^[^,]*')
  return substitute(a:text, '^\s*["#/\*]*\s*\|\s*["#/\*]*\s*' . foldStartMarker .'\d*\s*', '', 'g')
endfunction

function! s:FoldStartsOnBracket() abort
  return match(getline(v:foldstart), '^\s*{\s*$') != -1
endfunction

function! s:GetFoldInfo() abort
  let info = ''
  " Check if multiline comments start with '/*' or '/**' on a separate line.
  if s:IsCommentBlock()
    if match(getline(v:foldstart), '^\s*/\*\+\s*$') != -1
      " Use the next line in the comment block, and add the '/*' or '/**'
      " so that we know it's a block of comments or doc.
      let info = substitute(getline(v:foldstart), '\s*', '', 'g') . ' '
      let info = info . substitute(getline(v:foldstart + 1), '^\s*\*\+\s*', '', 'g')
    else
      let info = getline(v:foldstart)
    endif
  elseif s:FoldMarkerIsOnSeparateLine()
    let info = getline(v:foldstart + 1)
    let info = s:FilterInfo(info)
  elseif s:FoldStartsOnBracket()
    let info = '{ … }'
  else
    let info = getline(v:foldstart)
    let info = s:FilterInfo(info)
  endif
  let info = ' ' . info . ' '

  return info
endfunction

function! s:FormatLinesCount() abort
  let countText = ''
  let foldlen = v:foldend - v:foldstart + 1
  let percent = printf('%.1f', (foldlen * 1.0)/line('$') * 100) . '%'
  if winwidth(0) < 60
    let countText = printf('%4s', foldlen + 1)
  else
    let countText = printf('%4s lines %5s', foldlen, percent)
  endif

  let countText = g:AwesomeFoldText#CountSurroundLeft . countText . g:AwesomeFoldText#CountSurroundRight

  return countText
endfunction

function! s:IndentFold() abort
  if g:AwesomeFoldText#Indent == 1
    return repeat(' ', indent(v:foldstart))
  else
    return ''
  endif
endfunction

function! s:FormatFoldLevel() abort
  return repeat(g:AwesomeFoldText#FoldLevelSymbol, v:foldlevel * g:AwesomeFoldText#FoldLevelScale)
endfunction

function! s:CutText(text) abort
  let maxwidth = winwidth(0) * 2 / 3

  if strlen(a:text) > maxwidth
    return strpart(a:text, 0, maxwidth - 2) . '… '
  else
    return strpart(a:text, 0, maxwidth)
  endif
endfunction

function! s:FormatFirstPart() abort
  let startText = s:IndentFold() . g:AwesomeFoldText#Symbol . s:GetFoldInfo()
  let startText = s:CutText(startText)

  return startText
endfunction

function! s:FormatSecondPart() abort
  let linesCountText = s:FormatLinesCount()
  let foldLevelText = s:FormatFoldLevel()

  return foldLevelText . linesCountText . repeat(g:AwesomeFoldText#FillChar, 2)
endfunction

function! AwesomeFoldText#foldtext() abort
  let firstPartText = s:FormatFirstPart()
  let secondPartText = s:FormatSecondPart()
  let fillLength = winwidth(0) - strwidth(firstPartText . secondPartText) - &foldcolumn - (&number ? &numberwidth : 0) - (s:GetSignsCount() ? 2 : 0)
  return firstPartText . repeat(g:AwesomeFoldText#FillChar, fillLength) . secondPartText
endfunction
