#!/usr/bin/env zsh

source "${${(%):-%x}:A:h}/rust.sh"

builtin print -Pn -- "%B%F{019}"; hr "⋅"; builtin print -Pn -- "%f%b"

if ! cargo install --list | grep -q 'cargo-update'; then
  builtin print -P -- "%F{blue}==>%f Installing cargo-update"
  cargo install cargo-update || return $?

  builtin print -Pn -- "%B%F{019}"; hr "⋅"; builtin print -Pn -- "%f%b"
fi

typeset -a cargoPackages

# A cargo subcommand for checking and applying updates to installed executables
#   https://github.com/nabijaczleweli/cargo-update
cargoPackages+=("cargo-update")

# A nonsense activity generator
#   https://github.com/svenstaro/genact
cargoPackages+=("genact")

# Command line tool to browse a page for repository, file, commit or diff.
#   https://github.com/rhysd/git-brws
cargoPackages+=("git-brws")

# The Git Commit Message and Changelog Generation Framework
#   https://github.com/saschagrunert/git-journal
cargoPackages+=("git-journal")

# Generate remote repository strings
#   https://github.com/casey/remote
cargoPackages+=("remote")

# CLI tool to locate comments and commented out code in your source code ("comment detective")
#   https://github.com/simeg/commentective
cargoPackages+=("commentective")

# CLI tool to input and store your ideas without leaving the terminal
#   https://github.com/simeg/eureka
cargoPackages+=("eureka")

# An efficient way to filter duplicate lines from input, à la uniq.
#   https://github.com/whitfin/runiq
cargoPackages+=("runiq")

# Generate beautiful changelogs from your Git commit history
#   https://github.com/clog-tool/clog-cli
cargoPackages+=("clog-cli")

# A parallel universal-ctags wrapper for git repository
#   https://github.com/dalance/ptags
cargoPackages+=("ptags")

# Check Have I Been Pwned and see if it's time for you to change passwords.
#   https://github.com/brycx/checkpwn
#   https://haveibeenpwned.com/
cargoPackages+=("checkpwn")

# Simple http server in Rust
#   https://github.com/TheWaWaR/simple-http-server
cargoPackages+=("simple-http-server")

# Workspace productivity booster
#   https://github.com/brocode/fw
cargoPackages+=("fw")

# A minimal, fast alternative to 'du -sh'
#   https://github.com/sharkdp/dup
cargoPackages+=("du-dup")

# A more intuitive version of du in rust
#   https://github.com/bootandy/dust
cargoPackages+=("du-dust")

# A tool to analyze file system usage written in Rust
#   https://github.com/nachoparker/dutree
cargoPackages+=("dutree")

# svgcleaner could help you to clean up your SVG files from the unnecessary data.
#   https://github.com/RazrFalcon/svgcleaner
cargoPackages+=("svgcleaner")

# Find and replace text in source files
#   https://github.com/TankerHQ/ruplacer
cargoPackages+=("ruplacer")

# Intuitive find & replace CLI (sed alternative)
#   https://github.com/chmln/sd
cargoPackages+=("sd")

# A fast and reliable alternative to rsync for synchronizing local files
#   https://github.com/wchang22/LuminS
cargoPackages+=("lms")

builtin print -P -- "%F{blue}==>%f Installing or updating cargo packages:"
builtin print -P -- "      %B${(j: :)cargoPackages}%b\n"

cargo install-update ${cargoPackages[@]}

unset cargoPackages
