# 10x faster implementation of `git status` command
#   https://github.com/romkatv/gitstatus
zinit ice pick"gitstatus.plugin.zsh" atload"gitstatus_check MY || gitstatus_start -s -1 -u -1 -d -1 MY > /dev/null"
zinit light romkatv/gitstatus

# Annotate your git branches
#   https://github.com/davidosomething/git-ink
zinit ice as"program" pick"git-ink"
zinit light davidosomething/git-ink

# local plugins
zinit wait"1" light-mode for \
  atload'ZINIT[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay' _local/git \
  _local/zsh-git-escape-magic
