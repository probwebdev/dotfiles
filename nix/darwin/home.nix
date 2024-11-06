{ config, pkgs, ... }:

{
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/alacritty/custom.toml".source = .config/alacritty/custom.toml;
  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  imports = [
    ../home-manager/common.nix
  ];
}
