# completion.zsh

zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' max-errors 6 numeric
zstyle :compinstall filename '/home/thymajesty/.zshrc'
autoload -Uz compinit
compinit


# Greyed out suggestions
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd completion)
ZSH_AUTOSUGGEST_HISTORY_IGNORE=("cd" "ls")
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
