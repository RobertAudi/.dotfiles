#!/usr/bin/env zsh

# Documentation generation tool
#   http://yardoc.org/
gem install yard --env-shebang --no-document

# Manages an application's dependencies
#   https://bundler.io/
gem install bundler --env-shebang --no-document
bundler plugin install extended_bundler-errors

if type install-default-gems; then
  install-default-gems
fi
