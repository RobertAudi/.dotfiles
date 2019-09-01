" Consider `!` and `?` as part of a word text object.
setlocal iskeyword+=!,?

" Don't scan included files
setlocal complete-=i

iabbrev <buffer> #! #!/usr/bin/env ruby<CR><C-O>:normal "_cc<CR>
