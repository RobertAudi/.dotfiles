# oh-my-zsh plugin
zplugin snippet OMZ::plugins/safe-paste/safe-paste.plugin.zsh

zplugin ice as"command" cp"httpstat.sh -> httpstat" pick"httpstat"
zplugin light b4b4r07/httpstat

zplugin ice pick"tipz.zsh"
zplugin light molovo/tipz

zplugin light RobertAudi/zsh-hooks
zplugin light RobertAudi/zshmarks
zplugin light zsh-users/zsh-history-substring-search
zplugin light RobertAudi/tsm
zplugin light rummik/zsh-ing
zplugin light rummik/zsh-slowcat
zplugin light caarlos0/ports

zplugin ice as"command" pick"vspark"
zplugin light LuRsT/vspark

zplugin ice as"command" pick"gh-md-toc"
zplugin light ekalinin/github-markdown-toc

zplugin ice wait"1" lucid
zplugin light zdharma/fast-syntax-highlighting

# Local plugins
zplugin load _local/archive
zplugin load _local/spectrum
zplugin load _local/zsh-snippets
zplugin load _local/zsh-hints
zplugin load _local/zsh-git-escape-magic
zplugin load _local/zsh-background-notifications

for f in $ZSH_HOME/plugins/zplugin.d/*.zplugin.zsh; do
  source $f
done
unset f
