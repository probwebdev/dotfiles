{pkgs, ...}: {
  home.packages = with pkgs; [
    dprint
    imagemagick
    gh
    mkcert
    nss_latest
    nss_latest.tools
    nil
    nixd
    alejandra
  ];
}
