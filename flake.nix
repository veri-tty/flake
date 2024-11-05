{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    schizofox.url = "github:schizofox/schizofox";
    nur.url = "github:nix-community/NUR";
  };

  outputs = {
    nixpkgs,
    nixos-hardware,
    ...
  } @ inputs: let
    globals = {
      user = "ml";
      stateVers = "24.05";
    };
    overlays = [
      inputs.nur.overlay
      inputs.schizofox.homeManagerModules.default
    ];

    supportedSystems = ["x86_64-linux"];
    forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
  in rec {
    ## System configurations
    nixosConfigurations = {
      roamer = import ./machines/roamer.nix {inherit inputs globals nixpkgs nixos-hardware;};
    };

    ## Home configurations
    homeConfigurations = {
      roamer = nixosConfigurations.roamer.config.home-manager.users.${globals.user}.home;
    };
  };
}
