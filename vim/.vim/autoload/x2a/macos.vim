if !has("gui_mac") && !has("gui_macvim") && !has("mac")
  finish
endif

function! x2a#macos#RevealInFinder(filepath) abort
  silent! call system("open -R " . shellescape(a:filepath) . "")
endfunction

function! x2a#macos#PreviewInQuickLook(filepath) abort
  silent! call system("qlmanage -p " . shellescape(a:filepath) . "")
endfunction
