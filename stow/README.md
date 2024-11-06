# dotfiles using stow (deprecated)

## NOTE:
**This setup was deprecated in favor of [Nix](https://nixos.org/).\
It allows to have more stable, predictable and configurable dotfiles setup. This configuration will stay for history purposes.**

Quick and organised way to use/re-use environment setup.\
This setup relies on usage of [stow](https://www.gnu.org/software/stow/).

[**Homebrew**](https://brew.sh/) is considered optional and configuration should be sourced manually. On Fedora it's better to use built-in package manager instead.

## Pre-requisites

### Quick installation:

Fedora

```shell
# shell tools
dnf copr enable atim/starship
dnf install alacritty starship stow zoxide fzf fd-find bat eza git-delta tmux neovim direnv
# Homebrew (optional)
brew install alacritty starship stow zoxide fzf fd-find bat eza git-delta tmux neovim direnv tlrc lesspipe
```

## Use dotfiles

After pre-requisites installed do this from your home directory:

```shell
git clone git@github.com:probwebdev/dotfiles.git .dotfiles
cd dotfiles/stow
stow .
```

Look for existing files and either remove them or move to a backup folder. Alternatively run `stow --adopt .` to adopt existing configuration files.   
To stow new files run this from dotfiles `stow --restow .`

## User zsh completions
It's possible to automatically load custom completions from `USER_ZSH_SITE_FUNCTIONS`(e.g `~/.local/share/zsh/site-functions`).   
Simply add your completion files to the dir or generate it with your tool e.g `proto completions > ~/.local/share/zsh/site-functions/_proto` and reload terminal session.