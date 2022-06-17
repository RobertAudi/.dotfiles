#!/usr/bin/env zsh

source "${${(%):-%x}:A:h}/default-gems.sh"

typeset -a gems

# A command-line tool that helps you summarize and pretty-print
# collaborators in a git repository based on contributions
#   http://oleander.io/git-fame-rb
gems+=("git_fame")

# gitting pissed about your code: tracks any number of words across your
# entire git history. The defaults are wildly offensive and inspired by
# Vidar Holen's Linux Kernel Swear Counts.
#   https://github.com/chrishunt/git-pissed
gems+=("git_pissed")

# A simple git log analyzer gem
#   https://github.com/abhshkdz/graf
gems+=("graf")

# Transpec converts your specs to the latest RSpec syntax with static
# and dynamic code analysis.
#   http://yujinakayama.me/transpec/
gems+=("transpec")

# The opposite of roff
#   http://rtomayko.github.io/ronn/
gems+=("ronn")

# The instafailing RSpec progress bar formatter
#   https://github.com/thekompanee/fuubar
defaultLibGems+=("fuubar")

# RSpec formatter for the macOS Notification Center
#   https://github.com/twe4ked/rspec-nc
defaultLibGems+=("rspec-nc")

# Nyan Cat inspired RSpec formatter!
#   https://github.com/mattsears/nyan-cat-formatter
defaultLibGems+=("nyan-cat-formatter")

# A library for generating fake data such as names,
# addresses, and phone numbers.
#   https://github.com/faker-ruby/faker
defaultLibGems+=("faker")

# A tool to make it easier to pick the right Faker
# methods to generate the fake data you need. 🔍
#   https://github.com/faker-ruby/faker-bot
defaultLibGems+=("faker-bot")

builtin print -P -- "%F{blue}==>%f Installing gems:"
builtin print -P -- "%B${(j: :)gems}%b"

SKIP_RIPPER_TAGS=1 gem install ${gems[@]} --no-document --env-shebang

unset gems
