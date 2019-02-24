ZSH_DEFAULT_PROMPT_CHAR="○"
ZSH_GIT_PROMPT_CHAR="±"
ZSH_HG_PROMPT_CHAR="☿"

git_prompt_info() {
  local git_ref="$(command git symbolic-ref --short HEAD 2> /dev/null)" || return
  local num_changes="$(command git status --porcelain | wc -l)"
  if (($num_changes > 0)); then
    num_changes=" %F{red}($num_changes%)%f"
  else
    num_changes=""
  fi

  echo "%F{cyan}$ZSH_GIT_PROMPT_CHAR%f %F{magenta}$git_ref%f$num_changes"
}

hg_prompt_info() {
  echo "%F{magenta}$ZSH_HG_PROMPT_CHAR%f"
}

prompt_vcs_info() {
  in-git-repo && echo " $(git_prompt_info)" && return
  hg root &>/dev/null && echo " $(hg_prompt_info)" && return
}

prompt_pwd() {
  local pwdstr="%1~"
  if [[ ${PWD:A} =~ $HOME ]]; then
    echo "%F{yellow}${(N)pwdstr}%f"
  else
    echo "%F{red}%B${(N)pwdstr}%b%f"
  fi
}

prompt_jobs() {
  local number_of_jobs=$(builtin jobs -s | wc -l)
  if (( $number_of_jobs > 0 )); then
    echo " %F{magenta}[${number_of_jobs}]%f"
  fi
}

genprompt() {
  local prompt
  prompt+="%F{blue}%B[%b"
  prompt+="$(prompt_pwd)"
  prompt+="$(prompt_vcs_info)"
  prompt+="%F{blue}%B]%b%f"
  prompt+="$(prompt_jobs)"
  prompt+="%F{%(?.green.red)} $ZSH_DEFAULT_PROMPT_CHAR %f"
  echo "$prompt"
}

PROMPT='$(genprompt)'
