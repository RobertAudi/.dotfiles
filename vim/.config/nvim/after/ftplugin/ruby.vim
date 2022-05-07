" Consider `!` and `?` as part of a word text object.
setlocal iskeyword+=!,?

iabbrev <buffer> #! #!/usr/bin/env ruby<CR><C-O>:normal "_cc<CR>
