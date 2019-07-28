# Command completion for homebrew services
#   https://github.com/vasyharan/zsh-brew-services/
zplugin ice wait"1" lucid
zplugin light vasyharan/zsh-brew-services

# Flushes the DNS cache on macOS without pain
#   https://github.com/eventi/noreallyjustfuckingstopalready
zplugin ice wait"1" lucid
zplugin light eventi/noreallyjustfuckingstopalready

# local plugins
zplugin ice wait"1" lucid
zplugin load _local/macos
