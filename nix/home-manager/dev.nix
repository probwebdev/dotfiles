{
  config,
  pkgs,
  ...
}: {
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

  home.file = {
    "${config.xdg.configHome}/ghostty/config".source = .config/ghostty/config;
    "${config.xdg.configHome}/ghostty/themes/OneDark".source = .config/ghostty/themes/OneDark;
  };
}
