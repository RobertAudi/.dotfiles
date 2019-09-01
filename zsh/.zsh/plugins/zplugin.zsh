# oh-my-zsh plugin
zplugin ice wait"1" lucid
zplugin snippet OMZ::plugins/safe-paste/safe-paste.plugin.zsh

# Gives you helpful hints when you execute a command for which you have an alias defined
#   https://github.com/molovo/tipz
zplugin ice pick"tipz.zsh" atload'source $ZDOTDIR/setup/plugins/molovo/tipz.zsh' wait"2" lucid
zplugin light molovo/tipz

# Add zsh's missing hooks, and support for user-defined hooks
#   https://github.com/willghatch/zsh-hooks
zplugin light willghatch/zsh-hooks

# Simple bookmarking plugin
#   https://github.com/RobertAudi/zshmarks
zplugin ice atload'source $ZDOTDIR/setup/plugins/RobertAudi/zshmarks.zsh' wait"1" lucid
zplugin light RobertAudi/zshmarks

# ZSH port of Fish history search
#   https://github.com/zsh-users/zsh-history-substring-search
zplugin ice atload'source $ZDOTDIR/setup/plugins/zsh-users/zsh-history-substring-search.zsh' wait"1" lucid
zplugin light zsh-users/zsh-history-substring-search

# Syntax-highlighting for Zshell
#   https://github.com/zdharma/fast-syntax-highlighting
zplugin ice wait"1" lucid
zplugin light zdharma/fast-syntax-highlighting

# Local plugins
zplugin ice wait"1" lucid
zplugin load _local/archive

zplugin ice atload'source $ZDOTDIR/setup/plugins/_local/zsh-snippets.zsh' wait"1" lucid
zplugin load _local/zsh-snippets

zplugin ice atload'source $ZDOTDIR/setup/plugins/_local/zsh-hints.zsh' wait"1" lucid
zplugin load _local/zsh-hints

zplugin ice wait"1" lucid
zplugin load _local/spectrum

zplugin ice wait"" lucid
zplugin load _local/direnv

for f in $ZSH_HOME/plugins/zplugin.d/*.zplugin.zsh; do
  source $f
done
unset f
