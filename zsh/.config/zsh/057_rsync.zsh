# Aliases:
# --------
#
#   - `rsync-copy` copies files and directories from *source* to *destination*.
#   - `rsync-move` moves files and directories from *source* to *destination*.
#   - `rsync-update` updates files and directories on *destination*.
#   - `rsync-synchronize` synchronizes files and directories between *source* and *destination*.
#

alias rsync="noglob rsync --verbose --progress --human-readable --compress --archive --hard-links --one-file-system --acls --xattrs --crtimes --fileflags --protect-decmpfs --force-change"
alias rsync-copy="rsync"
alias rsync-move="rsync --remove-source-files"
alias rsync-update="rsync --update"
alias rsync-synchronize="rsync --update --delete"

# Show progress while file is copying
alias cpv="command rsync --human-readable --progress --archive --hard-links --acls --protect-decmpfs --crtimes --rsh=/dev/null --one-file-system --backup --backup-dir=/tmp/rsync --"
