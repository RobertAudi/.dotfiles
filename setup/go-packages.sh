#!/usr/bin/env zsh


# Utils {{{
# ------------------------------------------------------------------------------

function ___install {
  if (( $# == 0 )); then
    builtin print -P -- "[%F{red}ERROR%f] Insufficient arguments: package required" >&2
    return 1
  fi

  local package description

  package="$1"; shift
  description="$@"

  if [[ -n "$description" ]]; then
    builtin print -P -- "%B%F{blue}==>%f%b Installing %B%U${package}%u%b: %B${description}%b"
  fi

  builtin print -P -- "%B%F{blue}==>%f go get -u -v ${package}%b"
  go get -u -v "$package"

  builtin print -Pn -- "%B%F{019}"; hr "⋅"; builtin print -Pn -- "%f%b"
}

# ------------------------------------------------------------------------------ }}}

___install github.com/tj/mmake/cmd/mmake
___install github.com/tj/node-prune/cmd/node-prune
___install mvdan.cc/git-picked
___install mvdan.cc/xurls/cmd/xurls
___install github.com/brankas/git-buildnumber
___install github.com/42wim/dt
___install github.com/42wim/rl
___install github.com/mattn/vimunball
___install github.com/ddo/fast
___install github.com/pocke/emo
___install github.com/sgreben/tj/cmd/tj
___install github.com/sgreben/jp/cmd/jp
___install github.com/sgreben/tcp-time/cmd/tcp-time
___install github.com/sgreben/url/cmd/url
___install github.com/nomad-software/meme
___install github.com/syossan27/kirimori
___install github.com/Rican7/define
___install github.com/keith/ghs
___install github.com/rhysd/dot-github
___install github.com/rylio/ytdl/...
___install github.com/rhysd/vim-startuptime
___install github.com/tigrawap/slit/cmd/slit

# A command line urban dictionary.
#   https://github.com/genuinetools/udict
___install github.com/genuinetools/udict 'A command line urban dictionary.'

# flip (╯°□°）╯︵ʇxǝʇ
#   https://github.com/peterhellberg/flip
___install github.com/peterhellberg/flip/cmd/flip 'flip (╯°□°）╯︵ʇxǝʇ'

# SQL Formatter
#   https://github.com/jackc/sqlfmt
___install github.com/jackc/sqlfmt/... 'SQL Formatter'

# Unix `test` command for Version comparison
#   https://github.com/b4b4r07/vtest
___install github.com/b4b4r07/vtest 'Unix `test` command for Version comparison'

# rget is parallel downloader for GitHub release.
#   https://github.com/orisano/rget
___install github.com/orisano/rget 'rget is parallel downloader for GitHub release.'

# A faster file programming language detector
#   https://github.com/src-d/enry
___install gopkg.in/src-d/enry.v1/... 'A faster file programming language detector'
