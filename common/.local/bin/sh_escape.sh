#!/bin/sh
#
# NAME
#   sh_escape -- escape or quote shell meta characters in given strings
#
# SYNOPSIS
#   sh_escape <string>...
#
# DESCRIPTION
#   Sh_escape outputs each argument escaped for use in eval(1) or any
#   other command that takes a command line to be evaluated by shell,
#   such as "sh -c '...'", using a bare space character as separator.
#
# EXAMPLES
#   To build a command line and run it on another host:
#
#     remote_command () {
#       ssh host "$(sh_escape "$@")"
#     }
#
# SEE ALSO
#   sh(1)
#
# AUTHOR
#   Akinori MUSHA <knu@idaemons.org>
#
#   Copyright (c) 2013 Akinori MUSHA
#
#   Licensed under the 2-clause BSD license.
#

sh_escape () {
    case "$*" in
        '')
            echo "''"
            ;;
        *[!A-Za-z0-9_.,:/@-]*)
            awk '
                BEGIN {
                    n = ARGC - 1
                    for (i = 1; i <= n; i++) {
                        s = ARGV[i]
                        gsub(/[^\nA-Za-z0-9_.,:\/@-]/, "\\\\&", s)
                        gsub(/\n/, "\047\n\047", s)
                        printf "%s", s
                        if (i != n) printf " "
                    }
                    exit 0
                }
                ' "$@"
            ;;
        *)
            printf %s "$*"
            ;;
    esac
}
