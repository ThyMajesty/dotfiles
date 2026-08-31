# Utility

# unarchive and touch after to bump modif time
unpack() {
  if [[ -z "$1" ]]; then
    echo "Usage: unpack <archive> [dest_dir]"
    echo "  Supported: .zip .tar.gz .tgz .tar .7z .rar"
    return 1
  fi

  local archive="$1"
  local default_dest

  case "$archive" in
    *.tar.gz) default_dest="${archive%.tar.gz}" ;;
    *.tgz)    default_dest="${archive%.tgz}" ;;
    *)        default_dest="${archive%.*}" ;;
  esac

  local dest="${2:-$default_dest}"
  mkdir -p "$dest"

  case "$archive" in
    *.zip) unzip "$archive" -d "$dest" ;;
    *.tar.gz|*.tgz) tar xzf "$archive" -C "$dest" ;;
    *.tar) tar xf "$archive" -C "$dest" ;;
    *.7z) 7z x "$archive" -o"$dest" ;;
    *.rar) unrar x "$archive" "$dest" ;;
    *) echo "Unrecognized archive type: $archive"; return 1 ;;
  esac
  find "$dest" -exec touch {} +
}