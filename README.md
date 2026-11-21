# dotfiles

Quick and organized way to use/re-use environment setup.\
This setup relies on usage of [nix](https://nixos.org/) via [Determinate Installer](https://github.com/DeterminateSystems/nix-installer?tab=readme-ov-file#install-nix).

## Pre-requisites

### Quick installation:

Install `nix`:

```shell
# To install Determinate Nix (recommended)
curl -fsSL https://install.determinate.systems/nix | sh -s -- install --determinate

# or to install upstream Nix
curl -fsSL https://install.determinate.systems/nix | sh -s -- install
```

Fedora

```shell
# shell tools
dnf install alacritty git
```

## Using dotfiles

After pre-requisites installed, do this from home directory:

```shell
# Clone dotfiles repo
git clone git@github.com:probwebdev/dotfiles.git .dotfiles

# Fedora
nix run home-manager/master -- switch --flake ~/.dotfiles/nix/home-manager\#t495
home-manager switch --flake ~/.dotfiles/nix/home-manager\#t495 -b backup

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

To upgrade `nix` itself use:

```shell
# If Determinate Nix was installed
sudo determinate-nixd login
sudo determinate-nixd upgrade

# or if upstream Nix was installed
sudo -i nix upgrade-nix
```

### SteamOS

Run setup in Desktop Mode as the SteamOS user (`deck` by default). The account
must have a password for `sudo`; set one with `passwd` if needed. If your username
differs, update the `steamos` entry in `nix/home-manager/flake.nix`.

For a new Nix installation, use the
[Determinate installer's Steam Deck planner](https://github.com/DeterminateSystems/nix-installer):

```shell
curl -fsSL https://install.determinate.systems/nix | sh -s -- install steam-deck
```

Open a new terminal after installation. Clone this repository to `~/.dotfiles`
using the instructions above, then activate the SteamOS configuration:

```shell
nix run home-manager/master -- switch --flake ~/.dotfiles/nix/home-manager#steamos -b backup
zsh
dotfiles-setup
```

`dotfiles-setup` explicitly installs ZIM shell plugins and the tmux plugin manager;
it requires Git, curl, and network access. Opening a shell does not install them.

Ghostty is configured but **not installed** by Home Manager (`package = null`).
Supply it separately using a SteamOS-compatible installation, or use an existing
terminal such as Konsole and run `zsh` there. GPU integration is disabled because
this profile relies on externally installed graphical applications. Revisit that
setting before adding Nix GUI applications; see
[Home Manager's GPU guide](https://nix-community.github.io/home-manager/usage/gpu-non-nixos.html).

The SteamOS profile includes shared command-line tools, Iosevka and color emoji
fonts, and Ghostty settings. It omits the development profile and extra desktop
fonts. Automatic garbage collection removes Home Manager generations older than
14 days on all hosts.

For subsequent activations:

```shell
home-manager switch --flake ~/.dotfiles/nix/home-manager#steamos
```

#### After a SteamOS update

The installer's
[Steam Deck planner](https://github.com/DeterminateSystems/nix-installer/blob/main/src/planner/steam_deck.rs)
handles persistent storage and update integration. Update survival has not been
verified on this device. After rebooting, check Nix before activating dotfiles:

```shell
nix --version
nix store ping
```

If Nix is missing or the store is unavailable, check `systemctl status nix.mount`
and consult the
[installer troubleshooting guide](https://github.com/DeterminateSystems/nix-installer/blob/main/docs/troubleshooting.md).
Restore the existing Nix installation before running Home Manager; do not delete
the store or uninstall Nix as a first recovery step. Recheck externally installed
Ghostty separately.

To recover from a bad Home Manager activation, list surviving generations and
run the previous generation's activation script using its path from the output:

```shell
home-manager generations
/path/to/previous-generation/activate
```

Only generations that have not been garbage-collected remain available.

## User zsh completions

It's possible to automatically load custom completions from `USER_ZSH_SITE_FUNCTIONS`(e.g `~/.local/share/zsh/site-functions`).\
Simply add your completion files to the dir or generate it with your tool e.g. `proto completions > ~/.local/share/zsh/site-functions/_proto` and reload terminal session.

## Nix specifics

### Fonts managed by home-manager

For flatpak apps makes sense to provide additional access:

```shell
flatpak override --user --filesystem=/nix/store:ro --filesystem=xdg-data/fonts:ro --filesystem=xdg-config/fontconfig:ro
```

### Garbage collection

Home Manager automatically collects generations older than 14 days on all hosts.
To run cleanup manually with the same retention:

```shell
home-manager expire-generations "-14 days" # remove old Home Manager generations
sudo nix-collect-garbage --delete-older-than 14d # remove old generations and clean up Nix for Darwin
nix-store --gc # collect store paths no longer referenced by any generation
```

### Formatting

To prettify `*.nix` files you can use:

```shell
nix run nixpkgs#alejandra -- ~/.dotfiles/nix
```
