#!/bin/sh
#
# NAME
#   parseoptlong -- generate a long option parser
#
# SYNOPSIS
#   parseoptlong [:] [(<option>|<option>:|<option>=<default>)..] <variable>
#
# DESCRIPTION
#   Parseoptlong is a helper function that generates a long option
#   parser for use with getopts(1).  A generated parser can be
#   evaluated in a getopts(1) loop to get the variable of the given
#   name, which should be the same as is given to getopts(1), OPTARG,
#   and OPTIND adjusted to support long options in addition to short
#   options.  A long option name captured into the given variable is
#   prefixed with a single dash ('-').
#
#   Long options are defined by the arguments preceding the variable
#   name.  Each argument must be in one of the following forms, where
#   no colon or equal sign shall be put in the <option> part:
#
#   <option>
#       Define a boolean option, --<option>.
#
#   <option>:
#       Define an option that takes a mandatory argument.  The option
#       can be given in the form of either --<option>=<value> or
#       --<option> <value>.
#
#   <option>=<default>
#       Define an option that takes an optional argument.  The option
#       can be given in the form of --<option>=<value> or --<option>.
#       In the latter case, OPTARG will be set to the default value if
#       it is non-empty, or be unset otherwise.
#
#   If the first argument is a colon, the way parseoptlong handles
#   error changes.  It mimics the behavior of getopts(1) when it is
#   given an option-string starting with a colon.  See getopts(1) for
#   details.
#
# EXAMPLES
#   Typical code to parse long options in addition to short options is
#   shown below.
#
#     parseoptlong=`parseoptlong help verbose user: password= opt`
#
#     # Make sure to add "-:" so long options are captured by
#     # getopts(1)
#     while getopts hvu:-: opt; do
#         eval "$parseoptlong"
#         case "$opt" in
#             h|-help)
#                 usage; exit ;;
#             v|-verbose)
#                 verbose=t ;;
#             u|-user)
#                 user="$OPTARG" ;;
#             -password)
#                 if [ -n "${OPTARG+t}" ]; then
#                     # --password=PASSWORD
#                     password="$OPTARG"
#                 else
#                     # --password
#                     stty -echo
#                     printf "Enter password: "
#                     read -r password
#                     stty echo
#                     echo
#                 fi
#                 ;;
#             *)
#                 exit 64
#                 ;;
#         esac
#     done
#
#     shift $((OPTIND-1))
#
#     # ...
#
# SEE ALSO
#   getopts(1), sh(1)
#
# AUTHOR
#   Akinori MUSHA <knu@idaemons.org>
#
#   Copyright (c) 2013 Akinori MUSHA
#
#   Licensed under the 2-clause BSD license.
#

parseoptlong () {
    local carp=t error

    if [ : = "$1" ]; then
        unset carp
        shift
    fi

    case $# in
        0)
            echo 'getoptslong: not enough arguments' >&2
            return 1 ;;
        1)
            return 0 ;;
    esac

    local option name="$(shift $(($#-1)) && printf %s "$1")" when booloptions= margoptions= oargoptions=

    echo "\
[ - != \"\$$name\" ] ||
case \"\$(shift \$((OPTIND-2)) && echo \".\$1\")\" in
.--*)
 case \"\$OPTARG\" in"

    while [ $# -gt 1 ]; do
        case "$1" in
            *\=*)
                option="${1%%=*}"
                oargoptions="$oargoptions $option"
                # --optarg => return default value
                echo "\
 $option)
  $name=\"-\$OPTARG\"
  OPTARG=\"${1#*=}\"
  [ -n \"\$OPTARG\" ] || unset OPTARG ;;"
                ;;
            *:)
                margoptions="$margoptions ${1%:}"
                ;;
            *)
                booloptions="$booloptions $1"
                ;;
        esac
        shift
    done

    # --bool => return null argument
    if [ -n "$booloptions" ]; then
        when=
        for option in $booloptions; do
            when="$when|$option"
        done
        echo "\
 ${when#"|"})
  $name=\"-\$OPTARG\"
  unset OPTARG ;;"
    fi

    # --bool=arg => fail
    if [ -n "$booloptions" ]; then
        when=
        for option in $booloptions; do
            when="$when|$option\=*"
        done
        if [ -n "$carp" ]; then
            echo "\
 ${when#"|"})
  $name='?'
  echo \"\$0: option does not take an argument -- \${OPTARG%%=*}\" >&2
  unset OPTARG ;;"
        else
            echo "\
 ${when#"|"})
  $name='?'
  OPTARG=\"\${OPTARG%%=*}\" ;;"
        fi
    fi

    # --mandarg=arg | --optarg=arg => return arg
    if [ -n "$margoptions$oargoptions" ]; then
        when=
        for option in $margoptions $oargoptions; do
            when="$when|$option\=*"
        done
        echo "\
 ${when#"|"})
  $name=\"-\${OPTARG%%=*}\"
  OPTARG=\"\${OPTARG#*=}\" ;;"
    fi

    # --mandarg arg => return arg or fail if missing
    if [ -n "$margoptions" ]; then
        when=
        for option in $margoptions; do
            when="$when|$option"
        done
        # Altering OPTIND works for some shells like bash, but does
        # not work for shells that store the current index in an
        # internal space.  Shifting is the only way to let getopts
        # continue parsing correctly on those shells.
        echo "\
 ${when#"|"})
  if [ \$# -ge \$OPTIND ]; then
   $name=\"-\$OPTARG\"
   shift \$((OPTIND-1))
   OPTARG=\"\$1\"
   shift
   OPTIND=1
  else"
        if [ -n "$carp" ]; then
            echo "\
   echo \"\$0: option requires an argument -- \$OPTARG\" >&2
   $name='?'
   unset OPTARG"
        else
            echo "\
   $name=:"
        fi
        echo "\
  fi ;;"
    fi

    if [ -n "$carp" ]; then
        echo "\
 *)
  echo \"\$0: illegal option -- \${OPTARG%%=*}\" >&2
  $name='?'
  unset OPTARG ;;"
    else
        echo "\
 *)
  $name='?'
  OPTARG=\"\${OPTARG%%=*}\" ;;"
    fi

    echo "\
 esac ;;
*)"

    if [ -n "$carp" ]; then
        echo "\
 echo \"\$0: illegal option -- \$$name\" >&2
 $name='?'
 unset OPTARG"
    else
        echo "\
 OPTARG=\"\$$name\"
 $name='?'"
    fi

    echo "\
 ;;
esac"
}
