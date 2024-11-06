{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "roberth";
  home.homeDirectory = "/home/roberth";

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs;
  [
    git
    neovim
    fzf
    tmux
    fd
    starship
    zoxide
    bat
    eza
    delta
    direnv
    dprint
    tlrc
    lesspipe
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/alacritty/custom.toml".source = .config/alacritty/custom.toml;
  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Home Manager has an option
  # to automatically set some environment variables
  # that will ease usage of software installed
  # with nix on non-NixOS linux
  # (fixing local issues, settings XDG_DATA_DIRS, etc.)
  targets.genericLinux.enable = true;

  imports = [
    ./common.nix
  ];
}
