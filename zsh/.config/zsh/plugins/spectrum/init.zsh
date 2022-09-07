#
# A script to make using 256 colors in zsh less painful.
#
#     +----------------------------------------------------------------------------------+
#     |                               R E F E R E N C E                                  |
#     |----------------------------------------------------------------------------------|
#     |                                       |  reset                         :  \e[00m |
#     |                                       |  normal                        :  \e[22m |
#     | bold                       :  \e[01m  |  no-bold                       :  \e[22m |
#     | dim                        :  \e[02m  |  no-dim                        :  \e[22m |
#     | italic                     :  \e[03m  |  no-italic                     :  \e[23m |
#     | underline                  :  \e[04m  |  no-underline                  :  \e[24m |
#     | blink                      :  \e[05m  |  no-blink                      :  \e[25m |
#     | fast-blink                 :  \e[06m  |  no-fast-blink                 :  \e[25m |
#     | reverse                    :  \e[07m  |  no-reverse                    :  \e[27m |
#     | conceal                    :  \e[08m  |  no-conceal                    :  \e[28m |
#     | strikethrough              :  \e[09m  |  no-strikethrough              :  \e[29m |
#     | gothic                     :  \e[20m  |  no-gothic                     :  \e[22m |
#     | double-underline           :  \e[21m  |  no-double-underline           :  \e[22m |
#     | proportional               :  \e[26m  |  no-proportional               :  \e[50m |
#     | overline                   :  \e[53m  |  no-overline                   :  \e[55m |
#     |---------------------------------------+------------------------------------------|
#     |                                       |  no-border                     :  \e[54m |
#     | border-rectangle           :  \e[51m  |  no-border-rectangle           :  \e[54m |
#     | border-circle              :  \e[52m  |  no-border-circle              :  \e[54m |
#     |---------------------------------------+------------------------------------------|
#     |                                       |  no-ideogram-marking           :  \e[65m |
#     | underline-or-right         :  \e[60m  |  no-underline-or-right         :  \e[65m |
#     | double-underline-or-right  :  \e[61m  |  no-double-underline-or-right  :  \e[65m |
#     | overline-or-left           :  \e[62m  |  no-overline-or-left           :  \e[65m |
#     | double-overline-or-left    :  \e[63m  |  no-double-overline-or-left    :  \e[65m |
#     | stress                     :  \e[64m  |  no-stress                     :  \e[65m |
#     |---------------------------------------+------------------------------------------|
#     |                                       |  font-default                  :  \e[10m |
#     | font-first                 :  \e[11m  |  no-font-first                 :  \e[10m |
#     | font-second                :  \e[12m  |  no-font-second                :  \e[10m |
#     | font-third                 :  \e[13m  |  no-font-third                 :  \e[10m |
#     | font-fourth                :  \e[14m  |  no-font-fourth                :  \e[10m |
#     | font-fifth                 :  \e[15m  |  no-font-fifth                 :  \e[10m |
#     | font-sixth                 :  \e[16m  |  no-font-sixth                 :  \e[10m |
#     | font-seventh               :  \e[17m  |  no-font-seventh               :  \e[10m |
#     | font-eigth                 :  \e[18m  |  no-font-eigth                 :  \e[10m |
#     | font-ninth                 :  \e[19m  |  no-font-ninth                 :  \e[10m |
#     +----------------------------------------------------------------------------------+
#

# Return if requirements are not found.
if [[ "$TERM" == "dumb" ]]; then
  return 1
fi

path=("$ZSH_HOME/plugins/spectrum/bin" $path)

typeset -g  SPECTRUM_TEXT
typeset -gA SPECTRUM_FG SPECTRUM_BG

SPECTRUM_TEXT="Have You Tried Turning it Off and On Again? •••"

SPECTRUM_FG=(
  black  000
  red    196
  green  006
  yellow 226
  blue   033
  white  255
  grey   245
  brown  130
  orange 208
  pink   206
  purple 129
)

SPECTRUM_BG=(
  black  000
  red    160
  green  006
  yellow 226
  blue   033
  white  255
  grey   245
  brown  130
  orange 208
  pink   206
  purple 129
)

function spectrum.ls.fg {
  for code in {000..255}; do
    print -P -- "$code: %F{$code}  ${1=$SPECTRUM_TEXT}  %f"
  done
}

function spectrum.ls.bg {
  for code in {000..255}; do
    print -P -- "$code: %K{$code}  ${1=$SPECTRUM_TEXT}  %k"
  done
}

function spectrum.ls {
  spectrum.ls.fg $1; spectrum.ls.bg $1
}

function spectrum.pp {
  local code=$1; shift
  print -P -- "%F{$code}$@%f"
}

function spectrum.puts {
  emulate -L zsh
  zparseopts -D -E -a opts -fg:=fg -bg:=bg -bold -underline

  local prefix suffix

  [[ -n "$fg" ]] && prefix+="%F{$SPECTRUM_FG[${(L)fg}]}" && suffix+="%f"
  [[ -n "$bg" ]] && prefix+="%K{$SPECTRUM_BG[${(L)bg}]}" && suffix+="%k"

  ((${+opts[(r)--bold]}))      && prefix+="%B" && suffix+="%b"
  ((${+opts[(r)--underline]})) && prefix+="%U" && suffix+="%u"

  print -P -- "${prefix}${@}${suffix}"
}

function spectrum.puts.fg {
  local color
  for color in ${(@k)SPECTRUM_FG}; do
    echo -n " --> ${(U)color} ($SPECTRUM_FG[$color]) --> "
    spectrum.puts --fg $color "${(U)color}"
  done
}

function spectrum.puts.bg {
  local color
  for color in ${(@k)SPECTRUM_BG}; do
    echo -n " --> ${(U)color} ($SPECTRUM_BG[$color]) --> "
    spectrum.puts --bg $color "${(U)color}"
  done
}

function spectrum.ap.16 {
  for i in {0..15}; do echo -e "\e[38;05;${i}m  ░▒▓██▓▒░ \e[0m${i}"; done | column -c 40 -s" "; echo -e "\e[m"
}

function spectrum.ap.256 {
  for i in {0..255}; do echo -e "\e[38;05;${i}m  ░▒▓██▓▒░ \e[0m${i}"; done | column -c 40 -s" "; echo -e "\e[m"
}

function spectrum.256colors() {
  for i in {0..255}; do
    printf "\033[48;5;%dm\033[38;5;15m %03d " $i $i
    printf "\033[33;5;0m\033[38;5;%dm %03d " $i $i
    (( i+1 <= 16 ? (i+1) % 8 :  ((i+1)-16) % 6  )) || printf "\033[0m\n"
    (( i+1 <= 16 ? (i+1) % 16 : ((i+1)-16) % 36 )) || printf "\033[0m\n"
  done
}
