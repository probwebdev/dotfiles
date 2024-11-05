# dotfiles

Quick and organised way to use/re-use environment setup.\
This setup relies on usage of [stow](https://www.gnu.org/software/stow/) and [nix](https://nixos.org/).

## Pre-requisites

### Quick installation:

Fedora

```shell
# shell tools
dnf install alacritty stow git
```
Install `nix` via [determinate installer](https://github.com/DeterminateSystems/nix-installer?tab=readme-ov-file#install-nix):
```shell
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | \
  sh -s -- install
```

## Using dotfiles

After pre-requisites installed do this from your home directory:

```shell
git clone git@github.com:probwebdev/dotfiles.git .dotfiles
cd dotfiles
stow .
nix-channel --update
home-manager switch
```

To update packages via `nix` use:
```shell
nix-channel --update
nix flake update --flake ~/.dotfiles/nix/home-manager # to update flake
home-manager switch --flake ~/.dotfiles/nix/home-manager # --refresh could be used in addition
```

Look for existing files and either remove them or move to a backup folder. Alternatively run `stow --adopt .` to adopt existing configuration files.   
To stow new files run this from dotfiles `stow --restow .`

## User zsh completions
It's possible to automatically load custom completions from `USER_ZSH_SITE_FUNCTIONS`(e.g `~/.local/share/zsh/site-functions`).   
Simply add your completion files to the dir or generate it with your tool e.g. `proto completions > ~/.local/share/zsh/site-functions/_proto` and reload terminal session.