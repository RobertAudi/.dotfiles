" Plugin: SyntaxAttr.vim
" Description: Show syntax highlighting attributes of character under cursor.
" URL: https://github.com/inkarkat/SyntaxAttr.vim

if !x2a#utils#plugins#isInstalled('SyntaxAttr.vim')
  finish
endif

command! -nargs=0 ShowSyntax call SyntaxAttr#SyntaxAttr()
