# Remove the crappy zsh completion shipped by Homebrew git.
# I prefer zsh's builtin git completion.
# https://github.com/Homebrew/homebrew-core/issues/33275
#
# Credits to Alexander Groß (@agross)
#   https://github.com/agross/dotfiles/commit/4938bc8987a5b4ef0c7411a2c4b988d89a3ade11
[[ -f /opt/homebrew/share/zsh/site-functions/_git ]] && \
  rm -f /opt/homebrew/share/zsh/site-functions/_git

path=("$ZSH_HOME/plugins/git/bin" $path)
fpath=("$ZSH_HOME/plugins/git/completions" "$ZSH_HOME/plugins/git/functions" $fpath)

function {
  emulate -L zsh
  setopt extended_glob
  autoload -Uz $ZSH_HOME/plugins/git/{completions,functions}/*~(*~|*.zwc)(-N.:t)
}

source "$ZSH_HOME/plugins/git/aliases.zsh"

if [[ -f "/opt/homebrew/opt/git-extras/share/git-extras/git-extras-completion.zsh" ]]; then
  source "/opt/homebrew/opt/git-extras/share/git-extras/git-extras-completion.zsh"
fi

# 10x faster implementation of `git status` command.
#   https://github.com/romkatv/gitstatus
#
# Start gitstatusd instance with name "MY".
#
# gitstatus_start [OPTION]... NAME
#
#   -s INT    Report at most this many staged changes; negative value means infinity.
#             Defaults to 1.
#
#   -u INT    Report at most this many unstaged changes; negative value means infinity.
#             Defaults to 1.
#
#   -d INT    Report at most this many untracked files; negative value means infinity.
#             Defaults to 1.
#
gitstatus_check MY || gitstatus_start -s -1 -u -1 -d -1 MY

compdef -a _git-ignore gi=git-ignore
compdef -a _git  \
  ga=git-add     \
  gc=git-commit  \
  gac=git-commit \
  gb=git-branch  \
  gpsf=git-push  \
  gcl=git-clone  \
  fzf-git-checkout=git-checkout

git-insert-branch-name() {
  if git rev-parse 2> /dev/null; then
    local branch=$(git rev-parse --abbrev-ref HEAD)
    LBUFFER+=$branch
  fi
}
zle -N git-insert-branch-name
bindkey -M emacs '^x^g' git-insert-branch-name

zstyle ':completion:*:*:git:*' user-commands $existing_user_commands \
  apple-pick:'recreate branch from base branch and cherry-picking each commit' \
  author-stats:'output number of lines added / removed by author' \
  browse:'browse the project on GitHub' \
  change-author:'change the author information' \
  churn:'show log of files that have many changes' \
  commits-count:'show the number of commits' \
  commits-since:'list commits since date (defaults to "last week")' \
  conflicts:'show the list of files in a conflict state' \
  copy-branch-name:'copy the current branch name to the clipboard (pbcopy)' \
  current-branch:'shows the current Git branch' \
  current-branch-log:'show the log of the current branch' \
  delete-merged-branches:'delete branches that have been merged' \
  delta:'lists files that differ from another branch' \
  diff-unpushed:"show the diff of everything you haven't pushed yet" \
  diffstat-unpushed:"show the diffstat of everything you haven't pushed yet" \
  disable-pushing:'update the push URL for all remotes' \
  edit-conflicts:'edit files in a conflict state' \
  erase-reflog:'erase the reflog' \
  fixup:'create a fixup commit' \
  follow:'add the remotes for forks on GitHub' \
  gui:'open the git GUI client' \
  merge-into:'merge a branch into another one' \
  missing-commits:'print out which commits are on one branch or the other but not both' \
  nuke:'nukes a branch locally and on the origin remote' \
  nuke-tag:'nukes a tag locally and on the origin remote' \
  optimizer:'do everything we can to optimize the repository' \
  overview:'show an overview of the repo' \
  prune-branches:'simple script that cleans up unnecessary branches' \
  pruneall:'prune branches from specified remotes, or all remotes when <remote> not specified' \
  pruner:'prune everything that is unreachable now' \
  rebase-branch:'interactively rebase all the commits on the current branch' \
  reflogs:'more readable reflog' \
  reflog-with-diff:'show reference log with diffs' \
  remotes:'show all remotes' \
  repacker:'repack a repo the way Linus recommends' \
  rename-remote:'rename a remote' \
  reset-file:'reset one file to a certain commit' \
  show-merged-branches:'show branches that have been merged' \
  show-unmerged-branches:'show branches that have not been merged' \
  stashes:'show all stashes' \
  stashes-with-diff:'show all stashes with diffs' \
  submodule-purge:'purges the copies of obsoleted submodule repositories' \
  submodule-rm:'remove submodules from current repo' \
  submodule-update:'updates submodules in the current working directory' \
  swag:'commit the staged files with a swag message' \
  track:'sets up your branch to track a remote branch' \
  undo:'undo the N last commits on the current branch' \
  undo-push:'undo your last push to branch ($1) of origin' \
  wip:'create a WIP commit with all the changes' \
  wtf:'displays the state of your repository in a readable, easy-to-scan format' \
  yolo:'create a YOLO commit'
