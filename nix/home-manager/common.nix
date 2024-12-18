{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./programs/alacritty.nix
    ./programs/bat.nix
    ./programs/direnv.nix
    ./programs/git.nix
    ./programs/shell.nix
    ./programs/starship.nix
  ];

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    git
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
    btop
    lesspipe
    nil
    nixd
    inter
    iosevka-bin
    monaspace
    ibm-plex
    source-sans
    source-code-pro
    jetbrains-mono
    noto-fonts-color-emoji
    noto-fonts-monochrome-emoji
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
    "${config.xdg.configHome}/nixpkgs/config.nix".source = ./nixpkgs-config.nix;
    "${config.xdg.configHome}/delta/themes.gitconfig".source = .config/delta/themes.gitconfig;
    "${config.xdg.configHome}/nvim/init.vim".source = .config/nvim/init.vim;
    "${config.xdg.configHome}/tlrc/config.toml".source = .config/tlrc/config.toml;
    "${config.xdg.configHome}/tmux/tmux.conf".source = .config/tmux/tmux.conf;
    "${config.xdg.dataHome}/zsh/fzf-preview.zsh".source = .local/share/zsh/fzf-preview.zsh;
    "${config.xdg.dataHome}/zsh/zstyle.zsh".source = .local/share/zsh/zstyle.zsh;
    ".local/bin/fzf-preview-all".source = .local/bin/fzf-preview-all;
    ".zimrc".source = ./.zimrc;
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

  # Enable Home Manager to discover and manange fonts
  fonts.fontconfig.enable = true;

  nix.gc.automatic = true;
  nix.gc.options = "--delete-older-than 3d";
  nix.settings = {
    allow-dirty = true;
    experimental-features = ["nix-command" "flakes"];
  };
  nixpkgs.config = import ./nixpkgs-config.nix;
}
