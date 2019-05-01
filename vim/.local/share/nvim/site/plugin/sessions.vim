command! -nargs=? SaveSession call x2a#sessions#save(<f-args>)
command! -nargs=? LoadSession call x2a#sessions#load(<f-args>)
command! -nargs=? ResumeSession call x2a#sessions#resume(<f-args>)
command! -nargs=? DeleteSession call x2a#sessions#delete(<f-args>)
