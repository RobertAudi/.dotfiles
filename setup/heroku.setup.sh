#!/usr/bin/env zsh

if ! type heroku >/dev/null; then
  builtin print -P -u 2 -- "[%F{196}ERROR%f] Command not found: heroku"
  return 1
fi

# A heroku plugin for awesome pg:* commands that are also great and fun and super.
#   https://github.com/heroku/heroku-pg-extras
heroku plugins:install heroku-pg-extras

# Plugin for heroku CLI that can manipulate the repo
#   https://github.com/heroku/heroku-repo
heroku plugins:install heroku-repo

# Helps use multiple accounts on Heroku.
#   https://github.com/heroku/heroku-accounts
heroku plugins:install heroku-accounts

# Heroku Postgres connection tool for Postico.
#   https://github.com/jemcode/heroku-postico
heroku plugins:install heroku-postico

# The diff utility to check for configuration changes between releases of given heroku app.
#   https://github.com/kubek2k/heroku-cli-releases-diff
heroku plugins:install heroku-cli-releases-diff

# Heroku cli plugin to open the dashboard for you
#   https://github.com/freeformz/heroku-cli-dashboard
heroku plugins:install heroku-cli-dashboard
