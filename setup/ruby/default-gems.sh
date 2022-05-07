#!/usr/bin/env zsh

function {
  function ___install {
    builtin print -P -- "%F{blue}==>%f ${@}"
    gem install $=@ || true
  }

  function ___install-executable {
    SKIP_RIPPER_TAGS=1 ___install ${1} --no-document --env-shebang
  }

  # Debugging functionality for Ruby.
  # This is completely rewritten debug.rb which was
  # contained by the ancient Ruby versions.
  ___install-executable debug

  # Documentation generation tool
  #   https://yardoc.org/
  ___install-executable yard

  # Provides an implementation of the XDG Base Directory Specification
  #   https://github.com/bkuhlmann/xdg
  ___install xdg

  # Ruby Style Guide, with linter & automatic code fixer
  #   https://github.com/testdouble/standard
  ___install-executable standard

  # A Ruby language server.
  #   https://solargraph.org
  #   https://github.com/castwide/solargraph
  ___install-executable solargraph

  # Lint your ERB or HTML files
  #   https://github.com/Shopify/erb-lint
  ___install erb_lint

  # Conservative bundler updates
  #   https://github.com/livingsocial/bundler-patch
  ___install-executable bundler-patch

  # Patch-level verification for Bundled apps.
  #   https://github.com/rubysec/bundler-audit
  ___install-executable bundler-audit

  # Looks through your lockfile and tries to identify
  # problematic use of dependencies
  #   https://github.com/jmmastey/bundler-stats
  ___install-executable bundler-stats

  # Pretty print your Ruby objects with style -- in full color and with proper indentation
  #   https://github.com/amazing-print/amazing_print
  ___install-executable amazing_print

  # Byebug is a simple to use and feature rich debugger for Ruby
  #   https://github.com/deivid-rodriguez/byebug
  ___install-executable byebug

  # An IRB alternative and runtime developer console
  #   https://pryrepl.org/
  ___install-executable pry

  # An easy way to customize Pry colors via theme files
  #   https://github.com/kyrylo/pry-theme
  ___install-executable pry-theme

  # View state in pry session
  #   https://github.com/SudhagarS/pry-state
  ___install-executable pry-state

  # Adds step-by-step debugging and stack navigation capabilities to pry using byebug.
  #   https://github.com/deivid-rodriguez/pry-byebug
  ___install-executable pry-byebug

  # Automate the bundle/migration tedium of Rails with Git hooks
  #   https://github.com/tpope/hookup
  ___install-executable hookup

  # - gem edit: edit a library file you can require.
  # - gem open: edit a gem by name.
  # - gem clone: clone a gem from GitHub.
  # - gem browse: open a gem's homepage in your browser
  ___install-executable gem-browse

  # Compare versions of the given gem.
  #   https://github.com/fedora-ruby/gem-compare
  ___install-executable gem-compare

  # Search gems for content directory
  #   https://github.com/mpapis/gem-content
  ___install-executable gem-content

  # Display a man page for an installed RubyGem.
  #   https://github.com/defunkt/gem-man
  ___install-executable gem-man

  # Find the path for a given gem or require path for editing or greping
  #   https://github.com/godfat/gem-path
  ___install-executable gem-path

  # Release your ruby gems with ease
  #   https://github.com/svenfuchs/gem-release
  ___install-executable gem-release

  # This library contains some useful functionality to support the
  # development of Ruby Gems
  #   https://github.com/flori/gem_hadar
  ___install-executable gem_hadar

  # Open REAME file of specified gem
  #   https://github.com/jugyo/gem_readme
  ___install-executable gem_readme

  # Command-line utility to find source repositories for ruby gems, open
  # common GitHub pages, compare gem versions, and simplify gem update
  # workflow in git.
  #   https://github.com/teeparham/gemdiff
  ___install-executable gemdiff

  # A useless gem prepending (╯°□°）╯︵ ┻━┻ to exception messages
  #   https://github.com/iridakos/table_flipper
  ___install table_flipper

  # Fast, accurate ctags generator for ruby source code using Ripper
  #   https://github.com/tmm1/ripper-tags
  ___install-executable ripper-tags

  # A little Ruby gem for finding the source location of classes and methods
  #   https://github.com/daveallie/where_is
  ___install where_is

  # Ruby gem information, stats and usage for your terminal
  #   https://github.com/zverok/whatthegem
  ___install-executable whatthegem

  # Ruby support for Neovim
  #   https://github.com/neovim/neovim-ruby
  ___install-executable neovim

  unfunction ___install ___install-executable
}
