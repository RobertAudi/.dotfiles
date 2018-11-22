# snippets for expansion anywhere in the command line
# taken from http://zshwiki.org/home/examples/zleiab and expanded somewhat
#
# use: add-snippet <key> <expansion>
# then, with cursor just past <key>, run snippet-expand

typeset -Ag snippets

# snippet-add <key> <expansion>
snippet-add() {
  snippets[$1]="$2"
}

snippet-expand() {
  emulate -L zsh
  setopt extendedglob
  local MATCH

  LBUFFER=${LBUFFER%%(#m)[.\-+:|_a-zA-Z0-9]#}
  LBUFFER+=${snippets[$MATCH]:-$MATCH}
}
zle -N snippet-expand

help-list-snippets(){
  local help="$(print "Add snippet:";
    print "snippet-add <key> <expansion>\n";
    print "Snippets:";
    print -a -C 2 ${(kv)snippets})"
  if [[ "$1" = "inZLE" ]]; then
    zle -M "$help"
  else
    echo "$help"
  fi
}
run-help-list-snippets(){
  help-list-snippets inZLE
}
zle -N run-help-list-snippets
