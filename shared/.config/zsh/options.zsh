# options.zsh

# Remove an older command from history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

# Allow comments even in interactive shells.
setopt interactivecomments

# Don't fail on non-matching globs - they may be used by a command internally.
# This behaviour is more consistent with bash.
setopt +o nomatch
