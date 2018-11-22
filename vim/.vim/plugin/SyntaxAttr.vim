if !x2a#utils#plugins#isInstalled('SyntaxAttr.vim')
  finish
endif

command! -nargs=0 ShowSyntax call SyntaxAttr#SyntaxAttr()
