{
  description = "Probwebdev Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ {
    self,
    nix-darwin,
    nix-homebrew,
    home-manager,
    nixpkgs,
  }: let
    username = "rharbul";
    configuration = {pkgs, ...}: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = with pkgs; [
      ];

      homebrew = {
        enable = true;
        taps = [
          "Azure/homebrew-functions"
        ];
        brews = [
          "xz"
          "gnupg"
          "pinentry-mac"
          "azure-cli"
          "azure-functions-core-tools@4"
        ];
        casks = [
          "affinity"
          "ghostty"
          "bruno"
          "claude"
          "claude-code"
          "chatgpt"
          "codex"
          "docker-desktop"
          "devtoys"
          "1password"
          "bitwarden"
          "jetbrains-toolbox"
          "google-chrome"
          "firefox"
          "discord"
          "telegram"
          "spotify"
          "visual-studio-code"
          "zed"
          "dotnet-sdk"
          "microsoft-auto-update"
          "microsoft-outlook"
          "microsoft-teams"
        ];
        onActivation.cleanup = "zap";
      };

      # MacOS defaults
      system.primaryUser = "${username}";
      system.defaults = {
        # requires logout to take effect
        trackpad.Clicking = true;
        # dock settings
        dock.minimize-to-application = true;
        dock.show-recents = false;
        dock.scroll-to-open = true;
      };

      # Create /etc/zshrc that loads the nix-darwin environment.
      programs.zsh.enable = true; # default shell on catalina
      programs.zsh.enableCompletion = false;
      programs.zsh.enableBashCompletion = false;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      # Disable nix management by nix-darwin as Determinate Nix is used
      nix.enable = false;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
      nixpkgs.config.allowUnfree = true;

      nix-homebrew = {
        enable = true;
        enableRosetta = true;
        user = "${username}";
      };

      home-manager = {
        useGlobalPkgs = false;
        useUserPackages = true;
        backupFileExtension = "backup";
        extraSpecialArgs = {
          inherit username;
        };
        users."${username}" = import ./home.nix;
      };

      users.users.${username}.home = "/Users/${username}";
    };
  in {
    # Build darwin flake using:
    # $ darwin-rebuild switch --flake ~/.dotfiles/nix/darwin#mbp
    darwinConfigurations."mbp" = nix-darwin.lib.darwinSystem {
      modules = [
        nix-homebrew.darwinModules.nix-homebrew
        home-manager.darwinModules.home-manager
        configuration
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."mbp".pkgs;
  };
}
