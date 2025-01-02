{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    schizofox.url = "github:schizofox/schizofox";
    nur.url = "github:nix-community/NUR";
    nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";
    stylix.url = "github:danth/stylix";
    nixos-grub-themes.url = "github:jeslie0/nixos-grub-themes";
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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

    supportedSystems = ["x86_64-linux"];
    forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    specialArgs = {inherit inputs;}; # pass the inputs into the configuration module
  in rec {
    ## System configurations
    nixosConfigurations = {
      roamer = import ./machines/roamer.nix {inherit inputs globals nixpkgs nixos-hardware;};
    };
    nixosConfigurations = {
      cathedral = import ./machines/cathedral.nix {inherit inputs globals nixpkgs nixos-hardware;};
    };

    ## Home configurations
    homeConfigurations = {
      roamer = nixosConfigurations.roamer.config.home-manager.users.${globals.user}.home;
    };
    homeConfigurations = {
      cathedral = nixosConfigurations.cathedral.config.home-manager.users.${globals.user}.home;
    };
  };
}
