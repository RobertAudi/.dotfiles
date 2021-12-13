#!/usr/bin/env zsh

emulate -L zsh

autoload -Uz colors && colors

if [[ "$(uname -s | tr '[[:upper:]]' '[[:lower:]]')" != *'darwin'* ]]; then
  builtin print -P -- "%F{196}!!!%f Unable to run the macOS setup script when not using macOS" >&2
  return 1
fi

# Utils {{{
# ------------------------------------------------------------------------------

function ___section {
  local name="$@"
  builtin print -P -- "\n\n%F{032}  $name%f\n  %F{245}${(pl:${#name}::-:)}%f\n"
}

function ___describe {
  builtin print -Pn -- "%F{245}*%f $@..."
}

function ___done {
  builtin print -P -- "%F{034}DONE%f"
}

function ___error {
  builtin print -P -- "%F{196}ERROR%f"
}

# ------------------------------------------------------------------------------ }}}

# Close any open System Preferences panes, to prevent them from overriding
# settings we're about to change
osascript -e 'tell application "System Preferences" to quit'

# General {{{
# ------------------------------------------------------------------------------
___section "General"

___describe "Expand print panel by default"
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -boolean true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -boolean true
(( $status == 0 )) && ___done || ___error

# ------------------------------------------------------------------------------ }}}

# Dock {{{
# ------------------------------------------------------------------------------
# PList file: ~/Library/Preferences/com.apple.dock.plist
# ------------------------------------------------------------------------------
___section "Dock"

___describe "Automatically hide and show the Dock"
defaults write com.apple.dock autohide -boolean true
(( $status == 0 )) && ___done || ___error

___describe "Do not display recent apps in the Dock"
defaults write com.apple.dock "show-recents" -boolean false

# ------------------------------------------------------------------------------ }}}

# Hot corners {{{
# ------------------------------------------------------------------------------
# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center

___describe "Hot corner: Top left screen corner → Show application windows"
defaults write com.apple.dock wvous-tl-corner -integer 3
defaults write com.apple.dock wvous-tl-modifier -integer 0
(( $status == 0 )) && ___done || ___error

___describe "Hot corner: Top right screen corner → Mission Control"
defaults write com.apple.dock wvous-tr-corner -integer 2
defaults write com.apple.dock wvous-tr-modifier -integer 0
(( $status == 0 )) && ___done || ___error

# ------------------------------------------------------------------------------ }}}

# Finder {{{
# ------------------------------------------------------------------------------
___section "Finder"

___describe "Show the ~/Library folder"
chflags nohidden ~/Library
(( $status == 0 )) && ___done || ___error

___describe "Show all filename extensions"
defaults write NSGlobalDomain AppleShowAllExtensions -boolean true
(( $status == 0 )) && ___done || ___error

___describe "Show status bar"
defaults write com.apple.finder ShowStatusBar -boolean true
(( $status == 0 )) && ___done || ___error

___describe "Show path bar"
defaults write com.apple.finder ShowPathbar -boolean true
(( $status == 0 )) && ___done || ___error

___describe "Show sidebar"
defaults write com.apple.finder ShowSidebar -boolean true
(( $status == 0 )) && ___done || ___error

___describe "Show tab bar"
defaults write com.apple.finder ShowTabView -boolean true
(( $status == 0 )) && ___done || ___error

___describe "Display full POSIX path as Finder window title"
defaults write com.apple.finder _FXShowPosixPathInTitle -boolean true
(( $status == 0 )) && ___done || ___error

___describe "Keep folders on top when sorting by name"
defaults write com.apple.finder _FXSortFoldersFirst -boolean true
(( $status == 0 )) && ___done || ___error

___describe "When performing a search, search the current folder by default"
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
(( $status == 0 )) && ___done || ___error

___describe "Disable the warning when changing a file extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -boolean false
(( $status == 0 )) && ___done || ___error

