{pkgs, ...}: {
  imports = [./programs/ghostty.nix];

  home.packages = with pkgs; [
    inter
    iosevka-bin
    monaspace
    ibm-plex
    source-sans
    source-code-pro
    jetbrains-mono
    noto-fonts-color-emoji
    noto-fonts-monochrome-emoji
  ];
  fonts.fontconfig.enable = true;
}
