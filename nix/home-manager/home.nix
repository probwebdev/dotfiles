{
  config,
  lib,
  pkgs,
  username,
  ...
}: {
  imports = [
    ./common.nix
    ./programs/gnome.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";

  home.packages = with pkgs; [];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {};

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Home Manager has an option
  # to automatically set some environment variables
  # that will ease usage of software installed
  # with nix on non-NixOS linux
  # (fixing local issues, settings XDG_DATA_DIRS, etc.)
  targets.genericLinux.enable = true;

  # Hack: Don't install git over system pkg
  programs.git.package = pkgs.emptyDirectory;

  # Alacritty home-manager overrides
  programs.alacritty.settings = {
    font = {
      size = lib.mkForce 12.00;
    };
  };
}
