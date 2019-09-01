# 10x faster implementation of `git status` command
#   https://github.com/romkatv/gitstatus
zplugin ice pick"gitstatus.plugin.zsh" atload"gitstatus_check MY || gitstatus_start -s -1 -u -1 -d -1 MY"
zplugin light romkatv/gitstatus

# local plugins
zplugin ice atload'zpcompinit; zpcdreplay' wait"1" lucid
zplugin load _local/git

zplugin ice wait"1" lucid
zplugin load _local/zsh-git-escape-magic
