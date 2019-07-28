# 10x faster implementation of `git status` command
#   https://github.com/romkatv/gitstatus
zplugin ice pick"gitstatus.plugin.zsh" atload"gitstatus_check MY || gitstatus_start -s -1 -u -1 -d -1 MY"
zplugin light romkatv/gitstatus

# Open the GitHub page or website for a repository in your browser.
#   https://github.com/paulirish/git-open
zplugin ice as"command" pick"git-open" wait"1" lucid
zplugin light paulirish/git-open

# Text-based git log graph viewer
#   https://github.com/takaaki-kasai/git-foresta
zplugin ice as"command" pick"git-foresta" wait"2" lucid
zplugin light takaaki-kasai/git-foresta

# Completely remove a file from a git repository
#   https://github.com/nachoparker/git-forget-blob
#   https://ownyourbits.com/2017/01/18/completely-remove-a-file-from-a-git-repository-with-git-forget-blob/
zplugin ice as"command" cp"git-forget-blob.sh -> git-forget-blob" pick"git-forget-blob" wait"2" lucid
zplugin light nachoparker/git-forget-blob

# Easy TOC creation for GitHub README.md
#   https://github.com/ekalinin/github-markdown-toc
zplugin ice as"command" pick"gh-md-toc" wait"1" lucid
zplugin light ekalinin/github-markdown-toc

# local plugins
zplugin ice atload'zpcompinit; zpcdreplay' wait"1" lucid
zplugin load _local/git

zplugin ice wait"1" lucid
zplugin load _local/zsh-git-escape-magic
