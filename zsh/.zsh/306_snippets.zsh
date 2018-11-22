# ------------------------------------------------------------------- #
#                              Snippetss                              #
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
  alias -g ":pe"="| path-extractor"
fi

# Add snippets as global aliases as well
alias -g "::"='| $PAGER'
alias -g ":_"="&>/dev/null"
alias -g ":+"="| wc -l"
alias -g ":c"="| and-pipe copy"

# Intuitive map function
# For example, to list all directories that contain a certain file:
# find . -name .gitattributes :map dirname
alias -g ":map"="| xargs -n1"

# Fast paste
alias "p:"="pbpaste"
alias "p::"="pbpaste >"
alias -g ":p:"="\$(pbpaste)"

# Expand snippets with 'C-x Tab'
bindkey "\C-x\C-I" snippet-expand
