export SOLARGRAPH_GLOBAL_CONFIG="$XDG_CONFIG_HOME/solarpgraph/config.yml"
export IRBRC="$XDG_CONFIG_HOME/irb/irbrc"
export RUBY_VERSION="$(cat $HOME/.ruby-version)"

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
      builtin print -P -u 2 -- "[%F{196}ERROR%f] Failed to load chruby"
    fi
    unset chruby_file
  fi
fi

if ! type gem_home >/dev/null; then
  if [[ -f "/opt/homebrew/share/gem_home/gem_home.sh" ]]; then
    source "/opt/homebrew/share/gem_home/gem_home.sh"
  else
    builtin print -P -u 2 -- "[%F{196}ERROR%f] Failed to load gem_home"
  fi
fi

alias rubies="chruby"

alias geml="gem list"
alias gems="gem search --remote"
alias gempath="lspath gempath"

alias rake="noglob rake"
alias rr="routes"
alias rcs="rails console --sandbox"
alias rdbm="run_with_bundler rake db:migrate"
