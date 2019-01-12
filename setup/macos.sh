#!/usr/bin/env zsh

emulate -L zsh

autoload -Uz colors && colors

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

# Sudo loop {{{
# ------------------------------------------------------------------------------

# Remove sudo timestamp
sudo -K

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` timestamp until this script has finished running
while true; do
  sleep 60
  sudo -n true
  kill -0 "$$" || return
done 2>/dev/null &

# ------------------------------------------------------------------------------ }}}

# General {{{
# ------------------------------------------------------------------------------
___section "General"

___describe 'Expand save panel by default'
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
(( $status == 0 )) && ___done || ___error

___describe 'Expand print panel by default'
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true
(( $status == 0 )) && ___done || ___error

___describe 'Automatically quit printer app once the print jobs complete'
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true
(( $status == 0 )) && ___done || ___error

___describe 'Save to disk (not to iCloud) by default'
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
(( $status == 0 )) && ___done || ___error

___describe 'Add a context menu item for showing the Web Inspector in web views'
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true
(( $status == 0 )) && ___done || ___error

___describe 'Disable automatic termination of inactive apps'
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true
(( $status == 0 )) && ___done || ___error

___describe 'Disable the "Are you sure you want to open this application?" dialog'
defaults write com.apple.LaunchServices LSQuarantine -bool false
(( $status == 0 )) && ___done || ___error

___describe 'Require password immediately after sleep or screen saver begins'
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0
(( $status == 0 )) && ___done || ___error

___describe 'Disable the crash reporter'
defaults write com.apple.CrashReporter DialogType -string "none"
(( $status == 0 )) && ___done || ___error

___describe 'Disable Resume system-wide'
defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false
(( $status == 0 )) && ___done || ___error

___describe 'Disable Dashboard'
defaults write com.apple.dashboard mcx-disabled -bool true
(( $status == 0 )) && ___done || ___error

# ------------------------------------------------------------------------------ }}}

# Activity Monitor {{{
# ------------------------------------------------------------------------------
# PList file: ~/Library/Preferences/com.apple.ActivityMonitor.plist
# ------------------------------------------------------------------------------
___section "Activity Monitor"

___describe 'Show the main window when launching Activity Monitor'
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true
(( $status == 0 )) && ___done || ___error

___describe 'Visualize CPU usage in the Activity Monitor Dock icon'
defaults write com.apple.ActivityMonitor IconType -int 5
(( $status == 0 )) && ___done || ___error

___describe 'Show all processes in Activity Monitor'
defaults write com.apple.ActivityMonitor ShowCategory -int 0
(( $status == 0 )) && ___done || ___error

___describe 'Sort Activity Monitor results by CPU usage'
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0
(( $status == 0 )) && ___done || ___error

# ------------------------------------------------------------------------------ }}}

# Disk Utility {{{
# ------------------------------------------------------------------------------
# PList file: ~/Library/Preferences/com.apple.DiskUtility.plist
# ------------------------------------------------------------------------------
___section "Disk Utility"

___describe 'Enable the debug menu in Disk Utility'
defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
defaults write com.apple.DiskUtility advanced-image-options -bool true
(( $status == 0 )) && ___done || ___error

# ------------------------------------------------------------------------------ }}}

# Dock {{{
# ------------------------------------------------------------------------------
# PList file: ~/Library/Preferences/com.apple.dock.plist
# ------------------------------------------------------------------------------
___section "Dock"

___describe 'Set the icon size of Dock items to 64 pixels'
defaults write com.apple.dock tilesize -int 64
(( $status == 0 )) && ___done || ___error

___describe "Minimize windows into their application's icon"
defaults write com.apple.dock minimize-to-application -bool true
(( $status == 0 )) && ___done || ___error

___describe 'Show indicator lights for open applications in the Dock'
defaults write com.apple.dock show-process-indicators -bool true
(( $status == 0 )) && ___done || ___error

___describe "Don't group windows by application in Mission Control"
# (i.e. use the old Exposé behavior instead)
defaults write com.apple.dock expose-group-by-app -bool false
(( $status == 0 )) && ___done || ___error

___describe "Don't animate opening applications from the Dock"
defaults write com.apple.dock launchanim -bool false
(( $status == 0 )) && ___done || ___error

___describe "Don't show Dashboard as a Space"
defaults write com.apple.dock dashboard-in-overlay -bool true
(( $status == 0 )) && ___done || ___error

___describe "Don't automatically rearrange Spaces based on most recent use"
defaults write com.apple.dock mru-spaces -bool false
(( $status == 0 )) && ___done || ___error

___describe "Automatically hide and show the Dock"
defaults write com.apple.dock autohide -bool true
(( $status == 0 )) && ___done || ___error

___describe "Make Dock icons of hidden applications translucent"
defaults write com.apple.dock showhidden -bool true
(( $status == 0 )) && ___done || ___error

___describe "Show only open applications in the Dock"
defaults write com.apple.dock static-only -bool true
(( $status == 0 )) && ___done || ___error

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
defaults write com.apple.dock wvous-tl-corner -int 3
defaults write com.apple.dock wvous-tl-modifier -int 0
(( $status == 0 )) && ___done || ___error

___describe "Hot corner: Top right screen corner → Mission Control"
defaults write com.apple.dock wvous-tr-corner -int 2
defaults write com.apple.dock wvous-tr-modifier -int 0
(( $status == 0 )) && ___done || ___error

# ------------------------------------------------------------------------------ }}}

# ------------------------------------------------------------------------------ }}}

# Finder {{{
# ------------------------------------------------------------------------------
___section "Finder"

___describe "Show the ~/Library folder"
chflags nohidden ~/Library
(( $status == 0 )) && ___done || ___error

___describe "Show the /Volumes folder"
sudo chflags nohidden /Volumes
(( $status == 0 )) && ___done || ___error

___describe "Show all filename extensions"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
(( $status == 0 )) && ___done || ___error

___describe "Enable spring loading for directories"
defaults write NSGlobalDomain com.apple.springing.enabled -bool true
(( $status == 0 )) && ___done || ___error

___describe "Avoid creating .DS_Store files on network or USB volumes"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
(( $status == 0 )) && ___done || ___error

# PList file: ~/Library/Preferences/com.apple.finder.plist
# ------------------------------------------------------------------------------

___describe "Show status bar"
defaults write com.apple.finder ShowStatusBar -bool true
(( $status == 0 )) && ___done || ___error

___describe "Show path bar"
defaults write com.apple.finder ShowPathbar -bool true
(( $status == 0 )) && ___done || ___error

___describe "Show sidebar"
defaults write com.apple.finder ShowSidebar -bool true
(( $status == 0 )) && ___done || ___error

___describe "Show tab bar"
defaults write com.apple.finder ShowTabView -bool true
(( $status == 0 )) && ___done || ___error

___describe "Display full POSIX path as Finder window title"
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
(( $status == 0 )) && ___done || ___error

___describe "Keep folders on top when sorting by name"
defaults write com.apple.finder _FXSortFoldersFirst -bool true
(( $status == 0 )) && ___done || ___error

___describe "When performing a search, search the current folder by default"
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
(( $status == 0 )) && ___done || ___error

___describe "Disable the warning when changing a file extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
(( $status == 0 )) && ___done || ___error

___describe "Disable the warning before emptying the Trash"
defaults write com.apple.finder WarnOnEmptyTrash -bool false
(( $status == 0 )) && ___done || ___error

___describe "Use list view in all Finder windows by default"
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
defaults write com.apple.finder FXPreferredSearchViewStyle -string "Nlsv"
(( $status == 0 )) && ___done || ___error

___describe "Show icons for hard drives on the desktop"
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
(( $status == 0 )) && ___done || ___error

___describe "Show icons for mounted servers on the desktop"
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
(( $status == 0 )) && ___done || ___error

___describe "Show icons removable media on the desktop"
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
(( $status == 0 )) && ___done || ___error

___describe "Do not open a new Finder window when a volume is mounted"
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool false
(( $status == 0 )) && ___done || ___error

___describe "Allow text selection in Quick Look"
defaults write com.apple.finder QLEnableTextSelection -bool true
(( $status == 0 )) && ___done || ___error

___describe 'Expand the following File Info panes: "General", "Open with", and "Sharing & Permissions"'
defaults write com.apple.finder FXInfoPanesExpanded -dict \
  General -bool true \
  OpenWith -bool true \
  Privileges -bool true
(( $status == 0 )) && ___done || ___error

# ------------------------------------------------------------------------------ }}}

# Keyboard {{{
# ------------------------------------------------------------------------------
___section "Keyboard"

___describe "Disable press-and-hold for keys in favor of key repeat"
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
(( $status == 0 )) && ___done || ___error

___describe "Set a fast keyboard repeat rate"
defaults write NSGlobalDomain KeyRepeat -int 6
defaults write NSGlobalDomain InitialKeyRepeat -int 15
(( $status == 0 )) && ___done || ___error

___describe "Don't illuminate built-in MacBook keyboard in low light"
defaults write com.apple.BezelServices kDim -bool false
(( $status == 0 )) && ___done || ___error

___describe "Turn off keyboard illumination when computer is not used for 5 minutes"
defaults write com.apple.BezelServices kDimTime -int 300
(( $status == 0 )) && ___done || ___error

# Text {{{
# ------------------------------------------------------------------------------

___describe "Disable automatic capitalization as it's annoying when typing code"
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
(( $status == 0 )) && ___done || ___error

___describe "Disable smart dashes as they're annoying when typing code"
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
(( $status == 0 )) && ___done || ___error

___describe "Disable smart quotes as they're annoying when typing code"
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
(( $status == 0 )) && ___done || ___error

___describe "Disable automatic period substitution as it's annoying when typing code"
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
(( $status == 0 )) && ___done || ___error

___describe "Disable auto-correct"
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
(( $status == 0 )) && ___done || ___error

# ------------------------------------------------------------------------------ }}}

# ------------------------------------------------------------------------------ }}}

# Menu bar {{{
# ------------------------------------------------------------------------------
___section "Menu bar"

___describe "Show battery percentage"
defaults write com.apple.menuextra.battery ShowPercent -bool true
(( $status == 0 )) && ___done || ___error

___describe "Hide remaining battery time" #  pre-10.8 ??
defaults write com.apple.menuextra.battery ShowTime -bool false
(( $status == 0 )) && ___done || ___error

___describe "Set date and time format e.g. Sun 11 Aug 16:55"
defaults write com.apple.menuextra.clock DateFormat -string "E MMM d HH:mm"
(( $status == 0 )) && ___done || ___error

# ------------------------------------------------------------------------------ }}}

# Messages.app {{{
# ------------------------------------------------------------------------------
# PList file: ~/Library/Preferences/com.apple.messageshelper.MessageController.plist
# ------------------------------------------------------------------------------
___section "Messages.app"

___describe "Disable automatic emoji substitution (i.e. use plain text smileys)"
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticEmojiSubstitutionEnablediMessage" -bool false
(( $status == 0 )) && ___done || ___error

___describe "Disable smart quotes as it's annoying for messages that contain code"
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticQuoteSubstitutionEnabled" -bool false
(( $status == 0 )) && ___done || ___error

___describe "Disable continuous spell checking"
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "continuousSpellCheckingEnabled" -bool false
(( $status == 0 )) && ___done || ___error

___describe "Disable automatic spelling correction"
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "continuousSpellCheckingEnabled" -bool false
(( $status == 0 )) && ___done || ___error

# ------------------------------------------------------------------------------ }}}

# Photos.app {{{
# ------------------------------------------------------------------------------
___section "Photos.app"

___describe "Prevent Photos from opening automatically when devices are plugged in"
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true
(( $status == 0 )) && ___done || ___error

# ------------------------------------------------------------------------------ }}}

# Safari {{{
# ------------------------------------------------------------------------------
# PList file: ~/Library/Preferences/com.apple.Safari.plist
# ------------------------------------------------------------------------------
___section "Safari"

___describe "Set Safari's home page to 'about:blank' for faster loading"
defaults write com.apple.Safari HomePage -string "about:blank"
(( $status == 0 )) && ___done || ___error

___describe "Show the full URL in the address bar"
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true
(( $status == 0 )) && ___done || ___error

___describe 'Prevent Safari from opening "safe" files automatically after downloading'
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false
(( $status == 0 )) && ___done || ___error

___describe "Hide Safari's bookmarks bar by default"
defaults write com.apple.Safari ShowFavoritesBar -bool false
(( $status == 0 )) && ___done || ___error

___describe "Remove useless icons from Safari's bookmarks bar"
defaults write com.apple.Safari ProxiesInBookmarksBar "()"
(( $status == 0 )) && ___done || ___error

___describe "Hide Safari's sidebar in Top Sites"
defaults write com.apple.Safari ShowSidebarInTopSites -bool false
(( $status == 0 )) && ___done || ___error

___describe "Enable Safari's debug menu"
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
(( $status == 0 )) && ___done || ___error

___describe "Enable the Develop menu and the Web Inspector in Safari"
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
(( $status == 0 )) && ___done || ___error

___describe "Allow hitting the Backspace key to go to the previous page in history"
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true
(( $status == 0 )) && ___done || ___error

___describe "Enable continuous spellchecking"
defaults write com.apple.Safari WebContinuousSpellCheckingEnabled -bool true
(( $status == 0 )) && ___done || ___error

___describe "Disable auto-correct"
defaults write com.apple.Safari WebAutomaticSpellingCorrectionEnabled -bool false
(( $status == 0 )) && ___done || ___error

___describe "Disable AutoFill"
defaults write com.apple.Safari AutoFillFromAddressBook -bool false
defaults write com.apple.Safari AutoFillPasswords -bool false
defaults write com.apple.Safari AutoFillCreditCardData -bool false
defaults write com.apple.Safari AutoFillMiscellaneousForms -bool false
(( $status == 0 )) && ___done || ___error

___describe "Warn about fraudulent websites"
defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool true
(( $status == 0 )) && ___done || ___error

___describe "Update extensions automatically"
defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -bool true
(( $status == 0 )) && ___done || ___error

___describe "Disable plug-ins"
defaults write com.apple.Safari WebKitPluginsEnabled -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2PluginsEnabled -bool false
(( $status == 0 )) && ___done || ___error

___describe "Disable Java"
defaults write com.apple.Safari WebKitJavaEnabled -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabled -bool false
(( $status == 0 )) && ___done || ___error

___describe "Block pop-up windows"
defaults write com.apple.Safari WebKitJavaScriptCanOpenWindowsAutomatically -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically -bool false
(( $status == 0 )) && ___done || ___error

___describe 'Enable "Do Not Track"'
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true
(( $status == 0 )) && ___done || ___error

___describe "Disable auto-playing video"
defaults write com.apple.Safari WebKitMediaPlaybackAllowsInline -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2AllowsInlineMediaPlayback -bool false
(( $status == 0 )) && ___done || ___error

# ------------------------------------------------------------------------------ }}}

# Screenshots {{{
# ------------------------------------------------------------------------------
___section "Screenshots"

___describe "Save screenshots to the ~/Pictures/Screenshots"
/bin/mkdir -p -m 700 "${HOME}/Pictures/Screenshots"
defaults write com.apple.screencapture location -string "${HOME}/Pictures/Screenshots"
(( $status == 0 )) && ___done || ___error

___describe "Save screenshots in PNG format"
# Other options: BMP, GIF, JPG, PDF, TIFF
defaults write com.apple.screencapture type -string "png"
(( $status == 0 )) && ___done || ___error

___describe "Disable shadow in screenshots"
defaults write com.apple.screencapture disable-shadow -bool true
(( $status == 0 )) && ___done || ___error

# ------------------------------------------------------------------------------ }}}

# TextEdit {{{
# ------------------------------------------------------------------------------
# PList file: ~/Library/Preferences/com.apple.TextEdit.plist
# ------------------------------------------------------------------------------
___section "TextEdit"

___describe "Use plain text mode for new TextEdit documents"
defaults write com.apple.TextEdit RichText -int 0
(( $status == 0 )) && ___done || ___error

___describe "Open and save files as UTF-8 in TextEdit"
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4
(( $status == 0 )) && ___done || ___error

# ------------------------------------------------------------------------------ }}}

# Time Machine {{{
# ------------------------------------------------------------------------------
# PList file: ~/Library/Preferences/com.apple.TimeMachine.plist
# ------------------------------------------------------------------------------
___section "Time Machine"

___describe "Prevent Time Machine from prompting to use new hard drives as backup volume"
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true
(( $status == 0 )) && ___done || ___error

___describe "Disable local Time Machine backups"
{ hash tmutil && sudo tmutil disablelocal } &> /dev/null
(( $status == 0 )) && ___done || ___error

# ------------------------------------------------------------------------------ }}}

# Trackpad {{{
# ------------------------------------------------------------------------------
___section "Trackpad"

___describe 'Disable "natural" scrolling'
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false
(( $status == 0 )) && ___done || ___error

# ------------------------------------------------------------------------------ }}}

# Google Chrome {{{
# ------------------------------------------------------------------------------
___section "Google Chrome"

___describe "Disable the all too sensitive backswipe on trackpads"
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false
(( $status == 0 )) && ___done || ___error

___describe "Use the system-native print preview dialog"
defaults write com.google.Chrome DisablePrintPreview -bool true
(( $status == 0 )) && ___done || ___error

___describe "Expand the print dialog by default"
defaults write com.google.Chrome PMPrintingExpandedStateForPrint2 -bool true
(( $status == 0 )) && ___done || ___error

# ------------------------------------------------------------------------------ }}}

# MacVim {{{
# ------------------------------------------------------------------------------
# PList file: ~/Library/Preferences/org.vim.MacVim.plist
# ------------------------------------------------------------------------------
___section "MacVim"

___describe "Enable software auto-update (Sparkle)"
defaults write org.vim.MacVim SUEnableAutomaticChecks -bool true
(( $status == 0 )) && ___done || ___error

___describe "Check for software updates when MacVim launches"
defaults write org.vim.MacVim SUCheckAtStartup -bool true
(( $status == 0 )) && ___done || ___error

___describe "Quit MacVim after last window closes"
defaults write org.vim.MacVim MMLastWindowClosedBehavior -int 2
(( $status == 0 )) && ___done || ___error

___describe "Do not use the Core Text renderer"
defaults write org.vim.MacVim MMRenderer -int 0
(( $status == 0 )) && ___done || ___error

___describe "Do not draw marked text inline"
defaults write org.vim.MacVim MMUseInlineIm -bool false
(( $status == 0 )) && ___done || ___error

___describe "Disable Quickstart"
defaults write org.vim.MacVim MMPreloadCacheSize -bool false
(( $status == 0 )) && ___done || ___error

___describe "Do not use native macOS full screen"
defaults write org.vim.MacVim MMNativeFullScreen -bool false
(( $status == 0 )) && ___done || ___error

___describe "Never open untitled window"
defaults write org.vim.MacVim MMUntitledWindow -int 0
(( $status == 0 )) && ___done || ___error

# ------------------------------------------------------------------------------ }}}

# Kill affected applications {{{
# ------------------------------------------------------------------------------

killall "Activity Monitor" &> /dev/null
killall "Disk Utility" &> /dev/null
killall "Dashboard" &> /dev/null
killall "Dock" &> /dev/null
killall "Finder" &> /dev/null
killall "NotificationCenter" &> /dev/null
killall "SystemUIServer" &> /dev/null # Menu bar
killall "cfprefsd" &> /dev/null # ???
# killall "Messages" &> /dev/null
killall "Photos" &> /dev/null
# killall "Safari" &> /dev/null
# killall "TextEdit" &> /dev/null
# killall "Address Book" &> /dev/null
# killall "Calendar" &> /dev/null
# killall "Contacts" &> /dev/null
# killall "Terminal" &> /dev/null
# killall "Google Chrome" &> /dev/null

# ------------------------------------------------------------------------------ }}}

# Remove sudo timestamp
sudo -K

builtin print -P --  "\n\n%F{034}All done%f. Note that some of these changes require a logout/restart to take effect."
