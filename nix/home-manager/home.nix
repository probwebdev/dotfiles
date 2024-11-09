{
  config,
  lib,
  pkgs,
  nixgl,
  ...
}: {
  imports = [
    ./common.nix
    ./programs/gnome.nix
  ];

  # Configure nixGL in order to run gui apps e.g. alacritty
  nixGL.packages = nixgl.packages;
  nixGL.defaultWrapper = "mesa";
  nixGL.offloadWrapper = "mesa";
  nixGL.installScripts = ["mesa"];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "roberth";
  home.homeDirectory = "/home/roberth";

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
  nix.package = pkgs.nix;

  # Alacritty home-manager overrides
  programs.alacritty.package = config.lib.nixGL.wrap pkgs.alacritty;
  programs.alacritty.settings = {
    font = {
      size = lib.mkForce 12.00;
    };
  };
}
