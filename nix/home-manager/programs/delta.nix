{...}: {
  programs.delta.enable = true;
  programs.delta.enableGitIntegration = true;
  programs.delta.options = {
    features = "mellow-barbet";
    navigate = true;
    dark = true;
    light = false;
    line-numbers = true;
    side-by-side = false;
  };
}
