# keybinds.zsh

# Set keybinds to emacs mode.
bindkey -e

bindkey '^Z' undo
bindkey '^R' redo

# Home key:
bindkey '\e[1~' beginning-of-line
bindkey '\e[H'  beginning-of-line
bindkey '\eOH'  beginning-of-line

# End key:
bindkey '\e[4~' end-of-line
bindkey '\e[F'  end-of-line
bindkey '\eOF'  end-of-line

bindkey '\e[3~' delete-char         # Delete key (forward delete)

bindkey '\e[2~' overwrite-mode      # Insert key (toggle overwrite mode)

bindkey '^[[1;5D' backward-word     # Ctrl+Left
bindkey '^[[1;5C' forward-word      # Ctrl+Right
bindkey '^H' backward-kill-word     # Ctrl+Backspace
WORDCHARS=${WORDCHARS//[-\/&._;]/}  # Delimiters for Sidesteppa

# TODO Add Shift_Ctrl_Arrow jumps ignoring delimiters
