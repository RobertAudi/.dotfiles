#!/usr/bin/env zsh

# Utils {{{
# ------------------------------------------------------------------------------

function ___install {
  builtin print -P -- "    %F{196}=======>%f Installing $1... %F{196}<=======%f"
  cargo install "$1" --force
}

# ------------------------------------------------------------------------------ }}}

# A cargo subcommand for checking and applying updates to installed executables
#   https://github.com/nabijaczleweli/cargo-update
___install cargo-update

# A nonsense activity generator
#   https://github.com/svenstaro/genact
___install genact

# Command line tool to browse a page for repository, file, commit or diff.
#   https://github.com/rhysd/git-brws
___install git-brws

# The Git Commit Message and Changelog Generation Framework
#   https://github.com/saschagrunert/git-journal
___install git-journal

# Generate remote repository strings
#   https://github.com/casey/remote
___install remote

# CLI tool to locate comments and commented out code in your source code ("comment detective")
#   https://github.com/simeg/commentective
___install commentective

# CLI tool to input and store your ideas without leaving the terminal
#   https://github.com/simeg/eureka
___install eureka

# An efficient way to filter duplicate lines from input, à la uniq.
#   https://github.com/whitfin/runiq
___install runiq

# Generate beautiful changelogs from your Git commit history
#   https://github.com/clog-tool/clog-cli
___install clog-cli

# A parallel universal-ctags wrapper for git repository
#   https://github.com/dalance/ptags
___install ptags

# Check Have I Been Pwned and see if it's time for you to change passwords.
#   https://github.com/brycx/checkpwn
#   https://haveibeenpwned.com/
___install checkpwn

# Simple http server in Rust
#   https://github.com/TheWaWaR/simple-http-server
___install simple-http-server

# Workspace productivity booster
#   https://github.com/brocode/fw
___install fw

# A minimal, fast alternative to 'du -sh'
#   https://github.com/sharkdp/dup
___install du-dup

# A more intuitive version of du in rust
#   https://github.com/bootandy/dust
___install du-dust

# A tool to analyze file system usage written in Rust
#   https://github.com/nachoparker/dutree
___install dutree

# svgcleaner could help you to clean up your SVG files from the unnecessary data.
#   https://github.com/RazrFalcon/svgcleaner
___install svgcleaner

# Find and replace text in source files
#   https://github.com/TankerHQ/ruplacer
__install ruplacer

# Intuitive find & replace CLI (sed alternative)
#   https://github.com/chmln/sd
__install sd
