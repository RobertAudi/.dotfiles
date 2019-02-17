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
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -boolean true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -boolean true
(( $status == 0 )) && ___done || ___error

___describe 'Expand print panel by default'
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -boolean true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -boolean true
(( $status == 0 )) && ___done || ___error

___describe 'Automatically quit printer app once the print jobs complete'
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -boolean true
(( $status == 0 )) && ___done || ___error

___describe 'Save to disk (not to iCloud) by default'
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -boolean false
(( $status == 0 )) && ___done || ___error

# More info: http://osxdaily.com/2016/08/17/disable-focus-ring-animation-mac-os/
___describe 'Disable the focus ring animation'
defaults write NSGlobalDomain NSUseAnimatedFocusRing -boolean false
(( $status == 0 )) && ___done || ___error

___describe 'Add a context menu item for showing the Web Inspector in web views'
defaults write NSGlobalDomain WebKitDeveloperExtras -boolean true
(( $status == 0 )) && ___done || ___error

___describe 'Disable automatic termination of inactive apps'
defaults write NSGlobalDomain NSDisableAutomaticTermination -boolean true
(( $status == 0 )) && ___done || ___error

# FIXME: Obsolete ??
# Look into it: https://www.idownloadblog.com/2017/04/20/fix-application-from-internet-gatekeeper/
# ___describe 'Disable the "Are you sure you want to open this application?" dialog'
# defaults write com.apple.LaunchServices LSQuarantine -boolean false
# (( $status == 0 )) && ___done || ___error

___describe 'Require password immediately after sleep or screen saver begins'
defaults write com.apple.screensaver askForPassword -integer 1
defaults write com.apple.screensaver askForPasswordDelay -integer 0
(( $status == 0 )) && ___done || ___error

___describe 'Disable the crash reporter'
defaults write com.apple.CrashReporter DialogType -string "none"
(( $status == 0 )) && ___done || ___error

___describe 'Disable Resume system-wide'
defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -boolean false
(( $status == 0 )) && ___done || ___error

___describe 'Disable Dashboard'
defaults write com.apple.dashboard mcx-disabled -boolean true
(( $status == 0 )) && ___done || ___error

# ------------------------------------------------------------------------------ }}}

# Activity Monitor {{{
# ------------------------------------------------------------------------------
# PList file: ~/Library/Preferences/com.apple.ActivityMonitor.plist
# ------------------------------------------------------------------------------
___section "Activity Monitor"

___describe 'Show the main window when launching Activity Monitor'
defaults write com.apple.ActivityMonitor OpenMainWindow -boolean true
(( $status == 0 )) && ___done || ___error

___describe 'Visualize CPU usage in the Activity Monitor Dock icon'
defaults write com.apple.ActivityMonitor IconType -integer 5
(( $status == 0 )) && ___done || ___error

___describe 'Show all processes in Activity Monitor'
defaults write com.apple.ActivityMonitor ShowCategory -integer 0
(( $status == 0 )) && ___done || ___error

___describe 'Sort Activity Monitor results by CPU usage'
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -integer 0
(( $status == 0 )) && ___done || ___error

# ------------------------------------------------------------------------------ }}}

# Disk Utility {{{
# ------------------------------------------------------------------------------
# PList file: ~/Library/Preferences/com.apple.DiskUtility.plist
# ------------------------------------------------------------------------------
___section "Disk Utility"

___describe 'Enable the debug menu in Disk Utility'
defaults write com.apple.DiskUtility DUDebugMenuEnabled -boolean true
defaults write com.apple.DiskUtility advanced-image-options -boolean true
(( $status == 0 )) && ___done || ___error

# ------------------------------------------------------------------------------ }}}

# Dock {{{
# ------------------------------------------------------------------------------
# PList file: ~/Library/Preferences/com.apple.dock.plist
# ------------------------------------------------------------------------------
___section "Dock"

___describe 'Set the icon size of Dock items to 64 pixels'
defaults write com.apple.dock tilesize -integer 64
(( $status == 0 )) && ___done || ___error

___describe "Minimize windows into their application's icon"
defaults write com.apple.dock minimize-to-application -boolean true
(( $status == 0 )) && ___done || ___error

___describe 'Show indicator lights for open applications in the Dock'
defaults write com.apple.dock show-process-indicators -boolean true
(( $status == 0 )) && ___done || ___error

___describe "Don't group windows by application in Mission Control"
# (i.e. use the old Exposé behavior instead)
defaults write com.apple.dock expose-group-by-app -boolean false
(( $status == 0 )) && ___done || ___error

___describe "Don't animate opening applications from the Dock"
defaults write com.apple.dock launchanim -boolean false
(( $status == 0 )) && ___done || ___error

