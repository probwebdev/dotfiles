{pkgs, ...}: {
  programs.ghostty = {
    enable = true;
    package = pkgs.emptyDirectory;
    enableZshIntegration = true;
    installBatSyntax = false;
    settings = {
      term  = "xterm-256color";
      theme = "OneDark";
      font-size = 16.00;
      font-family = "Iosevka Term";
      font-style = "Medium Extended";
      font-style-bold = "Bold Extended";
      font-style-bold-italic = "Bold Extended Italic";
      font-feature = ["-calt" "-liga" "-dlig"];
      cursor-style-blink = true;
      window-width = 112;
      window-height = 34;
      window-padding-x = 8;
      window-padding-y = 8;
      window-save-state = "always";
      config-file = "?~/.config/ghostty/custom";
    };
    themes = {
      OneDark = {
        background = "#282c34";
        foreground = "#abb2bf";
        palette = [
          "0=#1e2127"
          "1=#e06c75"
          "2=#98c379"
          "3=#e5c07b"
          "4=#61afef"
          "5=#c678dd"
          "6=#56b6c2"
          "7=#abb2bf"
          "8=#5c6370"
          "9=#e06c75"
          "10=#98c379"
          "11=#d19a66"
          "12=#61afef"
          "13=#c678dd"
          "14=#56b6c2"
          "15=#ffffff"
        ];
      };
    };
  };
}
