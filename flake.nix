{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nur.url = "github:nix-community/NUR";
  };

  outputs = {
    nixpkgs,
    nixos-hardware,
    ...
  } @ inputs: let
    supportedSystems = ["x86_64-linux"];
    forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
  in rec {
    ## System configurations
    nixosConfigurations = {
      roamer = import ./machines/roamer.nix {inherit inputs nixpkgs nixos-hardware;};
    };

    ## Home configurations
    homeConfigurations = {
      roamer = nixosConfigurations.roamer.config.home-manager.users.ml.home;
    };
  };
}
