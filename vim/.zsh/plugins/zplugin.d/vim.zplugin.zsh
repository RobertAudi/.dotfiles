# Generate ctags-compatible tags files for Markdown documents.
#   https://github.com/jszakmeister/markdown2ctags
zplugin ice as"command" pick"markdown2ctags.py" wait"1" lucid
zplugin light jszakmeister/markdown2ctags

# local plugins
zplugin ice wait"1" lucid
zplugin load _local/vim
