#!/usr/bin/env zsh

# Utils {{{
# ------------------------------------------------------------------------------

function ___install {
  builtin print -P -- "%F{blue}==>%f npm install --global \"$1\""
  npm install --global "$1" || true
}

function ___install-peerdeps {
  builtin print -P -- "%F{blue}==>%f npx install-peerdeps --global \"$1\""
  npx install-peerdeps --global "$1" || true
}

# ------------------------------------------------------------------------------ }}}

# Update NPM first
___install npm

# A command-line interface to install an NPM package and its peer dependencies automatically.
#   https://github.com/nathanhleung/install-peerdeps
___install install-peerdeps

# Pluggable JavaScript linter
#   https://eslint.org/
___install eslint

# Airbnb's .eslintrc as an extensible shared config
#   https://github.com/airbnb/javascript/tree/master/packages/eslint-config-airbnb
___install-peerdeps eslint-config-airbnb

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

# Virtual file format for text processing used in @unifiedjs
#   https://github.com/vfile/vfile
___install vfile

# Utility to create a vfile from a filepath
#   https://github.com/vfile/to-vfile
___install to-vfile

# Utility to create a report for a vfile
#   https://github.com/vfile/vfile-reporter
___install vfile-reporter

# Command-line interface for remark: Markdown processor
#   https://github.com/remarkjs/remark
___install remark-cli

# Remark plugin to support GFM (autolink literals, footnotes,
# strikethrough, tables, tasklists)
#   https://github.com/remarkjs/remark-gfm
___install remark-gfm

# Remark plugin to link references to commits, issues, pull-requests,
# and users, like on GitHub
#   https://github.com/remarkjs/remark-github
___install remark-github

# Plugin to generate a table of contents (TOC)
#   https://github.com/remarkjs/remark-toc
___install remark-toc

# Plugin to compile markdown to man pages
#   https://github.com/remarkjs/remark-man
___install remark-man

# Prettier is an opinionated code formatter
#   https://prettier.io/
___install prettier

# prettier, as a daemon, for ludicrous formatting speed.
#   https://github.com/fsouza/prettierd
___install @fsouza/prettierd

# A mighty, modern linter that helps you avoid errors and
# enforce conventions in your styles
#   https://github.com/stylelint/stylelint
___install stylelint

# The recommended shareable config for Stylelint
#   https://github.com/stylelint/stylelint-config-recommended
___install stylelint-config-recommended

# A stylelint Language Server
#   https://github.com/bmatcuk/stylelint-lsp
___install stylelint-lsp

# A versatile, feature-rich TOML toolkit.
#   https://taplo.tamasfe.dev/cli/
___install @taplo/cli

# Check whether a website is up or down using the isitup.org API
#   https://github.com/sindresorhus/is-up-cli
___install is-up-cli

# Bash language server implementation
#   https://github.com/mads-hartmann/bash-language-server
___install bash-language-server

# vim language server, lsp for viml
#  https://github.com/iamcco/vim-language-server
___install vim-language-server

# JavaScript and TypeScript code intelligence through the Language Server Protocol
#   https://github.com/sourcegraph/javascript-typescript-langserver
___install javascript-typescript-langserver

# HTML/CSS/JSON language servers extracted from VSCode.
#  https://github.com/hrsh7th/vscode-langservers-extracted
___install vscode-langservers-extracted

# Language Server for Yaml Files
#   https://github.com/redhat-developer/yaml-language-server
___install yaml-language-server

# Pure Node.js Sass linting
#   https://github.com/sasstools/sass-lint
___install sass-lint

# Automated linting of Cascading Stylesheets
#   https://github.com/CSSLint/csslint/wiki/Command-line-interface
___install csslint

# The static code analysis tool you need for your HTML
#   https://github.com/htmlhint/HTMLHint
___install htmlhint

unfunction ___install ___install-peerdeps
