setlocal omnifunc=javascriptcomplete#CompleteJS
setlocal define=^\\s*\\ze[^/,\\":=]*\\s*[:=]*\\s*\\(function\\\|define\\)[('\"]\\{-\\}
setlocal suffixesadd+=.js
setlocal include=^\\s*\\([^\/]\\{-\\}import[^'\"]*\\\|[^\/]\\{-\\}require\(\\)*['\"]\\zs[^'\"]*\\ze
setlocal comments-=://

" matchit
let b:match_words = '\<function\>:\<return\>,'
  \ . '\<do\>:\<while\>,'
  \ . '\<switch\>:\<case\>:\<default\>,'
  \ . '\<if\>:\<else\>,'
  \ . '\<try\>:\<catch\>:\<finally\>'