___describe "Permanently Stop Dock Icons from Bouncing"
defaults write com.apple.dock no-bouncing -boolean true
(( $status == 0 )) && ___done || ___error

___describe "Don't show Dashboard as a Space"
defaults write com.apple.dock dashboard-in-overlay -boolean true
(( $status == 0 )) && ___done || ___error

___describe "Don't automatically rearrange Spaces based on most recent use"
defaults write com.apple.dock mru-spaces -boolean false
(( $status == 0 )) && ___done || ___error

___describe "Automatically hide and show the Dock"
defaults write com.apple.dock autohide -boolean true
(( $status == 0 )) && ___done || ___error

___describe "Make Dock icons of hidden applications translucent"
defaults write com.apple.dock showhidden -boolean true
(( $status == 0 )) && ___done || ___error

___describe "Show only open applications in the Dock"
defaults write com.apple.dock static-only -boolean true
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
defaults write com.apple.dock wvous-tl-corner -integer 3
defaults write com.apple.dock wvous-tl-modifier -integer 0
(( $status == 0 )) && ___done || ___error

___describe "Hot corner: Top right screen corner → Mission Control"
defaults write com.apple.dock wvous-tr-corner -integer 2
defaults write com.apple.dock wvous-tr-modifier -integer 0
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
defaults write NSGlobalDomain AppleShowAllExtensions -boolean true
(( $status == 0 )) && ___done || ___error

___describe "Enable spring loading for directories"
defaults write NSGlobalDomain com.apple.springing.enabled -boolean true
(( $status == 0 )) && ___done || ___error

___describe "Avoid creating .DS_Store files on network or USB volumes"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -boolean true
defaults write com.apple.desktopservices DSDontWriteUSBStores -boolean true
(( $status == 0 )) && ___done || ___error

# PList file: ~/Library/Preferences/com.apple.finder.plist
# ------------------------------------------------------------------------------

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

___describe "Disable the warning before emptying the Trash"
defaults write com.apple.finder WarnOnEmptyTrash -boolean false
(( $status == 0 )) && ___done || ___error

___describe "Use list view in all Finder windows by default"
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
defaults write com.apple.finder FXPreferredSearchViewStyle -string "Nlsv"
(( $status == 0 )) && ___done || ___error

___describe "Show icons for hard drives on the desktop"
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -boolean true
defaults write com.apple.finder ShowHardDrivesOnDesktop -boolean true
(( $status == 0 )) && ___done || ___error

___describe "Show icons for mounted servers on the desktop"
defaults write com.apple.finder ShowMountedServersOnDesktop -boolean true
(( $status == 0 )) && ___done || ___error

___describe "Show icons removable media on the desktop"
defaults write com.apple.finder ShowRemovableMediaOnDesktop -boolean true
(( $status == 0 )) && ___done || ___error

___describe "Do not open a new Finder window when a volume is mounted"
defaults write com.apple.finder OpenWindowForNewRemovableDisk -boolean false
(( $status == 0 )) && ___done || ___error

___describe "Allow text selection in Quick Look"
defaults write com.apple.finder QLEnableTextSelection -boolean true
(( $status == 0 )) && ___done || ___error

___describe 'Expand the following File Info panes: "General", "Open with", and "Sharing & Permissions"'
defaults write com.apple.finder FXInfoPanesExpanded -dict \
  General -boolean true \
  OpenWith -boolean true \
  Privileges -boolean true
(( $status == 0 )) && ___done || ___error

# ------------------------------------------------------------------------------ }}}

# Keyboard {{{
# ------------------------------------------------------------------------------
___section "Keyboard"

___describe "Disable press-and-hold for keys in favor of key repeat"
defaults write NSGlobalDomain ApplePressAndHoldEnabled -boolean false
(( $status == 0 )) && ___done || ___error

___describe "Set a fast keyboard repeat rate"
defaults write NSGlobalDomain KeyRepeat -integer 2
defaults write NSGlobalDomain InitialKeyRepeat -integer 15
(( $status == 0 )) && ___done || ___error

___describe "Don't illuminate built-in MacBook keyboard in low light"
defaults write com.apple.BezelServices kDim -boolean false
(( $status == 0 )) && ___done || ___error

___describe "Turn off keyboard illumination when computer is not used for 5 minutes"
defaults write com.apple.BezelServices kDimTime -integer 300
(( $status == 0 )) && ___done || ___error

# Text {{{
# ------------------------------------------------------------------------------

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

# ------------------------------------------------------------------------------ }}}

# Menu bar {{{
# ------------------------------------------------------------------------------
___section "Menu bar"

___describe "Show battery percentage"
defaults write com.apple.menuextra.battery ShowPercent -boolean true
(( $status == 0 )) && ___done || ___error

