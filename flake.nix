{
  description = "My NixOS configuration";

  
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nur.url = "github:nix-community/NUR";
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

  };
};

  outputs = { nixpkgs, nixos-hardware, ... }@inputs:
  let

    ## Global variables used throughout the configuration
    globals = rec {
      user = "malu";
      gh-user = "veri-tty";
    
    };

    
    supportedSystems = [ "x86_64-linux" ];
    forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

  in rec {

    ## System configurations
    nixosConfigurations = {
      roamer = import ./machines/roamer.nix { inherit inputs globals nixpkgs nixos-hardware overlays; };
    };

    ## Home configurations
    homeConfigurations = {
      roamer = nixosConfigurations.roamer.config.home-manager.users.${globals.user}.home;
    };
  };
}