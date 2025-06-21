{
  description = "Probwebdev Linux system flake";

  inputs = {
    #nixgl.url = "github:nix-community/nixGL";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    home-manager,
    nixpkgs,
    #nixgl,
  }: let
    username = "roberth";
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = import ./nixpkgs-config.nix;
    };
  in {
    # Build linux flake using:
    # $ home-manager switch --flake ~/.dotfiles/nix/home-manager#t495
    homeConfigurations."t495" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [./home.nix];
      extraSpecialArgs = {
        inherit username;
        #inherit nixgl;
      };
    };
  };
}
