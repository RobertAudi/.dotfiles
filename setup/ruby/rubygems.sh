#!/usr/bin/env zsh


# Update RubyGems
builtin print -P -- "%F{blue}==>%f gem update --system"
gem update --system

# Documentation generation tool
#   http://yardoc.org/
builtin print -P -- "%F{blue}==>%f gem install yard --env-shebang --no-document"
gem install yard --env-shebang --no-document

# Bundler is shipped with Ruby 2.6+
if ruby -e "exit(Gem::Version.new(RUBY_VERSION) < Gem::Version.new('2.6') ? 0 : 1)" &> /dev/null ; then
  # Manages an application's dependencies
  #   https://bundler.io/
  builtin print -P -- "%F{blue}==>%f gem install bundler --env-shebang --no-document"
  gem install bundler --env-shebang --no-document
fi

# A Bundler plugin that makes gem installation errors more
# actionable, educative, and all around easier to understand
#   https://github.com/jules2689/extended_bundler-errors
#   https://rubygems.org/gems/extended_bundler-errors
builtin print -P -- "%F{blue}==>%f bundler plugin install extended_bundler-errors"
bundler plugin install extended_bundler-errors
