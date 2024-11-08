# dotfiles

Quick and organised way to use/re-use environment setup.\
This setup relies on usage of [nix](https://nixos.org/) via [Determinate Installer](https://github.com/DeterminateSystems/nix-installer?tab=readme-ov-file#install-nix).

## Pre-requisites

### Quick installation:

Install `nix`:

```shell
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | \
  sh -s -- install
```

Fedora

```shell
# shell tools
dnf install alacritty git
```

## Using dotfiles

After pre-requisites installed do this from home directory:

```shell
# Clone dotfiles repo
git clone git@github.com:probwebdev/dotfiles.git .dotfiles

# Fedora
nix run home-manager/master -- switch --flake ~/.dotfiles/nix/home-manager\#t495
home-manager switch --flake ~/.dotfiles/nix/home-manager -b backup

# MacOS
nix run nix-darwin -- switch --flake ~/.dotfiles/nix/darwin\#mbp
```

To update packages via `nix` use:

```shell
# Fedora
nix flake update --flake ~/.dotfiles/nix/home-manager # optional to update flake.lock and refetch latest nixpkgs
home-manager switch --flake ~/.dotfiles/nix/home-manager#t495

# MacOS
nix flake update --flake ~/.dotfiles/nix/darwin # optional to update flake.lock and refetch latest nixpgks
darwin-rebuild switch --flake ~/.dotfiles/nix/darwin#mbp
```

To clean up old generations, store or garbage use:

```shell
home-manager expire-generations "-3 days" # remove old generations for home manger
sudo nix-collect-garbage --delete-older-than 3d # remove old generations and cleanup nix for darwin
# or
nix-store --gc # clean up store
nix-collect-garbage -d # collect garbage
sudo nix-collect-garbage -d # collect system garbage
```

## User zsh completions

It's possible to automatically load custom completions from `USER_ZSH_SITE_FUNCTIONS`(e.g `~/.local/share/zsh/site-functions`).\
Simply add your completion files to the dir or generate it with your tool e.g. `proto completions > ~/.local/share/zsh/site-functions/_proto` and reload terminal session.

## Nix formatting

To prettify `*.nix` files you can use:

```shell
nix run nixpkgs#alejandra -- ~/.dotfiles/nix
```
