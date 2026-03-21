{
  pkgs,
  username,
  ...
}: {
  imports = [
    ./common.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";

  home.packages = with pkgs; [
    mkcert
    nss_latest
    nss_latest.tools
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {};

  home.sessionVariables = {
    # EDITOR = "emacs";
  };
  targets.genericLinux.enable = true;
  targets.genericLinux.gpu.enable = false;
}
