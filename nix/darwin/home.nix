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

  # Alacritty darwin overrides
  programs.alacritty.settings = {
    window = {
      dimensions = lib.mkForce {
        columns = 118;
        lines = 34;
      };
      position = lib.mkForce {
        x = 350;
        y = 450;
      };
    };
  };
}