___describe "Expand the following File Info panes: \"General\", \"More Info\" and \"Open with\""
defaults write com.apple.finder FXInfoPanesExpanded -dict \
  General    -boolean true  \
  MetaData   -boolean true  \
  Name       -boolean false \
  OpenWith   -boolean true  \
  Preview    -boolean false \
  Privileges -boolean false
(( $status == 0 )) && ___done || ___error

___describe "Set keyboard shortcuts"
# Note: "@$" refers to Command+Shift
defaults write at.eggerapps.Postico NSUserKeyEquivalents -dict Downloads "@$d"
(( $status == 0 )) && ___done || ___error

# ------------------------------------------------------------------------------ }}}

# Keyboard {{{
# ------------------------------------------------------------------------------
___section "Keyboard"

___describe "Disable press-and-hold for keys in favor of key repeat"
defaults write NSGlobalDomain ApplePressAndHoldEnabled -boolean false
(( $status == 0 )) && ___done || ___error

___describe "Set a fast keyboard repeat rate"
defaults write NSGlobalDomain KeyRepeat -integer 6
defaults write NSGlobalDomain InitialKeyRepeat -integer 35
(( $status == 0 )) && ___done || ___error

___describe "Disable automatic capitalization as it's annoying when typing code"
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -boolean false
(( $status == 0 )) && ___done || ___error

___describe "Disable smart dashes as they're annoying when typing code"
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -boolean false
(( $status == 0 )) && ___done || ___error

___describe "Disable smart quotes as they're annoying when typing code"
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -boolean false
(( $status == 0 )) && ___done || ___error

___describe "Disable automatic period substitution as it's annoying when typing code"
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -boolean false
(( $status == 0 )) && ___done || ___error

___describe "Disable auto-correct"
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -boolean false
(( $status == 0 )) && ___done || ___error

# ------------------------------------------------------------------------------ }}}

# Screenshots {{{
# ------------------------------------------------------------------------------
___section "Screenshots"

___describe "Save screenshots to the ~/Pictures/Screenshots"
/bin/mkdir -p -m 700 "${HOME}/Pictures/Screenshots"
defaults write com.apple.screencapture location -string "${HOME}/Pictures/Screenshots"
(( $status == 0 )) && ___done || ___error

# ------------------------------------------------------------------------------ }}}

# TextEdit {{{
# ------------------------------------------------------------------------------
# PList file: ~/Library/Preferences/com.apple.TextEdit.plist
# ------------------------------------------------------------------------------
___section "TextEdit"

___describe "Use plain text mode for new TextEdit documents"
defaults write com.apple.TextEdit RichText -boolean false
(( $status == 0 )) && ___done || ___error

# ------------------------------------------------------------------------------ }}}

# Trackpad {{{
# ------------------------------------------------------------------------------
___section "Trackpad"

___describe "Disable \"natural\" scrolling"
defaults write NSGlobalDomain com.apple.swipescrolldirection -boolean false
(( $status == 0 )) && ___done || ___error

# ------------------------------------------------------------------------------ }}}

# Postico {{{
# ------------------------------------------------------------------------------
___section "Postico"

___describe "Alternate row background color"
defaults write at.eggerapps.Postico AlternatingRows -boolean true
(( $status == 0 )) && ___done || ___error

___describe "Disable trackpad gestures"
defaults write at.eggerapps.Postico EnableGestures -boolean false
(( $status == 0 )) && ___done || ___error

___describe "Indent SQL with spaces"
defaults write at.eggerapps.Postico IndentWithSpaces -boolean true
(( $status == 0 )) && ___done || ___error

___describe "Set keyboard shortcuts"
# Note: "@" refers to the Command key
defaults write at.eggerapps.Postico NSUserKeyEquivalents -dict \
  "Table Contents" "@1" \
  "Table DDL" "@3" \
  "Table Structure" "@2"
(( $status == 0 )) && ___done || ___error

# ------------------------------------------------------------------------------ }}}

builtin print -P --  "\n\n%F{034}All done%f."
