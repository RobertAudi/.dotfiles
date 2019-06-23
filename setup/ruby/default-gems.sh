#!/usr/bin/env zsh

typeset -a defaultExecutableGems
typeset -a defaultLibGems

# Documentation generation tool
#   https://yardoc.org/
defaultExecutableGems+=("yard")

# Conservative bundler updates
#   https://github.com/livingsocial/bundler-patch
defaultExecutableGems+=("bundler-patch")

# Patch-level verification for Bundled apps.
#   https://github.com/rubysec/bundler-audit
defaultExecutableGems+=("bundler-audit")

# Looks through your lockfile and tries to identify
# problematic use of dependencies
#   https://github.com/jmmastey/bundler-stats
defaultExecutableGems+=("bundler-stats")

# Pretty print Ruby objects to visualize their structure.
#   https://github.com/awesome-print/awesome_print
defaultExecutableGems+=("awesome_print")

# An IRB alternative and runtime developer console
#   https://pryrepl.org/
defaultExecutableGems+=("pry")

# An easy way to customize Pry colors via theme files
#   https://github.com/kyrylo/pry-theme
defaultExecutableGems+=("pry-theme")

# View state in pry session
#   https://github.com/SudhagarS/pry-state
defaultExecutableGems+=("pry-state")

# Automate the bundle/migration tedium of Rails with Git hooks
#   https://github.com/tpope/hookup
defaultExecutableGems+=("hookup")

# - gem edit: edit a library file you can require.
# - gem open: edit a gem by name.
# - gem clone: clone a gem from GitHub.
# - gem browse: open a gem's homepage in your browser
defaultExecutableGems+=("gem-browse")

# Compare versions of the given gem.
#   https://github.com/fedora-ruby/gem-compare
defaultExecutableGems+=("gem-compare")

# Search gems for content directory
#   https://github.com/mpapis/gem-content
defaultExecutableGems+=("gem-content")

# Display a man page for an installed RubyGem.
#   https://github.com/defunkt/gem-man
defaultExecutableGems+=("gem-man")

# Find the path for a given gem or require path for editing or greping
#   https://github.com/godfat/gem-path
defaultExecutableGems+=("gem-path")

# Release your ruby gems with ease
#   https://github.com/svenfuchs/gem-release
defaultExecutableGems+=("gem-release")

# This library contains some useful functionality to support the
# development of Ruby Gems
#   https://github.com/flori/gem_hadar
defaultExecutableGems+=("gem_hadar")

# Open REAME file of specified gem
#   https://github.com/jugyo/gem_readme
defaultExecutableGems+=("gem_readme")

# Command-line utility to find source repositories for ruby gems, open
# common GitHub pages, compare gem versions, and simplify gem update
# workflow in git.
#   https://github.com/teeparham/gemdiff
defaultExecutableGems+=("gemdiff")

# A useless gem prepending (╯°□°）╯︵ ┻━┻ to exception messages
#   https://github.com/iridakos/table_flipper
defaultLibGems+=("table_flipper")

# Fast, accurate ctags generator for ruby source code using Ripper
#   https://github.com/tmm1/ripper-tags
defaultExecutableGems+=("ripper-tags")

# A little Ruby gem for finding the source location of classes and methods
#   https://github.com/daveallie/where_is
defaultLibGems+=("where_is")

# Ruby gem information, stats and usage for your terminal
#   https://github.com/zverok/whatthegem
defaultExecutableGems+=("whatthegem")

# The instafailing RSpec progress bar formatter
#   https://github.com/thekompanee/fuubar
defaultLibGems+=("fuubar")

# RSpec formatter for the macOS Notification Center
#   https://github.com/twe4ked/rspec-nc
defaultLibGems+=("rspec-nc")

# Nyan Cat inspired RSpec formatter!
#   https://github.com/mattsears/nyan-cat-formatter
defaultLibGems+=("nyan-cat-formatter")

builtin print -P -- "%F{blue}==>%f Installing default executable gems:"
builtin print -P -- "%B${(j: :)defaultExecutableGems}%b"

SKIP_RIPPER_TAGS=1 gem install ${defaultExecutableGems[@]} --no-document --env-shebang

builtin print -P -- "%F{blue}==>%f Installing default lib gems:"
builtin print -P -- "%B${(j: :)defaultLibGems}%b"

gem install ${defaultLibGems[@]}

unset defaultExecutableGems
unset defaultLibGems
