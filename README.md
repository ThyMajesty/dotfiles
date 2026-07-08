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
├── root-overrides   # dump to /. needed when used by a different user or needs su
├── packages/
│   ├── shared.txt   # packages installed on all machines
│   ├── tmhost.txt   # TMHost specific packages
│   └── tmsubber.txt # TMSubber specific packages
└── install.sh       # bootstrap script
```
## Initial Setup (fresh Arch install)

`git` and `base-devel` must be installed

    git clone https://github.com/ThyMajesty/dotfiles.git
    cd dotfiles
    ./install.sh -ipsrv

install.sh uses PWD so we need to be in the dotfiles root

## install.sh

Usage: ./install.sh [flags]
```
  -h  Help
  -i  Initial setup (yay, stow)
  -p  Install packages (need root)
  -s  Stow configs
  -r  Root overrides (need root)
  -v  VSCodium extensions
  -e  Extract VSCodium extensions list
```

Example (full install):
  
    ./install.sh -ipsrv

Note: After first run `.stowrc` will be symlinked to `~/.stowrc`, enabling bare `stow` commands from any directory. But it's safer/easier to use `install.sh -ipsrv` 

## Usage

### Update:
    git pull
    ./install.sh -psrv
Or any other combinations of flags

### Add:
Depends:
    - Root overrides are manual, see `install.sh`
    - For normal dotfiles either add to dotfiles and --restow/-R or --adopt
        
    stow -R shared
    stow -R hostname
