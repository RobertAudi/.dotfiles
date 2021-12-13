#!/usr/bin/env zsh

function main {
  emulate -L zsh

  setopt pipe_fail

  local json_response
  json_response="$(curl --fail --silent --request GET https://api.github.com/repos/junegunn/fzf/releases/latest 2>/dev/null)" \
    || return $status

  : ${FZF_HOME:=${HOME}/.local/opt/fzf}
  export FZF_HOME

  local latest_version version
  latest_version="$(builtin echo -E "$json_response" | jq -r '.name')"
  if (( $+commands[fzf] )) &>/dev/null; then
    version="$(command fzf --version | awk '{print $1}')"
  fi

  if [[ -z "$version" ]] || [[ -n "$latest_version" && "$version" != "$latest_version" ]]; then
    FZF_HOME="${HOME}/.local/opt/fzf"

    local release_notes download_url
    release_notes="$(builtin echo -E "$json_response" | jq -r '.body')"
    download_url="$(builtin echo -E "$json_response" | noglob jq -r '.assets[] | select(.browser_download_url | contains("darwin_arm64")) | .browser_download_url')"

    local fzf_tmux_download_url
    fzf_tmux_download_url="https://raw.githubusercontent.com/junegunn/fzf/${latest_version}/bin/fzf-tmux"

    local fzf_vim_plugin_download_url
    fzf_vim_plugin_download_url="https://raw.githubusercontent.com/junegunn/fzf/${latest_version}/plugin/fzf.vim"

    local fzf_vim_doc_download_url
    fzf_vim_doc_download_url="https://raw.githubusercontent.com/junegunn/fzf/${latest_version}/doc/fzf.txt"

    local manpage_download_url fzf_tmux_manpage_download_url
    manpage_download_url="https://raw.githubusercontent.com/junegunn/fzf/${latest_version}/man/man1/fzf.1"
    fzf_tmux_manpage_download_url="https://raw.githubusercontent.com/junegunn/fzf/${latest_version}/man/man1/fzf-tmux.1"

    builtin print -P -- "There is a new version of %Bfzf%b: %F{green}%B${latest_version}%b%f (Current version: %B${version}%b)"

    builtin print -- "\nRelease notes:"
    mdcat <(builtin echo -E "$release_notes") | pr --omit-header --indent=4
    builtin print -Pn -- "\n%B%F{019}"; hr "⋅"; builtin print -P -- "%f%b"

    command mkdir -p "$FZF_HOME"/{bin,man/man1,plugin,doc}

    (
      builtin cd -q "$FZF_HOME"

      builtin print -Pn -- "%F{blue}==>%f Downloading the latest binary..."
      builtin cd -q "$FZF_HOME"/bin

      local installation_tmpdir
      installation_tmpdir=$(mktemp --directory --quiet 2> /dev/null) || return $status

      command curl --silent --disable --fail --location --remote-name --output-dir "$installation_tmpdir" "$download_url" || return $status
      command unzip -o -qq "${installation_tmpdir}/${download_url:t}" || return $status

      chmod +x fzf
      builtin print -P -- "%F{green}Done%f"

      builtin print -Pn -- "%F{blue}==>%f Downloading fzf-tmux..."
      command curl --silent --disable --fail --location --remote-name "$fzf_tmux_download_url" || return $status
      chmod +x fzf-tmux
      builtin print -P -- "%F{green}Done%f"

      builtin print -Pn -- "%F{blue}==>%f Downloading the fzf Vim plugin..."
      builtin cd -q "$FZF_HOME"/plugin
      command curl --silent --disable --fail --location --remote-name "$fzf_vim_plugin_download_url" || return $status
      builtin cd -q "$FZF_HOME"/doc
      command curl --silent --disable --fail --location --remote-name "$fzf_vim_doc_download_url" || return $status
      builtin print -P -- "%F{green}Done%f"

      builtin print -Pn -- "%F{blue}==>%f Downloading manpages..."
      builtin cd -q "$FZF_HOME"/man/man1
      command curl --silent --disable --fail --location --remote-name "$manpage_download_url" || return $status
      command curl --silent --disable --fail --location --remote-name "$fzf_tmux_manpage_download_url" || return $status
      builtin print -P -- "%F{green}Done%f"
    )

    builtin print -P -- "\n%F{green}Done!%f"
  else
    builtin print -P -- "The latest version of %Bfzf%b is already installed: %F{green}%B${version}%b%f"
  fi
}

main
