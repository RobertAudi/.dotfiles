#
# git-update-tag
#
#   > git nuke-tag <tag-name> && \
#   > GIT_AUTHOR_NAME="" \
#   > GIT_AUTHOR_EMAIL="" \
#   > GIT_AUTHOR_DATE="" \
#   > GIT_COMMITTER_NAME="" \
#   > GIT_COMMITTER_EMAIL="" \
#   > GIT_COMMITTER_DATE="" \
#   > git tag -a -m "<message>" <tag-name> [commit]
#
export GITHUB_EDITOR="$EDITOR"

# Make sure git uses the macOS supplied openSSH.
# This is important because the SSH keys are stored
# in the system keychain.
if [[ $(uname | tr '[[:upper:]]' '[[:lower:]]') == *'darwin'* ]]; then
  export GIT_SSH="/usr/bin/ssh"
fi

path=("$ZSH_HOME/plugins/git/bin" $path)
fpath=("$ZSH_HOME/plugins/git/completions" "$ZSH_HOME/plugins/git/functions" $fpath)
function {
  emulate -L zsh
  setopt extended_glob
  autoload -Uz $ZSH_HOME/plugins/git/{completions,functions}/*~(*~|*.zwc)(-N.:t)
}
source "$ZSH_HOME/plugins/git/aliases.zsh"

if [[ -f "/usr/local/opt/git-extras/share/git-extras/git-extras-completion.zsh" ]]; then
  source "/usr/local/opt/git-extras/share/git-extras/git-extras-completion.zsh"
fi

compdef _git-ignore gi=git-ignore

git-insert-branch-name() {
  if git rev-parse 2> /dev/null; then
    local branch=$(git rev-parse --abbrev-ref HEAD)
    LBUFFER+=$(git rev-parse --abbrev-ref HEAD)
  fi
}
zle -N git-insert-branch-name
bindkey -M emacs '^x^g' git-insert-branch-name

zstyle -g existing_user_commands ':completion:*:*:git:*' user-commands

zstyle ':completion:*:*:git:*' user-commands $existing_user_commands \
  author-stats:'Output number of lines added / removed by author' \
  browse:'browse the project on GitHub' \
  conflicts:'Show list of files in a conflict state' \
  copy-branch-name:'Copy the current branch name to the clipboard (pbcopy)' \
  diff-unpushed:"Show the diff of everything you haven't pushed yet" \
  diffstat-unpushed:"Show the diffstat of everything you haven't pushed yet" \
  nuke:'Nukes a branch locally and on the origin remote' \
  nuke-tag:'Nukes a tag locally and on the origin remote' \
  prune-branches:'Simple script that cleans up unnecessary branches' \
  pruneall:'Prune branches from specified remotes, or all remotes when <remote> not specified' \
  reset-file:'Reset one file to a certain commit' \
  submodule-purge:'Purges the copies of obsoleted submodule repositories' \
  submodule-rm:'Remove submodules from current repo' \
  submodule-update:'Updates submodules in the current working directory' \
  track:'Sets up your branch to track a remote branch' \
  undo-push:'Undo your last push to branch ($1) of origin' \
  wip:'Create a WIP commit with all the changes' \
  wtf:'Displays the state of your repository in a readable, easy-to-scan format'
