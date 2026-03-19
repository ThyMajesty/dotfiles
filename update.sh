#!/bin/sh
DOTFILES="$PWD"
echo "$DOTFILES"

# ── VSCodium extensions ───────────────────────────────────────────
if command -v codium &> /dev/null; then
  echo "Dumping VSCodium extensions..."
  codium --list-extensions > "$DOTFILES/shared/codium-extensions.txt"
fi