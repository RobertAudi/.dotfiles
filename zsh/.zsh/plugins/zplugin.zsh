# oh-my-zsh plugin
zplugin snippet OMZ::plugins/safe-paste/safe-paste.plugin.zsh

# It's like curl -v, with graphs and colors
#   https://github.com/b4b4r07/httpstat
zplugin ice as"command" cp"httpstat.sh -> httpstat" pick"httpstat"
zplugin light b4b4r07/httpstat

# Gives you helpful hints when you execute a command for which you have an alias defined
#   https://github.com/molovo/tipz
zplugin ice pick"tipz.zsh"
zplugin light molovo/tipz

# Add zsh's missing hooks, and support for user-defined hooks
#   https://github.com/willghatch/zsh-hooks
zplugin light willghatch/zsh-hooks

# Simple bookmarking plugin
#   https://github.com/RobertAudi/zshmarks
zplugin light RobertAudi/zshmarks

# ZSH port of Fish history search
#   https://github.com/zsh-users/zsh-history-substring-search
zplugin light zsh-users/zsh-history-substring-search

# Tmux Session Manager
#   https://github.com/RobertAudi/tsm
zplugin light RobertAudi/tsm

# Easily see what's happening on your computer's ports
#   https://github.com/caarlos0/ports
zplugin light caarlos0/ports

# Vertical graphs
#   https://github.com/LuRsT/vspark
zplugin ice as"command" pick"vspark"
zplugin light LuRsT/vspark

# Easy TOC creation for GitHub README.md
#   https://github.com/ekalinin/github-markdown-toc
zplugin ice as"command" pick"gh-md-toc"
zplugin light ekalinin/github-markdown-toc

# Syntax-highlighting for Zshell
#   https://github.com/zdharma/fast-syntax-highlighting
zplugin ice wait"1" lucid
zplugin light zdharma/fast-syntax-highlighting

# Local plugins
zplugin load _local/archive
zplugin load _local/zsh-snippets
zplugin load _local/zsh-hints
zplugin load _local/zsh-git-escape-magic

zplugin ice wait"1" lucid
zplugin load _local/zsh-background-notifications

zplugin ice wait"0" lucid
zplugin load _local/spectrum

for f in $ZSH_HOME/plugins/zplugin.d/*.zplugin.zsh; do
  source $f
done
unset f
