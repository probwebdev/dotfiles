{
  username,
  ...
}: {
  imports = [
    ./common.nix
    ./desktop.nix
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";

  targets.genericLinux.enable = true;
  # Ghostty uses the system installation and its graphics libraries.
  targets.genericLinux.gpu.enable = false;
}
