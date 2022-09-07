#!/usr/bin/env zsh

emulate -L zsh

setopt pipe_fail

# Dependencies {{{
# ------------------------------------------------------------------------------------

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
# ------------------------------------------------------------------------------------ }}}

# Nerd fonts {{{
# ------------------------------------------------------------------------------------
command ghq get --update https://github.com/ryanoasis/nerd-fonts.git

local nerd_fonts_root=$(command ghq list --exact --full-path github.com/ryanoasis/nerd-fonts)

[[ -d "$nerd_fonts_root" ]] || return 1

local font_patcher
font_patcher="${nerd_fonts_root}/font-patcher"

[[ -f $font_patcher ]] || return 1

command chmod +x $font_patcher
# ------------------------------------------------------------------------------------ }}}

# JetBrains Mono {{{
# ------------------------------------------------------------------------------------
command ghq get --update https://github.com/JetBrains/JetBrainsMono.git

local jetbrains_mono_font_root=$(command ghq list --exact --full-path github.com/JetBrains/JetBrainsMono)

[[ -d "$jetbrains_mono_font_root" ]] || return 1
# ------------------------------------------------------------------------------------ }}}

# Patch fonts {{{
# ------------------------------------------------------------------------------------
local destination_dir
destination_dir="${XDG_DOWNLOAD_DIR-:$HOME/downloads}/fonts"

for font_type in "otf" "ttf"; do
  local font_dir="${jetbrains_mono_font_root}/fonts/${font_type}"

  if ! [[ -d "$font_dir" ]]; then
    builtin print -u 2 -- "Skipping font type: ${(U)font_type}"
    continue
  fi

  local font_type_destination_dir="${destination_dir}/${(U)font_type}"

  command mkdir -p "$font_type_destination_dir"

  for f in $(command find $font_dir -maxdepth 1 -type f -iname "*.${font_type}") ; do
    builtin print -- "Patching ${f:t}\n"

  #  --complete              Add all available Glyphs
  #  --adjust-line-height    Whether to adjust line heights (attempt to center powerline separators more evenly)
  #  --careful               Do not overwrite existing glyphs if detected
  #  --progressbars          Show percentage completion progress bars per Glyph Set
  #  --ext otf               Create OTF font
  #  --out [DIR]             Save fonts in [DIR]
  #
  #  Also hide the fontforge warnings
  fontforge -quiet -script $font_patcher \
    --complete \
    --adjust-line-height \
    --careful \
    --progressbars \
    -ext ${font_type} \
    -out $font_type_destination_dir \
    $f 2> /dev/null

    builtin print -- "DONE Patching ${f:t}"
    builtin print -- "\n------------------------\n"
  done
done
# ------------------------------------------------------------------------------------ }}}

builtin print -P -- "[%F{034}SUCCESS%f] All fonts patched"
