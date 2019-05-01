# Generate ctags-compatible tags files for Markdown documents.
#   https://github.com/jszakmeister/markdown2ctags
zplugin ice as"command" pick"markdown2ctags.py"
zplugin light jszakmeister/markdown2ctags

# local plugins
zplugin load _local/vim
