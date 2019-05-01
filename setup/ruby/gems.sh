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


# A Ruby client for Neovim
#   https://github.com/alexgenco/neovim-ruby
gems+=("neovim")

# Transpec converts your specs to the latest RSpec syntax with static
# and dynamic code analysis.
#   http://yujinakayama.me/transpec/
gems+=("transpec")

# The opposite of roff
#   http://rtomayko.github.io/ronn/
gems+=("ronn")

# Manage complex tmux sessions easily
#   https://github.com/tmuxinator/tmuxinator
gems+=("tmuxinator")

builtin print -P -- "%F{blue}==>%f Installing gems:"
builtin print -P -- "%B${(j: :)gems}%b"

SKIP_RIPPER_TAGS=1 gem install ${gems[@]} --no-document --env-shebang

unset gems
