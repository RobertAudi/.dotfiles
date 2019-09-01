" Consider `$` as part of a word text object.
setlocal iskeyword+=$

iabbrev <buffer> #! #!/usr/bin/env bash<CR><C-O>:normal "_cc<CR>
