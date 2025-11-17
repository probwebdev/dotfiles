{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../home-manager/common.nix
  ];

  home.packages = with pkgs; [
    git
    git-lfs
  ];

  home.file = {};

  home.sessionVariables = {};
}
