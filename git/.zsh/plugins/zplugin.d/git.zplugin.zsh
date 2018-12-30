# Open the GitHub page or website for a repository in your browser.
#   https://github.com/paulirish/git-open
zplugin ice as"command" pick"git-open"
zplugin light paulirish/git-open

# Text-based git log graph viewer
#   https://github.com/takaaki-kasai/git-foresta
zplugin ice as"command" pick"git-foresta"
zplugin light takaaki-kasai/git-foresta

# Completely remove a file from a git repository
#   https://github.com/nachoparker/git-forget-blob
#   https://ownyourbits.com/2017/01/18/completely-remove-a-file-from-a-git-repository-with-git-forget-blob/
zplugin ice as"command" cp"git-forget-blob.sh -> git-forget-blob" pick"git-forget-blob"
zplugin light nachoparker/git-forget-blob

# local plugins
zplugin load _local/git
