" Start from scratch
unmapAll

" Navigation
map j scrollDown
map k scrollUp
map gg scrollToTop
map G scrollToBottom
map <c-u> scrollPageUp
map <c-d> scrollPageDown
map r reload
map R reload hard
map y copyCurrentUrl
map p openCopiedUrlInCurrentTab
map P openCopiedUrlInNewTab
map gu goUp
map gU goToRoot
map gi focusInput
map [ goPrevious
map ] goNext
map H goBack
map L goForward

" Link hints
map f LinkHints.activateMode
map F LinkHints.activateModeToOpenInNewTab
map gF LinkHints.activateModeToOpenInNewForegroundTab
map af LinkHints.activateModeWithQueue
map yf LinkHints.activateModeToCopyLinkUrl

" Vomnibar
map o Vomnibar.activate
map O Vomnibar.activateInNewTab
map go Vomnibar.activateEditUrl
map gO Vomnibar.activateEditUrlInNewTab
map <c-b> Vomnibar.activateTabSelection

" Find
map / enterFindMode
map n performFind
map N performBackwardsFind

" Tabs
map <c-p> previousTab
map <c-n> nextTab
map <c-o> visitPreviousTab
map D duplicateTab
map gp togglePinTab
map d removeTab
map u restoreTab
map gw moveTabToNewWindow
map gh moveTabLeft
map gl moveTabRight
map ? showHelp
