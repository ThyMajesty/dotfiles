#!/bin/sh
set -e

DOTFILES="$HOME/Documents/dev/misc/dotfiles"
HOST=$(hostnamectl hostname | tr '[:upper:]' '[:lower:]')

# ── yay check ─────────────────────────────────────────────────────
if ! command -v yay &> /dev/null; then
  echo "yay not found, installing..."
  sudo pacman -S --needed --noconfirm git base-devel
  git clone https://aur.archlinux.org/yay.git /tmp/yay
  cd /tmp/yay && makepkg -si --noconfirm
  cd "$DOTFILES"
fi

# ── stow check ────────────────────────────────────────────────────
if ! command -v stow &> /dev/null; then
  yay -S --needed --noconfirm stow
fi

# ── packages ──────────────────────────────────────────────────────
echo "Installing shared packages..."
yay -S --needed --noconfirm - < "$DOTFILES/packages/shared.txt"

if [ -f "$DOTFILES/packages/$HOST.txt" ]; then
  echo "Installing $HOST packages..."
  yay -S --needed --noconfirm - < "$DOTFILES/packages/$HOST.txt"
fi

# ── stow ──────────────────────────────────────────────────────────
echo "Stowing shared..."
stow --adopt shared && git -C "$DOTFILES" checkout -- .

if [ -d "$DOTFILES/$HOST" ]; then
  echo "Stowing $HOST..."
  stow --adopt "$HOST" && git -C "$DOTFILES" checkout -- .
fi

# ── VSCodium extensions ───────────────────────────────────────────
if command -v codium &> /dev/null; then
  echo "Installing VSCodium extensions..."
  while IFS= read -r ext; do
    codium --install-extension "$ext"
  done < "$DOTFILES/shared/codium-extensions.txt"
fi

echo "Done."