___describe "Hide remaining battery time" #  pre-10.8 ??
defaults write com.apple.menuextra.battery ShowTime -boolean false
(( $status == 0 )) && ___done || ___error

___describe "Set date and time format e.g. Sun 11 Aug 16:55"
defaults write com.apple.menuextra.clock DateFormat -string "E MMM d HH:mm"
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
defaults write com.apple.Safari ShowFullURLInSmartSearchField -boolean true
(( $status == 0 )) && ___done || ___error

___describe 'Prevent Safari from opening "safe" files automatically after downloading'
defaults write com.apple.Safari AutoOpenSafeDownloads -boolean false
(( $status == 0 )) && ___done || ___error

___describe "Hide Safari's bookmarks bar by default"
defaults write com.apple.Safari ShowFavoritesBar -boolean false
(( $status == 0 )) && ___done || ___error

___describe "Remove useless icons from Safari's bookmarks bar"
defaults write com.apple.Safari ProxiesInBookmarksBar "()"
(( $status == 0 )) && ___done || ___error

___describe "Hide Safari's sidebar in Top Sites"
defaults write com.apple.Safari ShowSidebarInTopSites -boolean false
(( $status == 0 )) && ___done || ___error

___describe "Enable Safari's debug menu"
defaults write com.apple.Safari IncludeInternalDebugMenu -boolean true
(( $status == 0 )) && ___done || ___error

___describe "Enable the Develop menu and the Web Inspector in Safari"
defaults write com.apple.Safari IncludeDevelopMenu -boolean true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -boolean true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -boolean true
(( $status == 0 )) && ___done || ___error

___describe "Allow hitting the Backspace key to go to the previous page in history"
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -boolean true
(( $status == 0 )) && ___done || ___error

___describe "Enable continuous spellchecking"
defaults write com.apple.Safari WebContinuousSpellCheckingEnabled -boolean true
(( $status == 0 )) && ___done || ___error

___describe "Disable auto-correct"
defaults write com.apple.Safari WebAutomaticSpellingCorrectionEnabled -boolean false
(( $status == 0 )) && ___done || ___error

___describe "Disable AutoFill"
defaults write com.apple.Safari AutoFillFromAddressBook -boolean false
defaults write com.apple.Safari AutoFillPasswords -boolean false
defaults write com.apple.Safari AutoFillCreditCardData -boolean false
defaults write com.apple.Safari AutoFillMiscellaneousForms -boolean false
(( $status == 0 )) && ___done || ___error

___describe "Warn about fraudulent websites"
defaults write com.apple.Safari WarnAboutFraudulentWebsites -boolean true
(( $status == 0 )) && ___done || ___error

___describe "Update extensions automatically"
defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -boolean true
(( $status == 0 )) && ___done || ___error

___describe "Disable plug-ins"
defaults write com.apple.Safari WebKitPluginsEnabled -boolean false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2PluginsEnabled -boolean false
(( $status == 0 )) && ___done || ___error

___describe "Disable Java"
defaults write com.apple.Safari WebKitJavaEnabled -boolean false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabled -boolean false
(( $status == 0 )) && ___done || ___error

___describe "Block pop-up windows"
defaults write com.apple.Safari WebKitJavaScriptCanOpenWindowsAutomatically -boolean false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically -boolean false
(( $status == 0 )) && ___done || ___error

___describe 'Enable "Do Not Track"'
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -boolean true
(( $status == 0 )) && ___done || ___error

___describe "Disable auto-playing video"
defaults write com.apple.Safari WebKitMediaPlaybackAllowsInline -boolean false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2AllowsInlineMediaPlayback -boolean false
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
defaults write com.apple.screencapture disable-shadow -boolean true
(( $status == 0 )) && ___done || ___error

# ------------------------------------------------------------------------------ }}}

# TextEdit {{{
# ------------------------------------------------------------------------------
# PList file: ~/Library/Preferences/com.apple.TextEdit.plist
# ------------------------------------------------------------------------------
___section "TextEdit"

___describe "Use plain text mode for new TextEdit documents"
defaults write com.apple.TextEdit RichText -integer 0
(( $status == 0 )) && ___done || ___error

___describe "Open and save files as UTF-8 in TextEdit"
defaults write com.apple.TextEdit PlainTextEncoding -integer 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -integer 4
(( $status == 0 )) && ___done || ___error

# ------------------------------------------------------------------------------ }}}

# Time Machine {{{
# ------------------------------------------------------------------------------
# PList file: ~/Library/Preferences/com.apple.TimeMachine.plist
# ------------------------------------------------------------------------------
___section "Time Machine"

___describe "Prevent Time Machine from prompting to use new hard drives as backup volume"
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -boolean true
(( $status == 0 )) && ___done || ___error

