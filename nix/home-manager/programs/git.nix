{...}: {
  programs.git.enable = true;
  programs.git.signing = {
    format = "openpgp";
    signByDefault = true;
    signer = "gpg";
  };
  programs.git.settings = {
    core = {
      autocrlf = "input";
      quotepath = false;
      editor = "nvim";
      pager = "delta";
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
