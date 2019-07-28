# ------------------------------------------------------------------- #
#                              Snippets                               #
# ------------------------------------------------------------------- #

snippet-add ":_"   "&>/dev/null"
snippet-add "::"   '| $PAGER'
snippet-add ":+"   "| wc -l"
snippet-add ":c"   "| and-pipe copy"
snippet-add ":map" "| xargs -n1 "

snippet-add "p:"   "pbpaste"
snippet-add "p::"  "pbpaste >"
snippet-add ":p:"  "\$(pbpaste)"

# path-extractor
if is-callable path-extractor; then
  snippet-add ":pe"  "| path-extractor"
fi

# Expand snippets with 'C-x Tab'
bindkey "\C-x\C-I" snippet-expand
