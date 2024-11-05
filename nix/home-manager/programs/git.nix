{ ... }:

{
  programs.git.delta.enable = true;
  programs.git.delta.options = {
    features = "mellow-barbet";
    navigate = true;
    dark = true;
    light = false;
    line-numbers = true;
    side-by-side = false;
  };
  programs.git.enable = true;
  programs.git.extraConfig = {
    include = {
      path = "~/.config/delta/themes.gitconfig";
    };
    core = {
      autocrlf = "input";
      quotepath = false;
      editor = "nvim";
    };
    commit = {
      gpgsign = true;
    };
    protocol = {
      version = 2;
    };
    pull = {
      ff = "only";
    };
    init = {
      defaultBranch = "main";
    };
    push = {
      autoSetupRemote = true;
    };
    merge = {
      conflictstyle = "diff3";
    };
    diff = {
      colorMoved = "default";
    };
  };
}
