export IRBRC="$XDG_CONFIG_HOME/irb/irbrc"
export RUBY_VERSION="$(cat $HOME/.ruby-version)"
export DEFAULT_GEMFILE="$HOME/.default-ruby-gems"

export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME/bundler/config"
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME/bundler"
export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME/bundler"

fpath=("$ZSH_HOME/plugins/ruby/functions" $fpath)
function {
  emulate -L zsh
  setopt extended_glob
  autoload -Uz $ZSH_HOME/plugins/ruby/functions/*~(*~|*.zwc)(-N.:t)
}

if type chruby-exec >/dev/null; then
  if ! type chruby >/dev/null; then
    chruby_file="${commands[chruby-exec]:h:h}/share/chruby/chruby.sh"
    if [[ -f "$chruby_file" ]]; then
      source "$chruby_file"
      chruby $RUBY_VERSION &>/dev/null
    else
      builtin print -P -- "[%F{196}ERROR%f] Failed to load chruby" >&2
    fi
    unset chruby_file
  fi
fi

if ! type gem_home >/dev/null; then
  if [[ -f "/usr/local/share/gem_home/gem_home.sh" ]]; then
    source "/usr/local/share/gem_home/gem_home.sh"
  else
    builtin print -P -- "[%F{196}ERROR%f] Failed to load gem_home" >&2
  fi
fi

# ruby-install: Remove sources, archives, and all that shit.
#
# Options:
#   --jobs=JOBS         Number of jobs to run in parallel when compiling
#   --src-dir DIR       Directory to download source-code into
#   --cleanup           Remove archive and unpacked source-code after installation
#   --no-reinstall      Skip installation if another Ruby is detected in same location
alias "ruby-install"="ruby-install --jobs=$(sysctl -n hw.ncpu) --src-dir \${XDG_CACHE_HOME:-\$HOME/.cache}/rubies --cleanup --no-reinstall"

alias rubies="chruby"

alias geml="gem list"
alias gems="gem search --remote"
alias gempath="lspath gempath"

alias be="bundle exec"

alias rake="noglob rake"
alias rr="routes"
alias rcs="rails console --sandbox"
alias rdbm="run_with_bundler rake db:migrate"
