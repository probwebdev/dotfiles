{...}: {
  programs.alacritty = {
    enable = true;
    settings = {
      general = {
        import = [
          "~/.config/alacritty/custom.toml"
        ];
      };
      env = {
        TERM = "xterm-256color";
      };
      window = {
        dimensions = {
          columns = 112;
          lines = 30;
        };
        padding = {
          x = 8;
          y = 8;
        };
        decorations_theme_variant = "Dark";
        resize_increments = true;
      };
      font = {
        size = 16.00;
        normal = {
          family = "Iosevka Term";
          style = "Medium Extended";
        };
        bold = {style = "Bold Extended";};
        bold_italic = {style = "Bold Extended Italic";};
      };
      cursor = {
        style = {blinking = "On";};
      };
      colors = {
        primary = {
          background = "#282c34";
          foreground = "#abb2bf";
        };
        normal = {
          black = "#1e2127";
          red = "#e06c75";
          green = "#98c379";
          yellow = "#e5c07b";
          blue = "#61afef";
          magenta = "#c678dd";
          cyan = "#56b6c2";
          white = "#abb2bf";
        };
        bright = {
          black = "#5c6370";
          red = "#e06c75";
          green = "#98c379";
          yellow = "#d19a66";
          blue = "#61afef";
          magenta = "#c678dd";
          cyan = "#56b6c2";
          white = "#ffffff";
        };
      };
    };
  };
}
