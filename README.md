# dotfiles

Managed with Stow.

## Structure
```
dotfiles/
├── shared/          # configs for all machines
├── tmhost/          # TMHost specific
│   └── .stowrc      # stow config for TMHost
├── tmsubber/        # TMSubber specific
│   └── .stowrc      # stow config for TMSubber
├── packages/
│   ├── shared.txt   # packages installed on all machines
│   ├── tmhost.txt   # TMHost specific packages
│   └── tmsubber.txt # TMSubber specific packages
└── install.sh       # bootstrap script
```
## Initial Setup (fresh Arch install)

Make sure `git` and `base-devel` are installed, then:

    git clone https://github.com/ThyMajesty/dotfiles.git
    cd dotfiles
    ./install.sh

install.sh uses PWD so we need to be in the correct location

The script will:
- Install `yay` if missing
- Install `stow` if missing
- Install packages from `packages/shared.txt` and `packages/<hostname>.txt`
- Symlink host-specific `.stowrc` to `~/.stowrc` if not present
- Stow shared and host-specific configs (repo wins on conflict)
- Install VSCodium extensions

Note: After first run `.stowrc` will be symlinked to `~/.stowrc`,
enabling bare `stow` commands from any directory.

## Daily Usage

Add a new config:

    mv ~/.config/something <location>/dotfiles/shared/.config/
    stow shared

Update a config — symlink, changes are reflected in the repo.

Restow after adding/removing files:

    stow -R shared

Sync to another machine:

    git pull
    stow -R shared

## Updating

After installing new VSCodium extensions or anything that needs re-dumping:

    cd dotfiles
    ./update.sh

On the other end:

    cd dotfiles
    git pull
    ./install.sh
