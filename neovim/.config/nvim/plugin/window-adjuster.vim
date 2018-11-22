scriptencoding utf-8

" Resize splits automatically
function! s:Splitresize()
  let hmax = max([winwidth(0), float2nr(&columns * 0.66), 90])
  let vmax = max([winheight(0), float2nr(&lines * 0.66), 25])
  execute 'vertical resize' . (min([hmax, 140]))
  execute 'resize' . (min([vmax, 60]))
endfunction

nnoremap <silent> <C-w>r :call <SID>Splitresize()<CR>
