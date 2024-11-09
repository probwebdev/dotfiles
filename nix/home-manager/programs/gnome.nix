{
  config,
  pkgs,
  ...
}: {
  home.file = {
    # Flatpak theming workaround
    morewaita-icon-theme = {
      enable = true;
      recursive = true;
      source = config.lib.file.mkOutOfStoreSymlink "${pkgs.morewaita-icon-theme}/share/icons/MoreWaita";
      target = "${config.xdg.dataHome}/icons/MoreWaita";
    };
  };
  # Enable Home Manager set Gnome specific settings
  dconf.settings = {
    "org/gnome/desktop/calendar" = {
      show-weekdate = true;
    };
    "org/gnome/desktop/datetime" = {
      automatic-timezone = true;
    };
    "org/gnome/desktop/interface" = {
      clock-show-weekday = true;
      document-font-name = "Inter 11";
      font-name = "Inter Medium 11";
      monospace-font-name = "Source Code Pro Medium 12";
      text-scaling-factor = 1;
    };
  };
  gtk.enable = true;
  gtk.iconTheme = {
    package = pkgs.morewaita-icon-theme;
    name = "MoreWaita";
  };
}
