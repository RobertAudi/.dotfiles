alias ga="git add --all"
alias gc="git commit"
alias gac="git add --all; git commit"
alias gb="git branch"
alias gd="git diff --patch-with-stat"
alias gap="git add --patch"
alias gba="git branches"
alias gbd="git branch --delete --force"
alias gca="git amend-now"
alias gcob="git checkout -b"
alias gdc="gd --cached"
alias gdtool="git difftool"
alias gl="git l"
alias glb="git current-branch-log"
alias gla="git la"
alias glaa="git laa"
alias grm="git rm -r"
alias grs="git reset"
alias grsp="git reset --patch"

alias gcd="cd-gitroot"
alias gs="git-pretty-status -vv"
alias gss="git-pretty-status -v"
alias gsh="fzf-git-show"
alias gco="fzf-git-checkout"

if is-callable onefetch ; then
  alias onefetch="onefetch --no-merges --no-bots --hidden"
fi
