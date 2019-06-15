#!/usr/bin/env zsh

# Utils {{{
# ------------------------------------------------------------------------------

function ___install {
  builtin print -P -- "%F{blue}==>%f npm install --global \"$1\""
  npm install --global "$1"
}

# ------------------------------------------------------------------------------ }}}

# See the GitHub contributions calendar of a user in the command line.
#   https://github.com/IonicaBizau/ghcal
___install ghcal

# Local git statistics including GitHub-like contributions calendars.
#   https://github.com/IonicaBizau/git-stats
___install git-stats

# Imports your commits from a repository into git-stats history.
#   https://github.com/IonicaBizau/git-stats-importer
___install git-stats-importer

# Turn git-stats result into HTML output.
#   https://github.com/IonicaBizau/git-stats-html
___install git-stats-html

# Capture website screenshots
#   https://github.com/sindresorhus/pageres-cli
___install pageres-cli

# Nvim Node.js client and plugin host
#   https://github.com/neovim/node-client
___install neovim

# Get the icon of a file or app as a PNG image (macOS)
#   https://github.com/sindresorhus/file-icon-cli
___install file-icon-cli

# Control the macOS "Do Not Disturb" feature from the command-line
#   https://github.com/sindresorhus/do-not-disturb-cli
___install do-not-disturb-cli

# Get the path to an app (macOS)
#   https://github.com/sindresorhus/app-path-cli
___install app-path-cli

# Check if the built-in Mac camera is on
#   https://github.com/sindresorhus/is-camera-on
___install is-camera-on-cli

# Open a movie url or path in macOS picture-in-picture
#   https://github.com/albinekb/open-pip-cli
___install open-pip-cli

# Markdown files terminal viewer.
#   https://github.com/BubuAnabelas/markcat
___install markcat

# Bash language server implementation
#   https://github.com/mads-hartmann/bash-language-server
___install bash-language-server

# Command-line interface for remark: Markdown processor
#   https://github.com/remarkjs/remark
___install remark-cli

# Auto-link references like in GitHub issues, PRs, and comments
#   https://github.com/remarkjs/remark-github
___install remark-github

# Prettier is an opinionated code formatter
#   https://prettier.io/
___install prettier

# Check whether a website is up or down using the isitup.org API
#   https://github.com/sindresorhus/is-up-cli
___install is-up-cli
