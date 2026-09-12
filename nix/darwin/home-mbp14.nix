{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../home-manager/common.nix
    ../home-manager/desktop.nix
    ../home-manager/dev.nix
  ];

  home.file = {};

  home.sessionVariables = {};
}
