syntax match x2aZSHcompdef     /\<compdef\>\s/me=e-1

syntax match x2aZpluginCommand     /\<zplugin\>\s/me=e-1 skipwhite nextgroup=x2aZpluginSubCommands
syntax match x2aZpluginSubCommands /\s\<\%(ice\|light\|snippet\|load\)\>\s/ms=s+1,me=e-1

syntax match x2aZpluginIceSubCommand /\sice\s/ms=s+1,me=e-1 nextgroup=x2aZpluginIceModifiers
syntax match x2aZpluginIceModifiers  /\s\<\%(proto\|from\|as\|id-as\|ver\|pick\|bpick\|depth\)\>[\n\s'"]/ms=s+1,me=e-1
syntax match x2aZpluginIceModifiers  /\s\<\%(cloneopts\|bindmap\|trackbinds\|if\|blockf\|silent\)\>[\n\s'"]/ms=s+1,me=e-1
syntax match x2aZpluginIceModifiers  /\s\<\%(lucid\|mv\|cp\|atinit\|atclone\|atload\|atpull\|nocd\)\>[\n\s'"]/ms=s+1,me=e-1
syntax match x2aZpluginIceModifiers  /\s\<\%(svn\|make\|src\|wait\|load\|unload\|service\|compile\)\>[\n\s'"]/ms=s+1,me=e-1
syntax match x2aZpluginIceModifiers  /\s\<\%(nocompletions\|nocompile\|multisrc\)\>[\n\s'"]/ms=s+1,me=e-1

syntax match x2aZpluginSnippetSubCommand /\ssnippet\s/ms=s+1,me=e-1 nextgroup=x2aZpluginSnippetShorthands
syntax match x2aZpluginSnippetShorthands /\s\<\%(OMZ\|PZT\)\>::/ms=s+1,me=e-2

highlight def link x2aZSHcompdef Keyword

highlight def link x2aZpluginCommand           Statement
highlight def link x2aZpluginSubCommands       Type
highlight def link x2aZpluginIceModifiers      Keyword
highlight def link x2aZpluginSnippetShorthands Keyword
