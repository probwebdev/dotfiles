{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "roberth";
  home.homeDirectory = "/home/roberth";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs;
  [
    git
    stow
    neovim
    fzf
    tmux
    fd
    starship
    zoxide
    bat
    eza
    delta
    direnv
    dprint
    tlrc
    lesspipe
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
    ".config/alacritty/alacritty.toml".source = .config/alacritty/alacritty.toml;
    ".config/alacritty/app.toml".source = .config/alacritty/app.toml;
    ".config/alacritty/custom.toml".source = .config/alacritty/custom.toml;
    ".config/alacritty/theme.toml".source = .config/alacritty/theme.toml;
    ".config/delta/themes.gitconfig".source = .config/delta/themes.gitconfig;
    ".config/nvim/init.vim".source = .config/nvim/init.vim;
    ".config/tlrc/config.toml".source = .config/tlrc/config.toml;
    ".config/tmux/tmux.conf".source = .config/tmux/tmux.conf;
    ".config/starship.toml".source = .config/starship.toml;
    ".local/bin/fzf-preview-all".source = .local/bin/fzf-preview-all;
    ".local/share/zsh/fzf-preview.zsh".source = .local/share/zsh/fzf-preview.zsh;
    ".local/share/zsh/zstyle.zsh".source = .local/share/zsh/zstyle.zsh;
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/roberth/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  nix.package = pkgs.nix;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
    allow-dirty = true
  '';

  # Home Manager has an option
  # to automatically set some environment variables
  # that will ease usage of software installed
  # with nix on non-NixOS linux
  # (fixing local issues, settings XDG_DATA_DIRS, etc.)
  targets.genericLinux.enable = true;

  imports = [
    ./programs/bat.nix
    ./programs/direnv.nix
    ./programs/git.nix
  ];
}
