"=============================================================================
" File: plugin/AwesomeFoldText.vim
" Author: Enrico Ghirardi <i@choco.me>
" URL: https://github.com/choco/AwesomeFoldText
" Last Change: 2016-09-15
"=============================================================================

if exists('g:loaded_awesomefoldtext')
  finish
endif
let g:loaded_awesomefoldtext = 1

if !exists('g:AwesomeFoldText#Symbol')
  let g:AwesomeFoldText#Symbol = '──'
endif
if !exists('g:AwesomeFoldText#FillChar')
  let g:AwesomeFoldText#FillChar = '─'
endif
if !exists('g:AwesomeFoldText#Indent')
  let g:AwesomeFoldText#Indent = 1
endif
if !exists('g:AwesomeFoldText#CountSurroundLeft')
  let g:AwesomeFoldText#CountSurroundLeft = '─┤ '
endif
if !exists('g:AwesomeFoldText#CountSurroundRight')
  let g:AwesomeFoldText#CountSurroundRight = ' ├─'
endif
if !exists('g:AwesomeFoldText#FoldLevelSymbol')
  let g:AwesomeFoldText#FoldLevelSymbol = '┼'
endif
if !exists('g:AwesomeFoldText#FoldLevelScale')
  let g:AwesomeFoldText#FoldLevelScale = 1
endif
