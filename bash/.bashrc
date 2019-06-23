for f in ~/.bash/*.{ba,}sh; do
  source $f
done

# Use case-insensitive filename globbing.
shopt -s nocaseglob

# Don't put duplicate lines in the history.
export HISTCONTROL=ignoredups

# Ignore some controlling instructions.
export HISTIGNORE="[   ]*:&:bg:fg:exit"
