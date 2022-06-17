#!/usr/bin/env zsh

mkdir -pv $HOME/.local

typeset submodule submodule_path
for submodule in $(git submodule--helper list | awk '{ print $4 }'); do
  [[ "$submodule" =~ "setup\/packages" ]] || continue

  builtin print -- "==> ${submodule##setup/packages/}"

  submodule_path="${DOTFILES_DIR:-${HOME}/.dotfiles}/${submodule}"

  [[ -d "$submodule_path" ]] || continue

  (cd -q "$submodule_path" && make && make install PREFIX=$HOME/.local && make clean)

  builtin print -- "---\n"
done

unset submodule submodule_path
