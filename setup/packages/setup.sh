#!/usr/bin/env zsh

mkdir -pv $HOME/.local

typeset submodule submodule_relative_path
for submodule in $(git submodule--helper list | awk '{ print $4 }'); do
  [[ "$submodule" =~ "setup\/packages" ]] || continue

  builtin print -- "==> ${submodule##setup/packages/}"

  submodule_relative_path="$(git submodule--helper relative-path "$submodule" $PWD)" || continue

  [[ -d "$submodule_relative_path" ]] || continue

  (cd -q "$submodule_relative_path" && git pull && make && make install PREFIX=$HOME/.local && make clean)

  builtin print -- "---\n"
done

unset submodule submodule_relative_path
