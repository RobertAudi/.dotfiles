#!/usr/bin/env zsh

emulate -L zsh

autoload -Uz colors && colors

if [[ "$(uname -s | tr '[[:upper:]]' '[[:lower:]]')" != *'darwin'* ]]; then
  builtin print -P -- "%F{196}!!!%f Unable to run the macOS setup script when not using macOS" >&2
  return 1
fi

if ! osascript -e "id of application \"Visual Studio Code\"" &> /dev/null ; then
  builtin print -P -- "%F{196}!!!%f Visual Studio Code is not installed" >&2
  builtin print -P -- "             Install it via https://code.visualstudio.com/" >&2
  return 1
fi

if ! type code &> /dev/null; then
  builtin print -P -- "%F{196}!!!%f The \"code\" command is not in the PATH" >&2
  builtin print -P -- "             Follow these instructions to install it: https://code.visualstudio.com/docs/setup/mac#_launching-from-the-command-line" >&2
  return 1
fi

# DotENV
# Support for dotenv file syntax
#   https://marketplace.visualstudio.com/items?itemName=mikestead.dotenv
code --install-extension mikestead.dotenv || true

# endwise
# Wisely add "end" in Ruby.
#   https://marketplace.visualstudio.com/items?itemName=kaiwood.endwise
code --install-extension kaiwood.endwise || true

# Trailing Spaces
# Highlight trailing spaces and delete them in a flash!
#   https://marketplace.visualstudio.com/items?itemName=shardulm94.trailing-spaces
code --install-extension shardulm94.trailing-spaces || true

# Better Comments
# Improve your code commenting by annotating with alert, informational, TODOs, and more!
#   https://marketplace.visualstudio.com/items?itemName=aaron-bond.better-comments
code --install-extension aaron-bond.better-comments || true

# Scratchpads
# Create multiple scratchpad files of different file types
#   https://marketplace.visualstudio.com/items?itemName=buenon.scratchpads
code --install-extension buenon.scratchpads || true

# Base16 Themes
# Base 16 themes ported from TextMate/Sublime
#   https://marketplace.visualstudio.com/items?itemName=AndrsDC.base16-themes
code --install-extension AndrsDC.base16-themes || true

# YAML
# YAML Language Support by Red Hat, with built-in Kubernetes syntax support
#   https://marketplace.visualstudio.com/items?itemName=redhat.vscode-yaml
code --install-extension redhat.vscode-yaml || true


# Ruby
# Ruby language support and debugging for Visual Studio Code
#   https://marketplace.visualstudio.com/items?itemName=rebornix.ruby
code --install-extension rebornix.ruby || true

# VSCode Ruby
# Syntax highlighing, snippet, and language configuration support for Ruby
#   https://marketplace.visualstudio.com/items?itemName=wingrunr21.vscode-ruby
code --install-extension wingrunr21.vscode-ruby || true

# Live Share
# Real-time collaborative development from the comfort of your favorite tools
#   https://marketplace.visualstudio.com/items?itemName=ms-vsliveshare.vsliveshare
code --install-extension ms-vsliveshare.vsliveshare || true
