# Utility

# unarchive and touch after to bump modif time
unpack() {
  local dest="${2:-.}"
  case "$1" in
    *.zip) unzip "$1" -d "$dest" ;;
    *.tar.gz|*.tgz) tar xzf "$1" -C "$dest" ;;
    *.tar) tar xf "$1" -C "$dest" ;;
    *.7z) 7z x "$1" -o"$dest" ;;
    *.rar) unrar x "$1" "$dest" ;;
  esac
  find "$dest" -exec touch {} +
}