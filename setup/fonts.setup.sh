#!/usr/bin/env zsh

emulate -L zsh

setopt pipe_fail

if ! type gh &>/dev/null ; then
  builtin print -P -- "[%F{032}INFO%f] gh not installed."
  builtin print -P -- "[%F{032}INFO%f] Trying to install gh..."

  command brew install gh || return $status

  builtin print -P -- "[%F{032}INFO%f] gh auth status..."

  command gh auth status || return $status
fi

if ! type ghq &>/dev/null ; then
  builtin print -P -- "[%F{032}INFO%f] ghq not installed."
  builtin print -P -- "[%F{032}INFO%f] Trying to install ghq..."

  command brew install ghq || return $status
fi

if ! type unar &>/dev/null ; then
  builtin print -P -- "[%F{032}INFO%f] unar not installed."
  builtin print -P -- "[%F{032}INFO%f] Trying to install unar..."

  command brew install unar || return $status
fi

if ! type fontforge &>/dev/null ; then
  builtin print -P -- "[%F{032}INFO%f] fontforge not installed."
  builtin print -P -- "[%F{032}INFO%f] Trying to install fontforge..."

  command brew install fontforge || return $status
fi

command ghq get --update https://github.com/ryanoasis/nerd-fonts.git

local nerd_fonts_root=$(command ghq list --exact --full-path github.com/ryanoasis/nerd-fonts)

[[ -d "$nerd_fonts_root" ]] || return 1

local font_patcher
font_patcher="${nerd_fonts_root}/font-patcher"

[[ -f $font_patcher ]] || return 1

command chmod +x $font_patcher

local download_tmpdir
download_tmpdir=$(command mktemp --directory --quiet 2> /dev/null) || return $status

command gh release download \
  --repo JetBrains/JetBrainsMono \
  --pattern "JetBrainsMono-*.zip" \
  --dir $download_tmpdir || return $status

local font_archive
font_archive="$(command find $download_tmpdir -maxdepth 1 -type f -iname "JetBrainsMono-*.zip" -print -quit)" || return $status

local destination_dir
destination_dir="${XDG_DOWNLOAD_DIR-:$HOME/downloads}/fonts"

command mkdir -p $destination_dir

command unar -force-directory -output-directory $download_tmpdir $font_archive || return $status

local font_dir
fond_dir="${font_archive:r}/fonts/ttf"

[[ -d $fond_dir ]] || return 1

command find $fond_dir -maxdepth 1 -type f -iname "JetBrainsMonoNL-*.ttf" -delete || return $status

for f in $(command find $fond_dir -maxdepth 1 -type f -iname "*.ttf") ; do
  builtin print -- "Patching ${f:t}\n\n"

fontforge -script $font_patcher \
  --adjust-line-height \
  --careful \
  -ext ttf \
  -out $destination_dir \
  --progressbars \
  --complete \
  $f

  builtin print -- "DONE Patching ${f:t}"
  builtin print -- "\n------------------------\n"
done

rm -rf $download_tmpdir
