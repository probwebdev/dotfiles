{pkgs, ...}: let
  style = color: {
    inherit color;
    background = "default";
    bold = false;
    underline = false;
    italic = false;
    dim = false;
    strikethrough = false;
  };
in {
  # The pinned Home Manager has no tlrc program module.
  home.packages = [pkgs.tlrc];
  xdg.configFile."tlrc/config.toml".source = (pkgs.formats.toml {}).generate "tlrc-config" {
    cache = {
      mirror = "https://github.com/tldr-pages/tldr/releases/latest/download";
      auto_update = true;
      max_age = 336;
      languages = [];
    };
    output = {
      show_title = true;
      platform_title = false;
      show_hyphens = false;
      example_prefix = "- ";
      compact = true;
      raw_markdown = false;
    };
    indent = {
      title = 0;
      description = 0;
      bullet = 2;
      example = 4;
    };
    style = {
      title = (style "magenta") // {bold = true;};
      description = style "white";
      bullet = style "green";
      example = (style "magenta") // {bold = true;};
      url =
        (style "blue")
        // {
          underline = true;
          italic = true;
        };
      inline_code =
        (style "yellow")
        // {
          bold = true;
          italic = true;
        };
      placeholder = (style "red") // {italic = true;};
    };
  };
}
