# Add zsh's missing hooks, and support for user-defined hooks
#   https://github.com/willghatch/zsh-hooks
zinit light willghatch/zsh-hooks

# - molovo/tipz
#     Gives you helpful hints when you execute a command for which you have an alias defined
#       https://github.com/molovo/tipz
#
# - RobertAudi/zshmarks
#     Simple bookmarking plugin
#       https://github.com/RobertAudi/zshmarks
#
# - zsh-users/zsh-history-substring-search
#     ZSH port of Fish history search
#       https://github.com/zsh-users/zsh-history-substring-search
#
# - zdharma-continuum/fast-syntax-highlighting
#     Syntax-highlighting for Zshell
#       https://github.com/zdharma-continuum/fast-syntax-highlighting
zinit wait"1" light-mode for \
  OMZ::plugins/safe-paste/safe-paste.plugin.zsh \
  pick"tipz.zsh" atload"source \$ZDOTDIR/setup/plugins/molovo/tipz/atload.zsh" molovo/tipz \
  atload"source \$ZDOTDIR/setup/plugins/RobertAudi/zshmarks/atload.zsh" RobertAudi/zshmarks \
  atload"source \$ZDOTDIR/setup/plugins/zsh-users/zsh-history-substring-search/atload.zsh" zsh-users/zsh-history-substring-search \
  atinit"source \$ZDOTDIR/setup/plugins/zdharma-continuum/fast-syntax-highlighting/atinit.zsh" zdharma-continuum/fast-syntax-highlighting

# Local plugins
zinit wait"1" light-mode for \
  _local/spectrum \
  _local/archive

zinit wait"2" light-mode for \
  _local/zsh-background-notifications \
  atload"source \$ZDOTDIR/setup/plugins/_local/zsh-snippets/atload.zsh" _local/zsh-snippets \
  atload"source \$ZDOTDIR/setup/plugins/_local/zsh-hints/atload.zsh" _local/zsh-hints

for f in $ZSH_HOME/plugins/zinit.d/*.zinit.zsh; do
  source $f
done
unset f
