" Plugin: GoldenView.Vim
" Description: Always have a nice view for vim split windows!
" URL: https://github.com/RobertAudi/GoldenView.Vim

function! My_GoldenView_GoldenMinHeight()
  return GoldenView#GoldenMinHeight() + 10
endfunction

function! My_GoldenView_GoldenMinWidth()
  return GoldenView#GoldenMinWidth() + 20
endfunction

call GoldenView#ExtendProfile('sensible', {
      \   'other_window_winheight' : function('My_GoldenView_GoldenMinHeight'),
      \   'other_window_winwidth'  : function('My_GoldenView_GoldenMinWidth'),
      \ })
