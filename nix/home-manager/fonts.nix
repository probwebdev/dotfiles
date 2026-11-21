{pkgs, ...}: {
  home.packages = with pkgs; [
    source-sans
    inter
    iosevka-bin
    noto-fonts-color-emoji
    noto-fonts-monochrome-emoji
  ];
  fonts.fontconfig.enable = true;
}
