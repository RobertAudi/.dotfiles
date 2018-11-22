alias ga="git add --all"
compdef _git ga=git-add

alias gc="git commit"
compdef _git gc=git-commit

alias gac="git add --all; git commit"
compdef _git gac=git-commit

alias gco="git checkout"
compdef _git gco=git-checkout

alias gb="git branch"
compdef _git gb=git-branch

alias gd="git diff --patch-with-stat"
compdef _git gd=git-diff

alias gaia="git add --all --intent-to-add"
alias gap="git add --patch"
alias gba="git branches"
alias gbd="git branch -D"
alias gca="git commit --amend --reuse-message HEAD"
alias gcob="git checkout -b"
alias gdc="git diff --cached"
alias gda="git add --intent-to-add --all && git diff"
alias gdtool="git difftool"
alias gdatool="git add --intent-to-add --all && git difftool"
alias gl="git l"
alias glb="git current-branch-log"
alias gla="git la"
alias glaa="git laa"
alias gpsa="git push --all && git push --tags"
alias gpst="git push --tags"
alias grm="git rm -r"
alias grs="git reset"
alias grsp="git reset --patch"
alias grv="git remote -v"

alias gcd="cd-gitroot"
alias gs="git pretty-status"
alias gss="git-status-overview"