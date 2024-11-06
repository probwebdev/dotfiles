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

  outputs = inputs@{ self, nix-darwin, nix-homebrew, home-manager, nixpkgs }:
  let
    username = "RHARBUL";
    configuration = { pkgs, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = with pkgs;
      [
        alacritty
        gnupg
      ];

      homebrew = {
        enable = true;
        brews = [
          "pinentry-mac"
        ];
        casks = [
          "jetbrains-toolbox"
          "firefox"
          "discord"
          "telegram"
          "spotify"
          "hoppscotch"
        ];
        onActivation.cleanup = "zap";
      };

      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;
      # nix.package = pkgs.nix;

      # Necessary for using flakes on this system.
      #nix.settings.experimental-features = "nix-command flakes";

      # Create /etc/zshrc that loads the nix-darwin environment.
      programs.zsh.enable = true;  # default shell on catalina
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
        useGlobalPkgs = true;
        useUserPackages = true;
        users."${username}" = import ./home.nix;
      };

      users.users.${username}.home = "/Users/${username}";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#mbp
    darwinConfigurations."mbp" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        nix-homebrew.darwinModules.nix-homebrew
        home-manager.darwinModules.home-manager
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."mbp".pkgs;
  };
}
