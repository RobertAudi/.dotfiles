# Remove the crappy zsh completion shipped by Homebrew git.
# I prefer zsh's builtin git completion.
# https://github.com/Homebrew/homebrew-core/issues/33275
#
# Credits to Alexander Groß (@agross)
#   https://github.com/agross/dotfiles/commit/4938bc8987a5b4ef0c7411a2c4b988d89a3ade11
[[ -f /usr/local/share/zsh/site-functions/_git ]] && \
  rm -f /usr/local/share/zsh/site-functions/_git

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
compdef -a _git \
  ga=git-add \
  gc=git-commit \
  gac=git-commit \
  gb=git-branch \
  gd=git-diff \
  tmux-git-diff=git-diff \
  fzf-git-checkout=git-checkout

git-insert-branch-name() {
  if git rev-parse 2> /dev/null; then
    local branch=$(git rev-parse --abbrev-ref HEAD)
    LBUFFER+=$branch
  fi
}
zle -N git-insert-branch-name
bindkey -M emacs '^x^g' git-insert-branch-name

zstyle -g existing_user_commands ':completion:*:*:git:*' user-commands

zstyle ':completion:*:*:git:*' user-commands $existing_user_commands \
  author-stats:'Output number of lines added / removed by author' \
  browse:'Browse the project on GitHub' \
  change-author:'Change the author information' \
  churn:'Show the churn' \
  conflicts:'Show list of files in a conflict state' \
  copy-branch-name:'Copy the current branch name to the clipboard (pbcopy)' \
  current-branch:'Displays the current Git branch' \
  delete-merged-branches:'Delete branches that have been merged' \
  diff-unpushed:"Show the diff of everything you haven't pushed yet" \
  diffstat-unpushed:"Show the diffstat of everything you haven't pushed yet" \
  disable-pushing:'Update the push URL for all remotes' \
  follow:'Add the remotes for forks on GitHub' \
  fixup:'Create a fixup commit' \
  merge-into:'Merge a branch into another one' \
  nuke:'Nukes a branch locally and on the origin remote' \
  nuke-tag:'Nukes a tag locally and on the origin remote' \
  prune-branches:'Simple script that cleans up unnecessary branches' \
  pruneall:'Prune branches from specified remotes, or all remotes when <remote> not specified' \
  remotes:'Show all remotes' \
  reset-file:'Reset one file to a certain commit' \
  submodule-purge:'Purges the copies of obsoleted submodule repositories' \
  submodule-rm:'Remove submodules from current repo' \
  submodule-update:'Updates submodules in the current working directory' \
  track:'Sets up your branch to track a remote branch' \
  undo:'Undo the N last commits on the current branch' \
  undo-push:'Undo your last push to branch ($1) of origin' \
  wip:'Create a WIP commit with all the changes' \
  wtf:'Displays the state of your repository in a readable, easy-to-scan format'