___describe "Disable local Time Machine backups"
{ hash tmutil && sudo tmutil disablelocal } &> /dev/null
(( $status == 0 )) && ___done || ___error

# ------------------------------------------------------------------------------ }}}

# Trackpad {{{
# ------------------------------------------------------------------------------
___section "Trackpad"

___describe 'Disable "natural" scrolling'
defaults write NSGlobalDomain com.apple.swipescrolldirection -boolean false
(( $status == 0 )) && ___done || ___error

# ------------------------------------------------------------------------------ }}}

# Google Chrome {{{
# ------------------------------------------------------------------------------
___section "Google Chrome"

___describe "Disable the all too sensitive backswipe on trackpads"
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -boolean false
(( $status == 0 )) && ___done || ___error

___describe "Use the system-native print preview dialog"
defaults write com.google.Chrome DisablePrintPreview -boolean true
(( $status == 0 )) && ___done || ___error

___describe "Expand the print dialog by default"
defaults write com.google.Chrome PMPrintingExpandedStateForPrint2 -boolean true
(( $status == 0 )) && ___done || ___error

# ------------------------------------------------------------------------------ }}}

# MacVim {{{
# ------------------------------------------------------------------------------
# PList file: ~/Library/Preferences/org.vim.MacVim.plist
# ------------------------------------------------------------------------------
___section "MacVim"

___describe "Enable software auto-update (Sparkle)"
defaults write org.vim.MacVim SUEnableAutomaticChecks -boolean true
(( $status == 0 )) && ___done || ___error

___describe "Check for software updates when MacVim launches"
defaults write org.vim.MacVim SUCheckAtStartup -boolean true
(( $status == 0 )) && ___done || ___error

___describe "Quit MacVim after last window closes"
defaults write org.vim.MacVim MMLastWindowClosedBehavior -integer 2
(( $status == 0 )) && ___done || ___error

___describe "Do not use the Core Text renderer"
defaults write org.vim.MacVim MMRenderer -integer 0
(( $status == 0 )) && ___done || ___error

___describe "Do not draw marked text inline"
defaults write org.vim.MacVim MMUseInlineIm -boolean false
(( $status == 0 )) && ___done || ___error

___describe "Disable Quickstart"
defaults write org.vim.MacVim MMPreloadCacheSize -boolean false
(( $status == 0 )) && ___done || ___error

___describe "Do not use native macOS full screen"
defaults write org.vim.MacVim MMNativeFullScreen -boolean false
(( $status == 0 )) && ___done || ___error

___describe "Never open untitled window"
defaults write org.vim.MacVim MMUntitledWindow -integer 0
(( $status == 0 )) && ___done || ___error

# ------------------------------------------------------------------------------ }}}

# Transmission {{{
# ------------------------------------------------------------------------------
# PList file: ~/Library/Preferences/org.m0k.transmission.plist
# ------------------------------------------------------------------------------

# Use `~/Documents/Torrents` to store incomplete downloads
defaults write org.m0k.transmission UseIncompleteDownloadFolder -boolean true
defaults write org.m0k.transmission IncompleteDownloadFolder -string "${HOME}/.tmp/torrents"

# Use `~/Downloads/torrents` to store completed downloads
defaults write org.m0k.transmission DownloadFolder -string "${HOME}/Downloads/torrents"
defaults write org.m0k.transmission DownloadLocationConstant -boolean true

# Trash original torrent files
defaults write org.m0k.transmission DeleteOriginalTorrent -boolean true

# Don't prompt for confirmation before removing non-downloading active transfers
defaults write org.m0k.transmission CheckRemoveDownloading -boolean true

defaults write org.m0k.transmission RemoveWhenFinishSeeding -boolean true

# defaults write org.m0k.transmission DownloadSound -string "Finish Him"

# IP block list.
# Source: https://giuliomac.wordpress.com/2014/02/19/best-blocklist-for-transmission/
defaults write org.m0k.transmission BlocklistNew -boolean true
defaults write org.m0k.transmission BlocklistURL -string "http://john.bitsurge.net/public/biglist.p2p.gz"
defaults write org.m0k.transmission BlocklistAutoUpdate -boolean true

# Hide the donate message
defaults write org.m0k.transmission WarningDonate -boolean false
# Hide the legal disclaimer
defaults write org.m0k.transmission WarningLegal -boolean false

# Randomize port on launch
defaults write org.m0k.transmission RandomPort -boolean true

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
killall "Transmission" &> /dev/null
# killall "Google Chrome" &> /dev/null

# ------------------------------------------------------------------------------ }}}

# Remove sudo timestamp
sudo -K

builtin print -P --  "\n\n%F{034}All done%f. Note that some of these changes require a logout/restart to take effect."
