syntax region jsoncLineComment start=+\/\/+                      end=+$+   keepend
syntax region jsoncLineComment start=+^\s*\/\/+ skip=+\n\s*\/\/+ end=+$+   keepend fold
syntax region jsoncComment     start="/\*"                       end="\*/"         fold

highlight def link jsoncLineComment Comment
highlight def link jsoncComment     Comment
