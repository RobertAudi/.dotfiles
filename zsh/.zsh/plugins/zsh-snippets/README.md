Install
-------

For the lazy:

```sh
$ git clone http://0x49.0x2a.xyz/RobertAudi/zsh-snippets.git
$ echo "source zsh-snippets/snippets.plugin.zsh" >> ~/.zshrc
```

The Magic
---------

Expand text anywhere on the command line, like aliases.

```sh
ps aux tg! # ! represents cursor position
# M-x snippet-expand, or hopefully you bind it to a key
ps aux | grep! # ! is your new cursor position
```

### Add snippets

```sh
snippet-add d "/my/long/directory/or/something like that"
# then you can expand d to... that long thing
```

### List snippets

```sh
help-list-snippets # pulls up help in a your pager
# or
# M-x run-help-list-snippets -- does the same thing
```

This snippet stuff has been floating around in a few different forms and names.  I think the first version was from http://zshwiki.org/home/examples/zleiab.  My version adds some (in my opinion) handy interface functions, and packages it in a plugin for easy use with antigen.

Examples
--------

```sh
snippet-add l      "less "
snippet-add tl     "| less "
snippet-add g      "grep "
snippet-add tg     "| grep "
snippet-add gl     "grep -l"
snippet-add tgl    "| grep -l"
snippet-add gL     "grep -L"
snippet-add tgL    "| grep -L"
snippet-add gv     "grep -v "
snippet-add tgv    "| grep -v "
snippet-add eg     "egrep "
snippet-add teg    "| egrep "
snippet-add fg     "fgrep "
snippet-add tfg    "| fgrep "
snippet-add fgv    "fgrep -v "
snippet-add tfgv   "| fgrep -v "
snippet-add ag     "agrep "
snippet-add tag    "| agrep "
snippet-add ta     "| ag "
snippet-add p      "${PAGER:-less} "
snippet-add tp     "| ${PAGER:-less} "
snippet-add h      "head "
snippet-add th     "| head "
snippet-add t      "tail "
snippet-add tt     "| tail "
snippet-add s      "sort "
snippet-add ts     "| sort "
snippet-add v      "${VISUAL:-${EDITOR:-nano}} "
snippet-add tv     "| ${VISUAL:-${EDITOR:-nano}} "
snippet-add tc     "| cut "
snippet-add tu     "| uniq "
snippet-add tx     "| xargs "
```

License
-------

Public Domain.
