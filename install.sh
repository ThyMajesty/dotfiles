#!/bin/sh
set -e

DOTFILES="$PWD"
HOST=$(hostnamectl hostname | tr '[:upper:]' '[:lower:]')

help() {
  echo "Usage: $0 [flags]"
  echo ""
  echo "  -h  Help"
  echo "  -i  Initial setup (yay, stow)"
  echo "  -p  Install packages (need root)"
  echo "  -s  Stow configs"
  echo "  -r  Root overrides (need root)"
  echo "  -v  VSCodium extensions"
  echo "  -e  Extract VSCodium extensions list"
  echo ""
  echo "  Example: $0 -ipsrv  (full install)"
  exit 0
}

do_initial() {
  # check if yay is present
  if ! command -v yay &> /dev/null; then
    echo "yay not found, installing..."
    sudo pacman -S --needed --noconfirm git base-devel
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay && makepkg -si --noconfirm
    cd "$DOTFILES"
  fi
  # check if stow present
  if ! command -v stow &> /dev/null; then
    yay -S --needed --noconfirm stow
  fi
}

do_packages() {
  echo "Installing shared packages..."
  yay -S --needed --noconfirm - < "$DOTFILES/packages/shared.txt"
  if [ -f "$DOTFILES/packages/$HOST.txt" ]; then
    echo "Installing $HOST packages..."
    yay -S --needed --noconfirm - < "$DOTFILES/packages/$HOST.txt"
  fi
}

do_stow() {
  echo "Stowing shared..."
  stow --target="$HOME" --dir="$DOTFILES" shared
  if [ -d "$DOTFILES/$HOST" ]; then
    echo "Stowing $HOST..."
    stow --adopt --target="$HOME" --dir="$DOTFILES" "$HOST"
  fi
}

do_root() {
  echo "Installing root overrides..."
  sudo rm -rf /usr/share/icons/Gruvbox-Plus-Dark-Override
  sudo cp -r "$DOTFILES/root-overrides/usr/share/icons/Gruvbox-Plus-Dark-Override" /usr/share/icons/
  sudo kbuildsycoca6
}

do_extract_vscodium() {
  if command -v codium &> /dev/null; then
    echo "Extracting VSCodium extensions list..."
    codium --list-extensions > "$DOTFILES/shared/codium-extensions.txt"
    count=$(wc -l < "$DOTFILES/shared/codium-extensions.txt")
    echo "Extracted $count extensions to shared/codium-extensions.txt."
  else
    echo "codium not found, skipping extraction."
  fi
}

do_vscodium() {
  if command -v codium &> /dev/null; then
    echo "Installing VSCodium extensions..."
    while IFS= read -r ext; do
      codium --install-extension "$ext"
    done < "$DOTFILES/shared/codium-extensions.txt"
  fi
}


# no args - print help
[ $# -eq 0 ] && help

RUN_INITIAL=0
RUN_PACKAGES=0
RUN_STOW=0
RUN_ROOT=0
RUN_VSCODIUM=0
RUN_EXTRACT_VSCODIUM=0

while getopts "hipsrve" opt; do
  case $opt in
    h) help ;;
    i) RUN_INITIAL=1 ;;
    p) RUN_PACKAGES=1 ;;
    s) RUN_STOW=1 ;;
    r) RUN_ROOT=1 ;;
    v) RUN_VSCODIUM=1 ;;
    e) RUN_EXTRACT_VSCODIUM=1 ;;
    *) help ;;
  esac
done

[ $RUN_INITIAL          -eq 1 ] && do_initial
[ $RUN_PACKAGES         -eq 1 ] && do_packages
[ $RUN_STOW             -eq 1 ] && do_stow
[ $RUN_ROOT             -eq 1 ] && do_root
[ $RUN_VSCODIUM         -eq 1 ] && do_vscodium
[ $RUN_EXTRACT_VSCODIUM -eq 1 ] && do_extract_vscodium

echo "Done."
