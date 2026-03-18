# ~/.zshrc

####################
# ZSH BOOTSTRAP
####################

# Zsh-specific paths
ZSH_CONFIG="$HOME/.config/zsh"
ZSH_CACHE="$HOME/.cache/zsh"

HISTFILE="$ZSH_CACHE/.histfile"
HISTSIZE=10000
SAVEHIST=10000

# Ensure dirs & files exist
mkdir -p "$ZSH_CONFIG" "$ZSH_CACHE"

ZSH_MODULES=(
  env
  options
  aliases
  keybinds
  completion
)

# Modules: Create if none; Load in order
for module in $ZSH_MODULES; do
  [[ -f "$ZSH_CONFIG/$module.zsh" ]] || echo "# $module.zsh" > "$ZSH_CONFIG/$module.zsh"
  source "$ZSH_CONFIG/$module.zsh"
done

# Prompt setup
autoload -U colors && colors
setopt PROMPT_SUBST

# Starship
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
else
  PROMPT='%F{cyan}%n@%m%f:%F{yellow}%~%f %# '
fi
