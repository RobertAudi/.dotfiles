if !has("mac") && !has("gui_mac")
  finish
endif

function! macos#RevealInFinder(filepath) abort
  call system("open -R '" . a:filepath . "'")
endfunction

function! macos#PreviewInQuickLook(filepath) abort
  call system("qlmanage -p &>/dev/null '" . a:filepath . "'")
endfunction
