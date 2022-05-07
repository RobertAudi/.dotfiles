#!/usr/bin/env zsh

source "${${(%):-%x}:A:h}/rust.setup.sh"

builtin print -Pn -- "%B%F{019}"; hr "⋅"; builtin print -Pn -- "%f%b"

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

# svgcleaner could help you to clean up your SVG files from the unnecessary data.
#   https://github.com/RazrFalcon/svgcleaner
cargoPackages+=("svgcleaner")

# Find and replace text in source files
#   https://github.com/TankerHQ/ruplacer
cargoPackages+=("ruplacer")

# A fast and reliable alternative to rsync for synchronizing local files
#   https://github.com/wchang22/LuminS
cargoPackages+=("lms")

# Simple calculator REPL, similar to bc(1), with syntax highlighting and persistent history
#   https://github.com/NerdyPepper/eva
cargoPackages+=("eva")

# A command-line tool to generate, analyze, convert and manipulate colors
#   https://github.com/sharkdp/pastel
cargoPackages+=("pastel")

# A tool and Rust crate for making text title case
#   https://github.com/wezm/titlecase
cargoPackages+=("titlecase")

# Find fonts which can show a specified character and preview them in terminal or browser.
#   https://github.com/7sDream/fontfor
cargoPackages+=("fontfor")

# A command line utility to easily make dank memes.
#   https://github.com/TheRawMeatball/meme-cli
cargoPackages+=("meme-cli")

# A terminal filter to colorize output
#   https://github.com/dalance/pipecolor
cargoPackages+=("pipecolor")

# An opinionated Lua code formatter
#   https://github.com/JohnnyMorganz/StyLua
cargoPackages+=("stylua")

# Find files (ff) by name, fast!
#   https://github.com/vishaltelangre/ff
cargoPackages+=("find-files")

# Create beautiful image of your source code.
#   https://github.com/Aloxaf/silicon
cargoPackages+=("silicon")

builtin print -P -- "%F{blue}==>%f Installing or updating cargo packages:"
builtin print -P -- "      %B${(j: :)cargoPackages}%b\n"

cargo install-update ${cargoPackages[@]}

# cha(rs) is a commandline tool to display information about unicode characters
#   https://github.com/antifuchs/chars
cargo install chars --git https://github.com/antifuchs/chars.git

# Timezones from the command line
#   https://github.com/mitsuhiko/when
cargo install --git https://github.com/mitsuhiko/when

unset cargoPackages
