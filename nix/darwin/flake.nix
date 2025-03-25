{
  description = "Probwebdev Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
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
    username = "RHARBUL";
    configuration = {pkgs, ...}: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = with pkgs; [
      ];

      homebrew = {
        enable = true;
        brews = [
          "gnupg"
          "pinentry-mac"
        ];
        casks = [
          "alacritty"
          "1password"
          "jetbrains-toolbox"
          "google-chrome"
          "firefox"
          "discord"
          "telegram"
          "spotify"
          "hoppscotch"
          "zed"
        ];
        onActivation.cleanup = "zap";
      };

      # MacOS defaults
      system.defaults = {
        # requires logout to take effect
        trackpad.Clicking = true;
      };

      # Create /etc/zshrc that loads the nix-darwin environment.
      programs.zsh.enable = true; # default shell on catalina
      programs.zsh.enableCompletion = false;
      programs.zsh.enableBashCompletion = false;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

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
