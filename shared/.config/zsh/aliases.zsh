# aliases.zsh

# Cute ls/ll and other utility
alias la='eza -a --icons'
alias ls='eza --icons --color=always --group-directories-first'
alias ll='eza -lah --icons --git --group-directories-first'
alias lt='eza -T -a --icons --ignore-glob ".git*" --level=2'
alias tree='eza -T -a --icons --ignore-glob ".git*"'
alias tree-git='eza -T -a --icons'
alias cat='bat'
