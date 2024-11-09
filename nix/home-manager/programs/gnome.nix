{pkgs, ...}: {
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
      icon-theme = "MoreWaita";
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
