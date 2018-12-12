#!/usr/bin/env zsh

# Documentation generation tool
#   http://yardoc.org/
gem install yard --env-shebang --no-document

# Manages an application's dependencies
#   https://bundler.io/
gem install bundler --env-shebang --no-document

# A Bundler plugin that makes gem installation errors more
# actionable, educative, and all around easier to understand
#   https://github.com/jules2689/extended_bundler-errors
#   https://rubygems.org/gems/extended_bundler-errors
bundler plugin install extended_bundler-errors

if type install-default-gems; then
  install-default-gems
fi
